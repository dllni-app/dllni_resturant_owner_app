import 'package:common_package/helpers/typedef.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/owner_order_details_model.dart';
import '../repository/orders_repo.dart';

@lazySingleton
class UpdateOrderItemUseCase implements UseCase<OwnerOrderDetailsModel, UpdateOrderItemParams> {
  final OrdersRepo orders;

  UpdateOrderItemUseCase({required this.orders});

  @override
  DataResponse<OwnerOrderDetailsModel> call(UpdateOrderItemParams params) {
    return orders.updateOrderItem(params);
  }
}

class UpdateOrderItemParams with Params {
  final int orderId;
  final int itemId;
  final int? quantity;
  final num? unitPrice;
  final String? specialInstructions;

  UpdateOrderItemParams({required this.orderId, required this.itemId, this.quantity, this.unitPrice, this.specialInstructions});

  @override
  BodyMap getBody() => {
    'quantity': quantity,
    'unitPrice': unitPrice,
    'specialInstructions': specialInstructions,
  }..removeWhere((key, value) => value == null || value == '');
}
