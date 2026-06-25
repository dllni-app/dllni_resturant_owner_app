import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/orders_repo.dart';
import '../../data/models/get_orders_model.dart';

@lazySingleton
class GetOrdersUseCase implements UseCase<GetOrdersModel, GetOrdersParams> {
  final OrdersRepo orders;

  GetOrdersUseCase({required this.orders});

  @override
  DataResponse<GetOrdersModel> call(GetOrdersParams params) {
    return orders.getOrders(params);
  }
}

class GetOrdersParams with Params {
  final int page;
  final String? status;
  final int perPage;

  GetOrdersParams({required this.page, this.status, this.perPage = 20});

  @override
  QueryParams getParams() => {'page': page, 'perPage': perPage, 'filter[status]': status}..removeWhere((key, val) => val == null);
}
