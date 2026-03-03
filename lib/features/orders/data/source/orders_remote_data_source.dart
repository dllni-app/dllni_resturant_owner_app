import 'package:common_package/common_package.dart';
import 'package:injectable/injectable.dart';
import '../models/get_orders_model.dart';
import '../../domain/usecases/get_orders_use_case.dart';

@lazySingleton
class OrdersRemoteDataSource with HandlingApiManager {
  final DioNetwork dioNetwork;

  OrdersRemoteDataSource({required this.dioNetwork});

  Future<GetOrdersModel> getOrders(GetOrdersParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/orders', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: getOrdersModelFromJson,
    );
  }}