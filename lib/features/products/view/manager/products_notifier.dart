import 'package:flutter/material.dart';

class ProductsNotifier {
  final ValueNotifier<int> selectedCategoryId = ValueNotifier<int>(0);

  changeSelectedCategoryId(int categoryId) {
    selectedCategoryId.value = categoryId;
  }
}
