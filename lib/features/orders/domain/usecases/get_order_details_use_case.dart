import 'package:common_package/helpers/typedef.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/owner_order_details_model.dart';
import '../repository/orders_repo.dart';

@lazySingleton
class GetOrderDetailsUseCase implements UseCase<OwnerOrderDetailsModel, GetOrderDetailsParams> {
  final OrdersRepo orders;

  GetOrderDetailsUseCase({required this.orders});

  @override
  DataResponse<OwnerOrderDetailsModel> call(GetOrderDetailsParams params) {
    return orders.getOrderDetails(params);
  }
}

class GetOrderDetailsParams with Params {
  final int orderId;

  GetOrderDetailsParams({required this.orderId});
}
