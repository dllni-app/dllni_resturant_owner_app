part of 'orders_bloc.dart';

abstract class OrdersEvent {}

class GetOrdersEvent extends OrdersEvent with EventWithReload {
  final GetOrdersParams params;

  @override
  final bool isReload;

  GetOrdersEvent({required this.params, this.isReload = false});
}

class GetHomePreparingOrdersEvent extends OrdersEvent {
  final GetOrdersParams params;

  GetHomePreparingOrdersEvent({required this.params});
}

class GetOrderDetailsEvent extends OrdersEvent {
  final GetOrderDetailsParams params;

  GetOrderDetailsEvent({required this.params});
}

class AcceptOrderEvent extends OrdersEvent {
  final AcceptOrderParams params;

  AcceptOrderEvent({required this.params});
}

class RejectOrderEvent extends OrdersEvent {
  final RejectOrderParams params;

  RejectOrderEvent({required this.params});
}

class ChangeOrderStatusEvent extends OrdersEvent {
  final ChangeOrderStatusParams params;

  ChangeOrderStatusEvent({required this.params});
}

class AddOrderItemEvent extends OrdersEvent {
  final AddOrderItemParams params;

  AddOrderItemEvent({required this.params});
}

class UpdateOrderItemEvent extends OrdersEvent {
  final UpdateOrderItemParams params;

  UpdateOrderItemEvent({required this.params});
}

class DeleteOrderItemEvent extends OrdersEvent {
  final DeleteOrderItemParams params;

  DeleteOrderItemEvent({required this.params});
}
