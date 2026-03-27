import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/fetch_working_time_model.dart';

@lazySingleton
class FetchWorkingTimeUseCase implements UseCase<FetchWorkingTimeModel, FetchWorkingTimeParams> {

  final ProfileRepo profile;

  FetchWorkingTimeUseCase({required this.profile});

  @override
  DataResponse<FetchWorkingTimeModel> call(FetchWorkingTimeParams params) {
    return profile.fetchWorkingTime(params);
  }
}

class FetchWorkingTimeParams with Params{}
