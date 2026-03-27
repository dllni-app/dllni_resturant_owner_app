part of 'home_bloc.dart';

class HomeState {
  BlocStatus? homeOverviewPerformanceStatus;
  HomeOverviewPerformanceModel? homeOverviewPerformance;
  BlocStatus? notificationsStatus;
  FetchNotificationsModel? notifications;
  BlocStatus? homeOverviewStatus;
  HomeOverviewModel? homeOverview;
  String? errorMessage;

  HomeState({
    this.errorMessage,
    this.homeOverview,
    this.homeOverviewStatus,
    this.notifications,
    this.notificationsStatus,
    this.homeOverviewPerformance,
    this.homeOverviewPerformanceStatus,
  });

  HomeState copyWith({
    String? errorMessage,
    HomeOverviewModel? homeOverview,
    BlocStatus? homeOverviewStatus,
    FetchNotificationsModel? notifications,
    BlocStatus? notificationsStatus,
    HomeOverviewPerformanceModel? homeOverviewPerformance,
    BlocStatus? homeOverviewPerformanceStatus,
  }) => HomeState(
    errorMessage: errorMessage ?? this.errorMessage,
    homeOverview: homeOverview ?? this.homeOverview,
    homeOverviewStatus: homeOverviewStatus ?? this.homeOverviewStatus,
    notifications: notifications ?? this.notifications,
    notificationsStatus: notificationsStatus ?? this.notificationsStatus,
    homeOverviewPerformance: homeOverviewPerformance ?? this.homeOverviewPerformance,
    homeOverviewPerformanceStatus: homeOverviewPerformanceStatus ?? this.homeOverviewPerformanceStatus,
  );
}
