import 'package:common_package/common_package.dart';
import 'package:injectable/injectable.dart';
import '../models/fetch_notifications_model.dart';
import '../models/read_all_notifications_model.dart';
import '../../domain/usecases/fetch_notifications_use_case.dart';
import '../../domain/usecases/read_all_notifications_use_case.dart';
import '../models/home_overview_model.dart';
import '../../domain/usecases/home_overview_use_case.dart';
import '../models/home_overview_performance_model.dart';
import '../../domain/usecases/home_overview_performance_use_case.dart';

@lazySingleton
class HomeRemoteDataSource with HandlingApiManager {
  final DioNetwork dioNetwork;

  HomeRemoteDataSource({required this.dioNetwork});

  Future<FetchNotificationsModel> fetchNotifications(FetchNotificationsParams params) {
    // #region agent log
    agentDebugLog(
      hypothesisId: 'H2',
      location: 'home_remote_data_source.dart:fetchNotifications',
      message: 'notifications GET shape',
      data: {
        'queryParams': params.getParams().toString(),
        'body': params.getBody().toString(),
        'endpoint': '/api/v1/restaurant-owner/notifications',
      },
    );
    // #endregion
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/notifications', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchNotificationsModelFromJson,
    );
  }

  Future<ReadAllNotificationsModel> readAllNotifications(ReadAllNotificationsParams params) {
    return wrapHandlingApi(
      tryCall: () =>
          dioNetwork.patchData(endPoint: '/api/v1/restaurant-owner/notifications/read-all', data: params.getBody(), params: params.getParams()),
      jsonConvert: readAllNotificationsModelFromJson,
    );
  }

  Future<HomeOverviewModel> homeOverview(HomeOverviewParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/dashboard/overview', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: homeOverviewModelFromJson,
    );
  }

  Future<HomeOverviewPerformanceModel> homeOverviewPerformance(HomeOverviewPerformanceParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/dashboard/performance', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: homeOverviewPerformanceModelFromJson,
    );
  }}