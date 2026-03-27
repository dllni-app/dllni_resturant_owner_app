import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/home_overview_model.dart';

@lazySingleton
class HomeOverviewUseCase implements UseCase<HomeOverviewModel, HomeOverviewParams> {

  final HomeRepo home;

  HomeOverviewUseCase({required this.home});

  @override
  DataResponse<HomeOverviewModel> call(HomeOverviewParams params) {
    return home.homeOverview(params);
  }
}

class HomeOverviewParams with Params{}
