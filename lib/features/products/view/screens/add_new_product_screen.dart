import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../data/models/fetch_products_model.dart';
import '../helpers/product_file_importer.dart';
import '../widgets/add_new_product_app_bar.dart';
import '../widgets/add_product_way_card.dart';
import '../widgets/products_style_tokens.dart';
import 'add_product_details_screen.dart';

@AutoRoutePage(path: '/products/new_product')
class AddNewProductScreen extends StatelessWidget {
  const AddNewProductScreen({
    super.key,
    this.params = const AddNewProductScreenParams(),
  });

  final AddNewProductScreenParams params;

  Future<void> _importProducts(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('استيراد المنتجات'),
        content: const Text(
          'يجب أن يحتوي الصف الأول على الأعمدة: categoryId, name, price.\n\n'
          'الأعمدة الاختيارية: description, discountedPrice, lowStockThreshold, preparationTime.\n\n'
          'يدعم النظام ملفات CSV و XLSX، ويمكن إنشاء المنتجات بدون صور ثم إضافة الصور لاحقاً.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _runImport(context);
            },
            child: const Text('اختيار الملف'),
          ),
        ],
      ),
    );
  }

  Future<void> _runImport(BuildContext context) async {
    var loadingVisible = true;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Expanded(child: Text('جاري قراءة الملف واستيراد المنتجات...')),
            ],
          ),
        ),
      ),
    );

    try {
      final result = await ProductFileImporter.pickAndImport();
      if (context.mounted && loadingVisible) {
        Navigator.of(context, rootNavigator: true).pop();
        loadingVisible = false;
      }
      if (!context.mounted || result == null) return;

      if (result.imported > 0 && result.failed == 0) {
        AppToast.showToast(
          context: context,
          message: 'تم استيراد ${result.imported} منتج بنجاح',
          type: ToastificationType.success,
        );
        return;
      }

      final errorPreview = result.errors.take(3).join('\n');
      AppToast.showToast(
        context: context,
        message: result.imported > 0
            ? 'تم استيراد ${result.imported} منتج وفشل ${result.failed}.\n$errorPreview'
            : 'تعذر الاستيراد.\n$errorPreview',
        type: result.imported > 0 ? ToastificationType.warning : ToastificationType.error,
      );
    } catch (error) {
      if (context.mounted && loadingVisible) {
        Navigator.of(context, rootNavigator: true).pop();
        loadingVisible = false;
      }
      if (context.mounted) {
        AppToast.showToast(
          context: context,
          message: 'حدث خطأ أثناء استيراد الملف: $error',
          type: ToastificationType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (params.productForEdit != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.pushRouteReplacement(
          '/products/new_product/details',
          arguments: AddProductDetailsScreenParams.fromProduct(
            params.productForEdit!,
          ),
        );
      });

      return const Scaffold(
        backgroundColor: ProductsStyleTokens.pageBackground,
        body: SizedBox.expand(),
      );
    }

    return Scaffold(
      backgroundColor: ProductsStyleTokens.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AddNewProductAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 24),
                child: Column(
                  children: [
                    const Text(
                      'اختر الطريقة المناسبة لإضافة منتجك',
                      style: TextStyle(color: Color(0xFF8B87F2), fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    AddProductWayCard(
                      onTap: () => context.pushRoute('/products/new_product/ai'),
                      backgroundColor: const Color(0xFFFAF5FF),
                      foregroundColor: const Color(0xFF9333EA),
                      icon: Icons.auto_awesome_rounded,
                      title: 'إضافة باستخدام الذكاء الاصطناعي',
                      subtitle: 'اكتب اسم الوجبة وسيتم اقتراح الصورة والوصف تلقائياً',
                      hint: 'الأسرع',
                    ),
                    const SizedBox(height: 16),
                    AddProductWayCard(
                      onTap: () => context.pushRoute('/products/new_product/menu'),
                      backgroundColor: const Color(0xFFEFF6FF),
                      foregroundColor: const Color(0xFF2563EB),
                      icon: Icons.camera_alt_rounded,
                      title: 'البحث في الكتالوج المركزي',
                      subtitle: 'ارفع صورة المنيو ليتم استخراج المنتجات تلقائياً',
                      hint: 'موصى بها',
                    ),
                    const SizedBox(height: 16),
                    AddProductWayCard(
                      onTap: () => _importProducts(context),
                      backgroundColor: const Color(0xFFFFF7ED),
                      foregroundColor: const Color(0xFFEA580C),
                      icon: Icons.file_present_rounded,
                      title: 'رفع ملف Excel أو CSV',
                      subtitle: 'استيراد عدة منتجات دفعة واحدة عبر ملف',
                    ),
                    const SizedBox(height: 16),
                    AddProductWayCard(
                      onTap: () => context.pushRoute('/products/new_product/details', arguments: AddProductDetailsScreenParams()),
                      backgroundColor: const Color(0xFFF0FDF4),
                      foregroundColor: const Color(0xFF16A34A),
                      icon: Icons.format_list_bulleted_rounded,
                      title: 'إضافة وجبة يدوياً',
                      subtitle: 'أضف وجبة من خلال إدخال بياناتها المطلوبة',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewProductScreenParams {
  const AddNewProductScreenParams({this.productForEdit});

  final FetchProductsModelDataItem? productForEdit;
}
