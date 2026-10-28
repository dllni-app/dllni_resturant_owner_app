import 'package:dllni_resturant_owner_app/features/products/domain/usecases/post_new_product_use_case.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/update_product_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('base-price-only product form', () {
    test('new restaurant product omits discounted price by default', () {
      final request = PostNewProductParams(
        categoryId: 2,
        name: 'طبق جديد',
        price: '1000',
      ).getBody();

      expect(request['price'], '1000');
      expect(request.containsKey('discountedPrice'), isFalse);
    });

    test('editing a restaurant product leaves its discount untouched', () {
      final request = UpdateProductParams(
        id: 7,
        categoryId: 2,
        name: 'طبق',
        price: '1500',
      ).getBody();

      expect(request['price'], '1500');
      expect(request.containsKey('discountedPrice'), isFalse);
    });
  });
}
