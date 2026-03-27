import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/products/view/manager/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryLinkProductsSection extends StatelessWidget {
  const InventoryLinkProductsSection({
    super.key,
    required this.selectedProductIds,
    required this.searchController,
    required this.onSearchChanged,
    required this.onProductToggle,
    required this.onShowAll,
  });

  final Set<int> selectedProductIds;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<int> onProductToggle;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFB8B7E8)),
            color: const Color(0xFFF5F6FF),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline_rounded, size: 16, color: context.primary),
              const SizedBox(width: 8),
              Expanded(
                child: AppText.labelLarge(
                  'ربط المادة بالمنتجات يساعد في خصم الكميات تلقائياً من المخزون عند كل طلب',
                  color: context.primary,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'اختيار المنتجات',
            style: TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w700, height: 1.42),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: searchController,
          onChanged: onSearchChanged,
          style: const TextStyle(color: Color(0xB22F2B3D), fontSize: 14),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, color: Color(0xFF9CA3AF)),
            filled: true,
            fillColor: Color(0xFFF9FAFB),
            hintText: 'ابحث عن منتج...',
            hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state.products!.isSuccess) {
              return Column(
                children: List.generate(
                  state.products!.list.length,
                  (i) => Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => onProductToggle(state.products!.list[i].id!),
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: selectedProductIds.contains(state.products!.list[i].id!) ? const Color(0xFFFFF7ED) : context.onPrimary,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selectedProductIds.contains(state.products!.list[i].id!) ? const Color(0xFFFF7A00) : const Color(0xFFE5E7EB),
                          ),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: selectedProductIds.contains(state.products!.list[i].id!),
                              onChanged: (_) => onProductToggle(state.products!.list[i].id!),
                              activeColor: context.primaryContainer,
                              side: const BorderSide(color: Color(0xFFD1D5DB)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.bodyMedium(state.products!.list[i].name ?? '', fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                                  AppText.labelLarge(state.products!.list[i].category?.name ?? '', color: const Color(0xFF6B7280)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.fastfood_outlined, color: Color(0xFF9CA3AF), size: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator.adaptive());
            }
          },
        ),
        /*InkWell(
          onTap: onShowAll,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
            child: AppText.bodyMedium('عرض جميع المنتجات', textAlign: TextAlign.center, color: const Color(0xFF6B7280), fontWeight: FontWeight.w700),
          ),
        ),*/
      ],
    );
  }
}
