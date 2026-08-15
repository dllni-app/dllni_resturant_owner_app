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

class ReadAllNotificationsEvent extends HomeEvent {}

class ReadNotificationEvent extends HomeEvent {
  final String id;

  ReadNotificationEvent({required this.id});
}

class DeleteNotificationEvent extends HomeEvent {
  final String id;

  DeleteNotificationEvent({required this.id});
}

class DeleteAllNotificationsEvent extends HomeEvent {}
