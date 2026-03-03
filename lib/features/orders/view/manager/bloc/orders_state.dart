part of 'orders_bloc.dart';

class OrdersState {
  PaginationStateModel<GetOrdersModelDataItem>? orders;
  String? errorMessage;

  OrdersState({this.errorMessage, this.orders = const PaginationStateModel(perPage: 10)});

  OrdersState copyWith({String? errorMessage, PaginationStateModel<GetOrdersModelDataItem>? orders}) =>
      OrdersState(errorMessage: errorMessage ?? this.errorMessage, orders: orders ?? this.orders);
}
