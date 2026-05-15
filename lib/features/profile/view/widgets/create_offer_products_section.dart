import 'dart:async';
import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../products/domain/usecases/fetch_products_use_case.dart';
import '../manager/bloc/profile_bloc.dart';
import 'create_offer_product_tile.dart';

class CreateOfferProductsSection extends StatefulWidget {
  const CreateOfferProductsSection({super.key});

  @override
  State<CreateOfferProductsSection> createState() => _CreateOfferProductsSectionState();
}

class _CreateOfferProductsSectionState extends State<CreateOfferProductsSection> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      final searchQuery = _searchController.text.trim();
      context.read<ProfileBloc>().add(
        FetchProductsEvent(
          params: FetchProductsParams(
            page: 1,
            search: searchQuery.isEmpty ? null : searchQuery,
          ),
          isReload: true,
        ),
      );
    });
  }

  void _fetchAllProducts() {
    _searchController.clear();
    context.read<ProfileBloc>().add(
      FetchProductsEvent(
        params: FetchProductsParams(page: 1),
        isReload: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchField(),
        const SizedBox(height: 12),
        InkWell(
          onTap: () {
            AppToast.showToast(
              context: context,
              message: 'قريباً',
              type: ToastificationType.info,
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.layers_outlined,
                  color: Color(0xFF374151),
                  size: 18,
                ),
                const SizedBox(width: 8),
                AppText.bodyMedium(
                  'اختيار تصنيف كامل',
                  color: const Color(0xFF374151),
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final products = state.products;
            
            if (products == null || products.isLoading) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  color: const Color(0xFFF9FAFB),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (products.isFailed) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  color: const Color(0xFFF9FAFB),
                ),
                child: AppText.labelLarge(
                  products.errorMessage.isNotEmpty ? products.errorMessage : 'حدث خطأ',
                  textAlign: TextAlign.center,
                  color: const Color(0xFF6B7280),
                ),
              );
            }

            if (products.isEmpty) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  color: const Color(0xFFF9FAFB),
                ),
                child: AppText.labelLarge(
                  'لا توجد منتجات مطابقة',
                  textAlign: TextAlign.center,
                  color: const Color(0xFF6B7280),
                ),
              );
            }

            return Column(
              children: [
                ...products.list.map((product) {
                  final isSelected = state.selectedProducts.any((p) => p.id == product.id);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CreateOfferProductTile(
                      name: product.name ?? '',
                      category: product.category?.name ?? '',
                      imageAsset: null,
                      isSelected: isSelected,
                      onChanged: (value) {
                        if (value) {
                          context.read<ProfileBloc>().add(SelectProductEvent(product: product));
                        } else {
                          context.read<ProfileBloc>().add(DeselectProductEvent(productId: product.id!));
                        }
                      },
                    ),
                  );
                }).toList(),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: _fetchAllProducts,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
            child: AppText.bodyMedium(
              'عرض جميع المنتجات',
              textAlign: TextAlign.center,
              color: const Color(0xFF6B7280),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextFormField(
      controller: _searchController,
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
    );
  }
}
