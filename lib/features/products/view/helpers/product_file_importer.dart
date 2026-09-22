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

  static const supportedExtensions = <String>{'csv', 'xlsx'};
  static const requiredHeaders = <String>['categoryId', 'name', 'price'];

  static ProductFileImportResult _failure(String message) {
    return ProductFileImportResult(imported: 0, failed: 1, errors: [message]);
  }

  static Future<ProductFileImportResult?> pickAndImport() async {
    FilePickerResult? picked;
    try {
      picked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: supportedExtensions.toList(),
        withData: true,
      );
    } catch (_) {
      return _failure('تعذر فتح منتقي الملفات. حاول مرة أخرى.');
    }
    if (picked == null || picked.files.isEmpty) return null;

    final file = picked.files.single;
    final extension = (file.extension ?? '').toLowerCase();
    if (!supportedExtensions.contains(extension)) {
      return _failure('صيغة الملف غير مدعومة. استخدم CSV أو XLSX.');
    }

    List<int>? bytes = file.bytes;
    try {
      bytes ??= file.path == null ? null : await File(file.path!).readAsBytes();
    } catch (_) {
      return _failure('تعذر قراءة الملف. تحقق من صلاحية الوصول إليه.');
    }
    if (bytes == null || bytes.isEmpty) {
      return _failure('تعذر قراءة الملف.');
    }

    late final List<List<String>> rows;
    try {
      rows = extension == 'xlsx' ? _xlsxRows(bytes) : _csvRows(bytes);
    } catch (_) {
      return _failure('الملف تالف أو لا يطابق صيغة $extension.');
    }
    if (rows.isEmpty) {
      return const ProductFileImportResult(
        imported: 0,
        failed: 1,
        errors: ['الملف لا يحتوي على بيانات.'],
      );
    }

    final headers = rows.first.indexed.map((entry) {
      final header = entry.$2.trim();
      return entry.$1 == 0 ? header.replaceFirst('\uFEFF', '') : header;
    }).toList();
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
        row[headers[column]] = column < values.length
            ? values[column].trim()
            : '';
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
        errors.add('السطر ${index + 1}: categoryId أو name أو price غير صالح.');
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

      result.fold((failure) {
        failed++;
        errors.add('السطر ${index + 1} ($name): ${failure.message}');
      }, (_) => imported++);
    }

    return ProductFileImportResult(
      imported: imported,
      failed: failed,
      errors: errors,
    );
  }

  static List<List<String>> _csvRows(List<int> bytes) {
    final text = utf8.decode(bytes, allowMalformed: true);
    return const CsvToListConverter(
      shouldParseNumbers: false,
    ).convert<String>(text);
  }

  static List<List<String>> _xlsxRows(List<int> bytes) {
    final workbook = Excel.decodeBytes(bytes);
    if (workbook.tables.isEmpty) return const [];
    final sheet = workbook.tables.values.first;
    return sheet.rows
        .map((row) => row.map((cell) => cell?.value?.toString() ?? '').toList())
        .toList();
  }
}
