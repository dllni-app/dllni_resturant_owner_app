import 'package:common_package/helpers/typedef.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/owner_order_details_model.dart';
import '../repository/orders_repo.dart';

@lazySingleton
class DeleteOrderItemUseCase implements UseCase<OwnerOrderDetailsModel, DeleteOrderItemParams> {
  final OrdersRepo orders;

  DeleteOrderItemUseCase({required this.orders});

  @override
  DataResponse<OwnerOrderDetailsModel> call(DeleteOrderItemParams params) {
    return orders.deleteOrderItem(params);
  }
}

class DeleteOrderItemParams with Params {
  final int orderId;
  final int itemId;

  DeleteOrderItemParams({required this.orderId, required this.itemId});
}
