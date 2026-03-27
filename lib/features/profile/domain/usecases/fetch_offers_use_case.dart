import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/fetch_offers_model.dart';

@lazySingleton
class FetchOffersUseCase implements UseCase<FetchOffersModel, FetchOffersParams> {
  final ProfileRepo profile;

  FetchOffersUseCase({required this.profile});

  @override
  DataResponse<FetchOffersModel> call(FetchOffersParams params) {
    return profile.fetchOffers(params);
  }
}

class FetchOffersParams with Params {
  final int page;
  final String? name;
  final String? dateFrom;
  final String? dateTo;
  final String? status;

  FetchOffersParams({required this.page, this.name, this.dateFrom, this.dateTo, this.status}); // "active|scheduled|expired|all"

  @override
  QueryParams getParams() =>
      {"status": status, "search": name, "dateFrom": dateFrom, "dateTo": dateTo, "perPage": 10, "page": page}..removeWhere((key, val) => val == null);

  @override
  BodyMap getBody() => {};
}
