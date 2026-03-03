import 'package:flutter/material.dart';

class OrdersNotifier{

  ValueNotifier<String?> status = ValueNotifier<String?>(null);

  changeStatus(val){
    status.value = val;
  }

}