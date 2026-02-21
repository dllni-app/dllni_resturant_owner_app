import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/get_dashboard_overview_usecase_model.dart';

@lazySingleton
class GetDashboardOverviewUsecaseUseCase implements UseCase<GetDashboardOverviewUsecaseModel, GetDashboardOverviewUsecaseParams> {

  final HomeRepo home;

  GetDashboardOverviewUsecaseUseCase({required this.home});

  @override
  DataResponse<GetDashboardOverviewUsecaseModel> call(GetDashboardOverviewUsecaseParams params) {
    return home.getDashboardOverviewUsecase(params);
  }
}

class GetDashboardOverviewUsecaseParams with Params{
  final int restaurantId;

  GetDashboardOverviewUsecaseParams({required this.restaurantId});

  @override
  QueryParams getParams() => {
    'restaurantId': '$restaurantId',
  };
}
