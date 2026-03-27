import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/home_overview_performance_model.dart';

@lazySingleton
class HomeOverviewPerformanceUseCase implements UseCase<HomeOverviewPerformanceModel, HomeOverviewPerformanceParams> {
  final HomeRepo home;

  HomeOverviewPerformanceUseCase({required this.home});

  @override
  DataResponse<HomeOverviewPerformanceModel> call(HomeOverviewPerformanceParams params) {
    return home.homeOverviewPerformance(params);
  }
}

class HomeOverviewPerformanceParams with Params {
  final String? range;

  HomeOverviewPerformanceParams({this.range});

  @override
  QueryParams getParams() => {'range': range}..removeWhere((key, value) => value == null);
}
