import 'package:common_package/helpers/typedef.dart';

import '../../data/models/accept_order_model.dart';
import '../../data/models/get_orders_model.dart';
import '../../data/models/owner_order_details_model.dart';
import '../../data/models/reject_order_model.dart';
import '../usecases/accept_order_use_case.dart';
import '../usecases/add_order_item_use_case.dart';
import '../usecases/change_order_status_use_case.dart';
import '../usecases/delete_order_item_use_case.dart';
import '../usecases/get_order_details_use_case.dart';
import '../usecases/get_orders_use_case.dart';
import '../usecases/reject_order_use_case.dart';
import '../usecases/update_order_item_use_case.dart';
import '../usecases/update_preparation_estimate_params.dart';

abstract class OrdersRepo {
  DataResponse<GetOrdersModel> getOrders(GetOrdersParams params);
  DataResponse<OwnerOrderDetailsModel> getOrderDetails(GetOrderDetailsParams params);
  DataResponse<AcceptOrderModel> acceptOrder(AcceptOrderParams params);
  DataResponse<RejectOrderModel> rejectOrder(RejectOrderParams params);
  DataResponse<OwnerOrderDetailsModel> changeOrderStatus(ChangeOrderStatusParams params);
  DataResponse<OwnerOrderDetailsModel> updatePreparationEstimate(UpdatePreparationEstimateParams params);
  DataResponse<OwnerOrderDetailsModel> addOrderItem(AddOrderItemParams params);
  DataResponse<OwnerOrderDetailsModel> updateOrderItem(UpdateOrderItemParams params);
  DataResponse<OwnerOrderDetailsModel> deleteOrderItem(DeleteOrderItemParams params);
}
