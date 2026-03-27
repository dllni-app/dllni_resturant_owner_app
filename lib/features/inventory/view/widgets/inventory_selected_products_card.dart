import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/products/data/models/fetch_products_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class InventorySelectedProductsCard extends StatelessWidget {
  const InventorySelectedProductsCard({
    super.key,
    required this.selectedProducts,
  });

  final List<FetchProductsModelDataItem> selectedProducts;

  @override
  Widget build(BuildContext context) {
    final count = selectedProducts.length;
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
        color: context.onPrimary,
        border: Border.all(color: const Color(0xFFF3F4F6)),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 20,
            spreadRadius: -2,
            color: Colors.black.withAlpha(13),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCountChip(count),
              AppText.titleMedium(
                'المنتجات المحددة',
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (count == 0)
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: const Radius.circular(20),
                dashPattern: const [6, 4],
                strokeWidth: 1.5,
                color: const Color(0xFFD1D5DB),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: context.onPrimary,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Color(0xFF9CA3AF),
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AppText.bodyMedium(
                      'لم يتم تحديد منتجات بعد',
                      color: const Color(0xFF6B7280),
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 4),
                    AppText.labelLarge(
                      'اختر المنتجات من القائمة أعلاه',
                      color: const Color(0xFF9CA3AF),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: selectedProducts.map((product) {
                return Container(
                  width: 120,
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: context.onPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.fastfood_outlined,
                          color: Color(0xFFD1D5DB),
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppText.labelLarge(
                        product.name ?? '',
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildCountChip(int count) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFECFDF5),
      ),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: AppText.labelLarge(
        '$count منتجات',
        color: const Color(0xFF065F46),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
