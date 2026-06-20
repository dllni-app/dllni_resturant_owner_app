import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/fetch_coupons_model.dart';

@lazySingleton
class FetchCouponsUseCase implements UseCase<FetchCouponsModel, FetchCouponsParams> {
  final ProfileRepo profile;

  FetchCouponsUseCase({required this.profile});

  @override
  DataResponse<FetchCouponsModel> call(FetchCouponsParams params) {
    return profile.fetchCoupons(params);
  }
}

class FetchCouponsParams with Params {
  final String status;
  final String? search;
  final int page;

  FetchCouponsParams({required this.status, this.search, this.page = 1});

  @override
  QueryParams getParams() {
    return {
      'status': status,
      'search': search,
      'page': page,
      'perPage': 10,
    }..removeWhere((key, value) => value == null || (value is String && value.trim().isEmpty));
  }

  @override
  BodyMap getBody() => {};
}
