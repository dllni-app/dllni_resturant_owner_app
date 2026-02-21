import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/get_daily_analytics_usecase_model.dart';

@lazySingleton
class GetDailyAnalyticsUsecaseUseCase implements UseCase<GetDailyAnalyticsUsecaseModel, GetDailyAnalyticsUsecaseParams> {

  final HomeRepo home;

  GetDailyAnalyticsUsecaseUseCase({required this.home});

  @override
  DataResponse<GetDailyAnalyticsUsecaseModel> call(GetDailyAnalyticsUsecaseParams params) {
    return home.getDailyAnalyticsUsecase(params);
  }
}

class GetDailyAnalyticsUsecaseParams with Params{}
