import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/get_low_stock_products_usecase_model.dart';

@lazySingleton
class GetLowStockProductsUsecaseUseCase implements UseCase<GetLowStockProductsUsecaseModel, GetLowStockProductsUsecaseParams> {

  final HomeRepo home;

  GetLowStockProductsUsecaseUseCase({required this.home});

  @override
  DataResponse<GetLowStockProductsUsecaseModel> call(GetLowStockProductsUsecaseParams params) {
    return home.getLowStockProductsUsecase(params);
  }
}

class GetLowStockProductsUsecaseParams with Params{
  final int restaurantId;
  final bool? lowStock;
  final int? perPage;

  GetLowStockProductsUsecaseParams({required this.restaurantId, this.lowStock, this.perPage});

  @override
  QueryParams getParams() => {
    'filter[restaurantId]': '$restaurantId',
    'filter[lowStock]': '$lowStock',
    'perPage': '$perPage',
  };
}
