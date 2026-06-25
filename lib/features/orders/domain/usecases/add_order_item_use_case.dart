import 'package:common_package/helpers/typedef.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/owner_order_details_model.dart';
import '../repository/orders_repo.dart';

@lazySingleton
class AddOrderItemUseCase implements UseCase<OwnerOrderDetailsModel, AddOrderItemParams> {
  final OrdersRepo orders;

  AddOrderItemUseCase({required this.orders});

  @override
  DataResponse<OwnerOrderDetailsModel> call(AddOrderItemParams params) {
    return orders.addOrderItem(params);
  }
}

class AddOrderItemParams with Params {
  final int orderId;
  final int productId;
  final int quantity;
  final num unitPrice;
  final String? specialInstructions;

  AddOrderItemParams({required this.orderId, required this.productId, required this.quantity, required this.unitPrice, this.specialInstructions});

  @override
  BodyMap getBody() => {
    'productId': productId,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'specialInstructions': specialInstructions,
  }..removeWhere((key, value) => value == null || value == '');
}
