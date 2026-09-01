import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../core/di/injection.dart';
import '../../domain/usecases/post_new_product_use_case.dart';

class ProductFileImportResult {
  const ProductFileImportResult({
    required this.imported,
    required this.failed,
    required this.errors,
  });

  final int imported;
  final int failed;
  final List<String> errors;
}

class ProductFileImporter {
  ProductFileImporter._();

  static const requiredHeaders = <String>['categoryId', 'name', 'price'];

  static Future<ProductFileImportResult?> pickAndImport() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['csv', 'xlsx'],
      withData: true,
    );
    if (picked == null || picked.files.isEmpty) return null;

    final file = picked.files.single;
    final extension = (file.extension ?? '').toLowerCase();
    final bytes = file.bytes ??
        (file.path == null ? null : await File(file.path!).readAsBytes());
    if (bytes == null || bytes.isEmpty) {
      return const ProductFileImportResult(
        imported: 0,
        failed: 1,
        errors: ['تعذر قراءة الملف.'],
      );
    }

    final rows = extension == 'xlsx' ? _xlsxRows(bytes) : _csvRows(bytes);
    if (rows.isEmpty) {
      return const ProductFileImportResult(
        imported: 0,
        failed: 1,
        errors: ['الملف لا يحتوي على بيانات.'],
      );
    }

    final headers = rows.first.map((e) => e.trim()).toList();
    final missing = requiredHeaders
        .where((header) => !headers.contains(header))
        .toList();
    if (missing.isNotEmpty) {
      return ProductFileImportResult(
        imported: 0,
        failed: 1,
        errors: [
          'الأعمدة المطلوبة: ${requiredHeaders.join(', ')}. الأعمدة المفقودة: ${missing.join(', ')}',
        ],
      );
    }

    var imported = 0;
    var failed = 0;
    final errors = <String>[];
    final useCase = getIt<PostNewProductUseCase>();

    for (var index = 1; index < rows.length; index++) {
      final values = rows[index];
      if (values.every((value) => value.trim().isEmpty)) continue;
      final row = <String, String>{};
      for (var column = 0; column < headers.length; column++) {
        row[headers[column]] =
            column < values.length ? values[column].trim() : '';
      }

      final categoryId = int.tryParse(row['categoryId'] ?? '');
      final name = (row['name'] ?? '').trim();
      final price = double.tryParse((row['price'] ?? '').replaceAll(',', '.'));
      if (categoryId == null ||
          categoryId <= 0 ||
          name.isEmpty ||
          price == null ||
          price < 0) {
        failed++;
        errors.add(
          'السطر ${index + 1}: categoryId أو name أو price غير صالح.',
        );
        continue;
      }

      final result = await useCase(
        PostNewProductParams(
          categoryId: categoryId,
          name: name,
          desc: row['description'] ?? '',
          price: price.toString(),
          discountedPrice: row['discountedPrice'] ?? '',
          lowStock: row['lowStockThreshold'] ?? '',
          preparationTime: row['preparationTime'] ?? '',
        ),
      );

      result.fold(
        (failure) {
          failed++;
          errors.add('السطر ${index + 1} ($name): ${failure.message}');
        },
        (_) => imported++,
      );
    }

    return ProductFileImportResult(
      imported: imported,
      failed: failed,
      errors: errors,
    );
  }

  static List<List<String>> _csvRows(List<int> bytes) {
    final text = utf8.decode(bytes, allowMalformed: true);
    final decoded = const CsvToListConverter().convert(text);
    return decoded
        .map(
          (row) => row.map((value) => value?.toString() ?? '').toList(),
        )
        .toList();
  }

  static List<List<String>> _xlsxRows(List<int> bytes) {
    final workbook = Excel.decodeBytes(bytes);
    if (workbook.tables.isEmpty) return const [];
    final sheet = workbook.tables.values.first;
    return sheet.rows
        .map(
          (row) => row.map((cell) => cell?.value?.toString() ?? '').toList(),
        )
        .toList();
  }
}
