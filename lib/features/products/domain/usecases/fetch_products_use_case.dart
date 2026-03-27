import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/products_repo.dart';
import '../../data/models/fetch_products_model.dart';

@lazySingleton
class FetchProductsUseCase implements UseCase<FetchProductsModel, FetchProductsParams> {
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

  FetchProductsParams({this.categoryId, required this.page, this.search});

  @override
  QueryParams getParams() {
    final params = <String, dynamic>{
      'page': page,
      'perPage': 10,
    };
    if (categoryId != null) {
      params['filter[categoryId]'] = categoryId;
    }
    if (search != null && search!.isNotEmpty) {
      params['filter[search]'] = search;
    }
    return params;
  }
}
