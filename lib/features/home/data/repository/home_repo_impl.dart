import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/error_handler.dart';

import '../../domain/repository/home_repo.dart';
import 'package:common_package/helpers/typedef.dart';
import '../source/home_remote_data_source.dart';
import '../../domain/usecases/fetch_notifications_use_case.dart';
import '../../domain/usecases/read_all_notifications_use_case.dart';
import '../models/fetch_notifications_model.dart';
import '../models/read_all_notifications_model.dart';
import '../../domain/usecases/home_overview_use_case.dart';
import '../models/home_overview_model.dart';
import '../../domain/usecases/home_overview_performance_use_case.dart';
import '../models/home_overview_performance_model.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl with HandlingException implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});

  @override
  DataResponse<FetchNotificationsModel> fetchNotifications(FetchNotificationsParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.fetchNotifications(params),
    );
  }

  @override
  DataResponse<ReadAllNotificationsModel> readAllNotifications(ReadAllNotificationsParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.readAllNotifications(params),
    );
  }

  @override
  DataResponse<HomeOverviewModel> homeOverview(HomeOverviewParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.homeOverview(params),
    );
  }

  @override
  DataResponse<HomeOverviewPerformanceModel> homeOverviewPerformance(HomeOverviewPerformanceParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.homeOverviewPerformance(params),
    );
  }}

