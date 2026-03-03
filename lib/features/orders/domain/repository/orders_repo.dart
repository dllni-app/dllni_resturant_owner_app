import 'package:common_package/helpers/typedef.dart';
import '../usecases/get_orders_use_case.dart';
import '../../data/models/get_orders_model.dart';
abstract class OrdersRepo {
  DataResponse<GetOrdersModel> getOrders(GetOrdersParams params);
}
