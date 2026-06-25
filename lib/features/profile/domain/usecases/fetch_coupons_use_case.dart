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
  final String? dateFrom;
  final String? dateTo;
  final String? sort;
  final int page;
  final int perPage;

  FetchCouponsParams({
    required this.status,
    this.search,
    this.dateFrom,
    this.dateTo,
    this.sort = '-created_at',
    this.page = 1,
    this.perPage = 10,
  });

  FetchCouponsParams copyWith({
    String? status,
    String? search,
    String? dateFrom,
    String? dateTo,
    String? sort,
    int? page,
    int? perPage,
  }) {
    return FetchCouponsParams(
      status: status ?? this.status,
      search: search ?? this.search,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      sort: sort ?? this.sort,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }

  @override
  QueryParams getParams() {
    return {
      'status': status,
      'search': search,
      'dateFrom': dateFrom,
      'dateTo': dateTo,
      'sort': sort,
      'page': page,
      'perPage': perPage,
    }..removeWhere((key, value) => value == null || (value is String && value.trim().isEmpty));
  }

  @override
  BodyMap getBody() => {};
}
