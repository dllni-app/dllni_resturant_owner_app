import 'package:common_package/helpers/typedef.dart';
import '../usecases/fetch_notifications_use_case.dart';
import '../usecases/read_all_notifications_use_case.dart';
import '../../data/models/fetch_notifications_model.dart';
import '../../data/models/read_all_notifications_model.dart';
import '../usecases/home_overview_use_case.dart';
import '../../data/models/home_overview_model.dart';
import '../usecases/home_overview_performance_use_case.dart';
import '../../data/models/home_overview_performance_model.dart';
abstract class HomeRepo {

  DataResponse<FetchNotificationsModel> fetchNotifications(FetchNotificationsParams params);

  DataResponse<ReadAllNotificationsModel> readAllNotifications();

  DataResponse<HomeOverviewModel> homeOverview(HomeOverviewParams params);

  DataResponse<HomeOverviewPerformanceModel> homeOverviewPerformance(HomeOverviewPerformanceParams params);
}
