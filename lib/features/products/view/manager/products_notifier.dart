import 'package:flutter/material.dart';

import '../../domain/usecases/fetch_products_use_case.dart';

class ProductsNotifier {
  final ValueNotifier<int> selectedCategoryId = ValueNotifier<int>(0);
  final ValueNotifier<String> searchQuery = ValueNotifier<String>('');
  final ValueNotifier<bool?> availabilityFilter = ValueNotifier<bool?>(null);
  final ValueNotifier<bool> lowStockOnly = ValueNotifier<bool>(false);
  final ValueNotifier<bool> discountedOnly = ValueNotifier<bool>(false);

  int? get activeCategoryId => selectedCategoryId.value == 0 ? null : selectedCategoryId.value;

  void changeSelectedCategoryId(int categoryId) {
    selectedCategoryId.value = categoryId;
  }

  void changeSearchQuery(String value) {
    searchQuery.value = value.trim();
  }

  void changeFilters({bool? availability, bool? lowStock, bool? discounted}) {
    availabilityFilter.value = availability;
    if (lowStock != null) lowStockOnly.value = lowStock;
    if (discounted != null) discountedOnly.value = discounted;
  }

  FetchProductsParams fetchParams({required int page, int? categoryId}) {
    return FetchProductsParams(
      page: page,
      categoryId: categoryId ?? activeCategoryId,
      search: searchQuery.value.isEmpty ? null : searchQuery.value,
      isAvailable: availabilityFilter.value,
      lowStock: lowStockOnly.value ? true : null,
      hasDiscount: discountedOnly.value ? true : null,
    );
  }

  void dispose() {
    selectedCategoryId.dispose();
    searchQuery.dispose();
    availabilityFilter.dispose();
    lowStockOnly.dispose();
    discountedOnly.dispose();
  }
}
