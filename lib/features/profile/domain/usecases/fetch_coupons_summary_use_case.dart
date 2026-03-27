import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/fetch_coupons_summary_model.dart';

@lazySingleton
class FetchCouponsSummaryUseCase implements UseCase<FetchCouponsSummaryModel, FetchCouponsSummaryParams> {

  final ProfileRepo profile;

  FetchCouponsSummaryUseCase({required this.profile});

  @override
  DataResponse<FetchCouponsSummaryModel> call(FetchCouponsSummaryParams params) {
    return profile.fetchCouponsSummary(params);
  }
}

class FetchCouponsSummaryParams with Params{}
