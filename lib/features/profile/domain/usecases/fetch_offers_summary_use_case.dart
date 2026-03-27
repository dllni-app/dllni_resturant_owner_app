import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/fetch_offers_summary_model.dart';

@lazySingleton
class FetchOffersSummaryUseCase implements UseCase<FetchOffersSummaryModel, FetchOffersSummaryParams> {

  final ProfileRepo profile;

  FetchOffersSummaryUseCase({required this.profile});

  @override
  DataResponse<FetchOffersSummaryModel> call(FetchOffersSummaryParams params) {
    return profile.fetchOffersSummary(params);
  }
}

class FetchOffersSummaryParams with Params{}
