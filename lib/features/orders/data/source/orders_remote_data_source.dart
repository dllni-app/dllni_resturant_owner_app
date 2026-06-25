import 'package:common_package/common_package.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/accept_order_use_case.dart';
import '../../domain/usecases/add_order_item_use_case.dart';
import '../../domain/usecases/delete_order_item_use_case.dart';
import '../../domain/usecases/get_order_details_use_case.dart';
import '../../domain/usecases/get_orders_use_case.dart';
import '../../domain/usecases/reject_order_use_case.dart';
import '../../domain/usecases/update_order_item_use_case.dart';
import '../models/accept_order_model.dart';
import '../models/get_orders_model.dart';
import '../models/owner_order_details_model.dart';
import '../models/reject_order_model.dart';

@lazySingleton
class OrdersRemoteDataSource with HandlingApiManager {
  final DioNetwork dioNetwork;

  OrdersRemoteDataSource({required this.dioNetwork});

  Future<GetOrdersModel> getOrders(GetOrdersParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(
        endPoint: '/api/v1/orders',
        params: params.getParams(),
        data: params.getBody().isEmpty ? null : params.getBody(),
      ),
      jsonConvert: getOrdersModelFromJson,
    );
  }

  Future<OwnerOrderDetailsModel> getOrderDetails(GetOrderDetailsParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(
        endPoint: '/api/v1/restaurant-owner/orders/${params.orderId}',
        params: params.getParams(),
        data: params.getBody().isEmpty ? null : params.getBody(),
      ),
      jsonConvert: ownerOrderDetailsModelFromJson,
    );
  }

  Future<AcceptOrderModel> acceptOrder(AcceptOrderParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(
        endPoint: '/api/v1/orders/${params.id}/accept',
        data: params.getBody(),
        params: params.getParams(),
      ),
      jsonConvert: acceptOrderModelFromJson,
    );
  }

  Future<RejectOrderModel> rejectOrder(RejectOrderParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(
        endPoint: '/api/v1/orders/${params.id}/reject',
        data: params.getBody(),
        params: params.getParams(),
      ),
      jsonConvert: rejectOrderModelFromJson,
    );
  }

  Future<OwnerOrderDetailsModel> addOrderItem(AddOrderItemParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(
        endPoint: '/api/v1/restaurant-owner/orders/${params.orderId}/items',
        data: params.getBody(),
        params: params.getParams(),
      ),
      jsonConvert: ownerOrderDetailsModelFromJson,
    );
  }

  Future<OwnerOrderDetailsModel> updateOrderItem(UpdateOrderItemParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.patchData(
        endPoint: '/api/v1/restaurant-owner/orders/${params.orderId}/items/${params.itemId}',
        data: params.getBody(),
        params: params.getParams(),
      ),
      jsonConvert: ownerOrderDetailsModelFromJson,
    );
  }

  Future<OwnerOrderDetailsModel> deleteOrderItem(DeleteOrderItemParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.deleteData(
        endPoint: '/api/v1/restaurant-owner/orders/${params.orderId}/items/${params.itemId}',
        data: params.getBody().isEmpty ? null : params.getBody(),
        params: params.getParams(),
      ),
      jsonConvert: ownerOrderDetailsModelFromJson,
    );
  }
}
