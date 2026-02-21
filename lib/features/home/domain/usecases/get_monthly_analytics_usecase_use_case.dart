import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/get_monthly_analytics_usecase_model.dart';

@lazySingleton
class GetMonthlyAnalyticsUsecaseUseCase implements UseCase<GetMonthlyAnalyticsUsecaseModel, GetMonthlyAnalyticsUsecaseParams> {

  final HomeRepo home;

  GetMonthlyAnalyticsUsecaseUseCase({required this.home});

  @override
  DataResponse<GetMonthlyAnalyticsUsecaseModel> call(GetMonthlyAnalyticsUsecaseParams params) {
    return home.getMonthlyAnalyticsUsecase(params);
  }
}

class GetMonthlyAnalyticsUsecaseParams with Params{}
