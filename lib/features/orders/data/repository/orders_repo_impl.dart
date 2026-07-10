import 'package:common_package/helpers/error_handler.dart';
import 'package:common_package/helpers/typedef.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/orders_repo.dart';
import '../../domain/usecases/accept_order_use_case.dart';
import '../../domain/usecases/add_order_item_use_case.dart';
import '../../domain/usecases/change_order_status_use_case.dart';
import '../../domain/usecases/delete_order_item_use_case.dart';
import '../../domain/usecases/get_order_details_use_case.dart';
import '../../domain/usecases/get_orders_use_case.dart';
import '../../domain/usecases/reject_order_use_case.dart';
import '../../domain/usecases/update_order_item_use_case.dart';
import '../../domain/usecases/update_preparation_estimate_params.dart';
import '../models/accept_order_model.dart';
import '../models/get_orders_model.dart';
import '../models/owner_order_details_model.dart';
import '../models/reject_order_model.dart';
import '../source/orders_remote_data_source.dart';

@LazySingleton(as: OrdersRepo)
class OrdersRepoImpl with HandlingException implements OrdersRepo {
  final OrdersRemoteDataSource ordersRemoteDataSource;

  OrdersRepoImpl({required this.ordersRemoteDataSource});

  @override
  DataResponse<GetOrdersModel> getOrders(GetOrdersParams params) {
    return wrapHandlingException(tryCall: () => ordersRemoteDataSource.getOrders(params));
  }

  @override
  DataResponse<OwnerOrderDetailsModel> getOrderDetails(GetOrderDetailsParams params) {
    return wrapHandlingException(tryCall: () => ordersRemoteDataSource.getOrderDetails(params));
  }

  @override
  DataResponse<AcceptOrderModel> acceptOrder(AcceptOrderParams params) {
    return wrapHandlingException(tryCall: () => ordersRemoteDataSource.acceptOrder(params));
  }

  @override
  DataResponse<RejectOrderModel> rejectOrder(RejectOrderParams params) {
    return wrapHandlingException(tryCall: () => ordersRemoteDataSource.rejectOrder(params));
  }

  @override
  DataResponse<OwnerOrderDetailsModel> changeOrderStatus(ChangeOrderStatusParams params) {
    return wrapHandlingException(tryCall: () => ordersRemoteDataSource.changeOrderStatus(params));
  }

  @override
  DataResponse<OwnerOrderDetailsModel> updatePreparationEstimate(UpdatePreparationEstimateParams params) {
    return wrapHandlingException(tryCall: () => ordersRemoteDataSource.updatePreparationEstimate(params));
  }

  @override
  DataResponse<OwnerOrderDetailsModel> addOrderItem(AddOrderItemParams params) {
    return wrapHandlingException(tryCall: () => ordersRemoteDataSource.addOrderItem(params));
  }

  @override
  DataResponse<OwnerOrderDetailsModel> updateOrderItem(UpdateOrderItemParams params) {
    return wrapHandlingException(tryCall: () => ordersRemoteDataSource.updateOrderItem(params));
  }

  @override
  DataResponse<OwnerOrderDetailsModel> deleteOrderItem(DeleteOrderItemParams params) {
    return wrapHandlingException(tryCall: () => ordersRemoteDataSource.deleteOrderItem(params));
  }
}
