import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/products_repo.dart';
import '../../data/models/fetch_categories_model.dart';

@lazySingleton
class FetchCategoriesUseCase implements UseCase<FetchCategoriesModel, FetchCategoriesParams> {
  final ProductsRepo products;

  FetchCategoriesUseCase({required this.products});

  @override
  DataResponse<FetchCategoriesModel> call(FetchCategoriesParams params) {
    return products.fetchCategories(params);
  }
}

class FetchCategoriesParams with Params {
  final int page;

  FetchCategoriesParams({required this.page});

  @override
  QueryParams getParams() => {'page': page};
}
