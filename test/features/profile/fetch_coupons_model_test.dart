import 'package:dllni_resturant_owner_app/features/profile/data/models/fetch_coupons_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FetchCouponsModel parses decimal values without int cast errors', () {
    final model = FetchCouponsModel.fromJson({
      'data': [
        {
          'id': 1,
          'restaurantId': 3,
          'code': 'SAVE15',
          'discountType': 'percentage',
          'discountValue': 15.5,
          'minOrderAmount': 100.75,
          'usageLimit': 5,
          'usageCount': 1,
          'isActive': true,
          'performance': {
            'ordersCount': 2,
            'totalSavings': 31.5,
            'revenueImpact': 200.25,
          },
        },
      ],
      'meta': {'currentPage': 1, 'lastPage': 1, 'perPage': 10, 'total': 1},
    });

    final coupon = model.data!.first;
    expect(coupon.discountValue, 15.5);
    expect(coupon.minOrderAmount, 100.75);
    expect(coupon.performance!.totalSavings, 31.5);
    expect(coupon.performance!.revenueImpact, 200.25);
  });
}
