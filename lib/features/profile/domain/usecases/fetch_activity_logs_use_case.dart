import 'package:common_package/helpers/typedef.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/fetch_activity_logs_model.dart';
import '../repository/profile_repo.dart';

@lazySingleton
class FetchActivityLogsUseCase implements UseCase<FetchActivityLogsModel, FetchActivityLogsParams> {
  final ProfileRepo profile;

  FetchActivityLogsUseCase({required this.profile});

  @override
  DataResponse<FetchActivityLogsModel> call(FetchActivityLogsParams params) {
    return profile.fetchActivityLogs(params);
  }
}

class FetchActivityLogsParams with Params {
  final String? logName;
  final int page;
  final int perPage;

  FetchActivityLogsParams({this.logName, this.page = 1, this.perPage = 15});

  FetchActivityLogsParams copyWith({String? logName, int? page, int? perPage}) {
    return FetchActivityLogsParams(
      logName: logName ?? this.logName,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }

  @override
  QueryParams getParams() {
    return {
      'logName': logName,
      'page': page,
      'perPage': perPage,
    }..removeWhere((key, value) => value == null || (value is String && value.trim().isEmpty));
  }

  @override
  BodyMap getBody() => {};
}
