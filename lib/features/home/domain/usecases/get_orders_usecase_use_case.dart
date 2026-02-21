import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/get_orders_usecase_model.dart';

@lazySingleton
class GetOrdersUsecaseUseCase implements UseCase<GetOrdersUsecaseModel, GetOrdersUsecaseParams> {
  final HomeRepo home;

  GetOrdersUsecaseUseCase({required this.home});

  @override
  DataResponse<GetOrdersUsecaseModel> call(GetOrdersUsecaseParams params) {
    return home.getOrdersUsecase(params);
  }
}

class GetOrdersUsecaseParams with Params {
  final int restaurantId;
  final String? status;
  final bool? createdToday;
  final int? perPage;
  final int? page;

  GetOrdersUsecaseParams({required this.restaurantId, this.status, this.createdToday, this.perPage, this.page});

  @override
  QueryParams getParams() => {
    'filter[restaurantId]': '$restaurantId',
    'filter[status]': status,
    'filter[createdToday]': '$createdToday',
    'perPage': '$perPage',
    'page': '$page',
  };
}
