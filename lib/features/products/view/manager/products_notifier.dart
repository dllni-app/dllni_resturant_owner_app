import 'package:flutter/material.dart';

class ProductsNotifier {

  ValueNotifier<int> categoryId = ValueNotifier<int>(-1);

  changeCategoryId(val){
    categoryId.value = val;
  }

}