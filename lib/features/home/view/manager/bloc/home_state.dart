part of 'home_bloc.dart';

class HomeState {
  BlocStatus? homeOverviewPerformanceStatus;
  HomeOverviewPerformanceModel? homeOverviewPerformance;
  BlocStatus? notificationsStatus;
  BlocStatus? readNotificationsStatus;
  FetchNotificationsModel? notifications;
  BlocStatus? homeOverviewStatus;
  HomeOverviewModel? homeOverview;
  String? errorMessage;
  int? unreadNumber;

  HomeState({
    this.errorMessage,
    this.homeOverview,
    this.homeOverviewStatus,
    this.notifications,
    this.notificationsStatus,
    this.homeOverviewPerformance,
    this.homeOverviewPerformanceStatus,
    this.unreadNumber,
    this.readNotificationsStatus,
  });

  HomeState copyWith({
    String? errorMessage,
    HomeOverviewModel? homeOverview,
    BlocStatus? homeOverviewStatus,
    BlocStatus? readNotificationsStatus,
    FetchNotificationsModel? notifications,
    BlocStatus? notificationsStatus,
    HomeOverviewPerformanceModel? homeOverviewPerformance,
    BlocStatus? homeOverviewPerformanceStatus,
    int? unreadNumber,
  }) => HomeState(
    errorMessage: errorMessage ?? this.errorMessage,
    unreadNumber: unreadNumber ?? this.unreadNumber,
    homeOverview: homeOverview ?? this.homeOverview,
    readNotificationsStatus: readNotificationsStatus ?? this.readNotificationsStatus,
    homeOverviewStatus: homeOverviewStatus ?? this.homeOverviewStatus,
    notifications: notifications ?? this.notifications,
    notificationsStatus: notificationsStatus ?? this.notificationsStatus,
    homeOverviewPerformance: homeOverviewPerformance ?? this.homeOverviewPerformance,
    homeOverviewPerformanceStatus: homeOverviewPerformanceStatus ?? this.homeOverviewPerformanceStatus,
  );
}
