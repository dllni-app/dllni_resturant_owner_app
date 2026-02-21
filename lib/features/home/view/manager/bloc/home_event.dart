part of 'home_bloc.dart';

abstract class HomeEvent {}

class GetDashboardOverviewUsecaseEvent extends HomeEvent {
  final GetDashboardOverviewUsecaseParams params;

  GetDashboardOverviewUsecaseEvent({required this.params});
}

class GetOrdersUsecaseEvent extends HomeEvent with EventWithReload {
  final GetOrdersUsecaseParams params;

  @override
  final bool isReload;

  GetOrdersUsecaseEvent({required this.params, this.isReload = false});
}

class GetLowStockProductsUsecaseEvent extends HomeEvent with EventWithReload {
  final GetLowStockProductsUsecaseParams params;

  @override
  final bool isReload;

  GetLowStockProductsUsecaseEvent({required this.params, this.isReload = false});
}

class AcceptOrderUsecaseEvent extends HomeEvent {
  final AcceptOrderUsecaseParams params;

  AcceptOrderUsecaseEvent({required this.params});
}

class RejectOrderUsecaseEvent extends HomeEvent {
  final RejectOrderUsecaseParams params;

  RejectOrderUsecaseEvent({required this.params});
}

class GetDailyAnalyticsUsecaseEvent extends HomeEvent {
  final GetDailyAnalyticsUsecaseParams params;

  GetDailyAnalyticsUsecaseEvent({required this.params});
}

class GetMonthlyAnalyticsUsecaseEvent extends HomeEvent {
  final GetMonthlyAnalyticsUsecaseParams params;

  GetMonthlyAnalyticsUsecaseEvent({required this.params});
}

class CreateProductUsecaseEvent extends HomeEvent {
  final CreateProductUsecaseParams params;

  CreateProductUsecaseEvent({required this.params});
}

class CreateOfferUsecaseEvent extends HomeEvent {
  final CreateOfferUsecaseParams params;

  CreateOfferUsecaseEvent({required this.params});
}

class CreateOrderUsecaseEvent extends HomeEvent {
  final CreateOrderUsecaseParams params;

  CreateOrderUsecaseEvent({required this.params});
}
