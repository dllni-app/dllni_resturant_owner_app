import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../widgets/add_new_product_app_bar.dart';
import '../widgets/add_product_way_card.dart';
import '../widgets/products_style_tokens.dart';
import 'add_product_details_screen.dart';

@AutoRoutePage(path: '/products/new_product')
class AddNewProductScreen extends StatelessWidget {
  const AddNewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {},
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
                      title: 'اضافة وجبة يدويا',
                      subtitle: 'اضف وجبة من خلال ادخلا بياناتها المطلوبة',
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
