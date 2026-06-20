import 'package:dllni_resturant_owner_app/features/products/domain/usecases/fetch_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FetchProductsParams sends search and filter query params', () {
    final params = FetchProductsParams(
      page: 2,
      categoryId: 10,
      search: 'بيتزا',
      isAvailable: true,
      lowStock: true,
      hasDiscount: true,
    ).getParams();

    expect(params['page'], 2);
    expect(params['perPage'], 10);
    expect(params['filter[categoryId]'], 10);
    expect(params['filter[search]'], 'بيتزا');
    expect(params['filter[isAvailable]'], true);
    expect(params['filter[lowStock]'], true);
    expect(params['filter[hasDiscount]'], true);
  });

  test('FetchProductsParams skips empty optional filters', () {
    final params = FetchProductsParams(page: 1, search: '   ').getParams();

    expect(params.containsKey('filter[search]'), isFalse);
    expect(params.containsKey('filter[categoryId]'), isFalse);
    expect(params.containsKey('filter[isAvailable]'), isFalse);
  });
}
