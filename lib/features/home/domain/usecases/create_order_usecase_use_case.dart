import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/create_order_usecase_model.dart';

@lazySingleton
class CreateOrderUsecaseUseCase implements UseCase<CreateOrderUsecaseModel, CreateOrderUsecaseParams> {
  final HomeRepo home;

  CreateOrderUsecaseUseCase({required this.home});

  @override
  DataResponse<CreateOrderUsecaseModel> call(CreateOrderUsecaseParams params) {
    return home.createOrderUsecase(params);
  }
}

class CreateOrderUsecaseParams with Params {
  final int restaurantId;
  final int userId;
  final List<OrderItem> orderItems;

  CreateOrderUsecaseParams({required this.restaurantId, required this.userId, required this.orderItems});

  @override
  BodyMap getBody() => {
    "restaurantId": '$restaurantId',
    "userId": '$userId',
    "orderItems": List.generate(
      orderItems.length,
      (index) => {"productId": '${orderItems[index].productId}', "quantity": '${orderItems[index].quantity}'},
    ),
  };
}

class OrderItem {
  final int productId;
  final int quantity;

  OrderItem({required this.productId, required this.quantity});
}
