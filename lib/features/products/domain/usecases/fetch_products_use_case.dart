import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/products_repo.dart';
import '../../data/models/fetch_products_model.dart';

@lazySingleton
class FetchProductsUseCase
    implements UseCase<FetchProductsModel, FetchProductsParams> {
  final ProductsRepo products;

  FetchProductsUseCase({required this.products});

  @override
  DataResponse<FetchProductsModel> call(FetchProductsParams params) {
    return products.fetchProducts(params);
  }
}

class FetchProductsParams with Params {
  final int? categoryId;
  final int page;
  final String? search;
  final bool? isAvailable;
  final bool? lowStock;
  final bool? hasDiscount;

  FetchProductsParams({
    this.categoryId,
    required this.page,
    this.search,
    this.isAvailable,
    this.lowStock,
    this.hasDiscount,
  });

  @override
  QueryParams getParams() {
    final params = <String, dynamic>{'page': page, 'perPage': 10};

    if (categoryId != null) {
      params['filter[categoryId]'] = categoryId;
    }

    if (search != null && search!.trim().isNotEmpty) {
      params['filter[search]'] = search!.trim();
    }

    if (isAvailable != null) {
      params['filter[isAvailable]'] = isAvailable! ? 1 : null;
    }

    if (lowStock != null) {
      params['filter[lowStock]'] = lowStock! ? 1 : null;
    }

    if (hasDiscount != null) {
      params['filter[hasDiscount]'] = hasDiscount! ? 1 : null;
    }

    return params..removeWhere((key, value) => value == null);
  }
}
