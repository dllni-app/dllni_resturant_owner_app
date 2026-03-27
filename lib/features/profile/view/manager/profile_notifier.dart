import 'package:flutter/material.dart';

class ProfileNotifier {
  ValueNotifier<String> couponStatus = ValueNotifier<String>('all');
  ValueNotifier<String> offerStatus = ValueNotifier<String>('all');

  changeCouponStatus(String status) {
    couponStatus.value = status;
  }

  changeOfferStatus(String status) {
    offerStatus.value = status;
  }
}
