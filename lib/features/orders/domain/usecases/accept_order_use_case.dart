import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/orders_repo.dart';
import '../../data/models/accept_order_model.dart';

@lazySingleton
class AcceptOrderUseCase implements UseCase<AcceptOrderModel, AcceptOrderParams> {
  final OrdersRepo orders;

  AcceptOrderUseCase({required this.orders});

  @override
  DataResponse<AcceptOrderModel> call(AcceptOrderParams params) {
    return orders.acceptOrder(params);
  }
}

class AcceptOrderParams with Params {
  final int? preparationTimeMinutes;
  final int? assignedEmployeeId;
  final String kitchenNotes;
  final int id;

  AcceptOrderParams({
    this.preparationTimeMinutes,
    this.assignedEmployeeId,
    required this.kitchenNotes,
    required this.id,
  });

  @override
  BodyMap getBody() => {
        'preparationTimeMinutes': preparationTimeMinutes,
        'assignedEmployeeId': assignedEmployeeId,
        'kitchenNotes': kitchenNotes,
      }..removeWhere((key, value) => value == null);
}
