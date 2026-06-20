import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/create_coupon_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CreateCouponParams omits optional empty fields when null', () {
    final body = CreateCouponParams(
      code: 'SAVE10',
      discountType: 'percentage',
      discountValue: 10,
      minOrderAmount: null,
      usageLimit: null,
      startsAt: null,
      endsAt: null,
      isActive: true,
    ).getBody();

    expect(body['code'], 'SAVE10');
    expect(body['discountType'], 'percentage');
    expect(body['discountValue'], 10);
    expect(body['isActive'], true);
    expect(body.containsKey('minOrderAmount'), isFalse);
    expect(body.containsKey('usageLimit'), isFalse);
    expect(body.containsKey('startsAt'), isFalse);
    expect(body.containsKey('endsAt'), isFalse);
  });
}
