part of 'home_bloc.dart';

abstract class HomeEvent {}

class FetchNotificationsEvent extends HomeEvent {
  final FetchNotificationsParams params;

  FetchNotificationsEvent({required this.params});
}

class HomeOverviewEvent extends HomeEvent {
  final HomeOverviewParams params;

  HomeOverviewEvent({required this.params});
}

class HomeOverviewPerformanceEvent extends HomeEvent {
  final HomeOverviewPerformanceParams params;

  HomeOverviewPerformanceEvent({required this.params});
}
