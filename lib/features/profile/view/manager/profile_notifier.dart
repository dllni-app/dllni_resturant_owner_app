import 'package:flutter/material.dart';

class ProfileNotifier {
  ValueNotifier<String> couponStatus = ValueNotifier<String>('all');
  ValueNotifier<String> couponSearch = ValueNotifier<String>('');
  ValueNotifier<String> couponSort = ValueNotifier<String>('-created_at');
  ValueNotifier<String?> couponDateFrom = ValueNotifier<String?>(null);
  ValueNotifier<String?> couponDateTo = ValueNotifier<String?>(null);
  ValueNotifier<String> offerStatus = ValueNotifier<String>('all');

  changeCouponStatus(String status) {
    couponStatus.value = status;
  }

  changeCouponSearch(String search) {
    couponSearch.value = search;
  }

  changeCouponSort(String sort) {
    couponSort.value = sort;
  }

  changeCouponDateRange({String? dateFrom, String? dateTo}) {
    couponDateFrom.value = dateFrom;
    couponDateTo.value = dateTo;
  }

  changeOfferStatus(String status) {
    offerStatus.value = status;
  }
}
