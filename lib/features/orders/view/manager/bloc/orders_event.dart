part of 'orders_bloc.dart';

abstract class OrdersEvent {}

class GetOrdersEvent extends OrdersEvent with EventWithReload {
  final GetOrdersParams params;

  @override
  final bool isReload;

  GetOrdersEvent({required this.params, this.isReload = false});
}
