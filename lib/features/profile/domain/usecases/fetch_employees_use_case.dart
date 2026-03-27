import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/fetch_employees_model.dart';

@lazySingleton
class FetchEmployeesUseCase implements UseCase<FetchEmployeesModel, FetchEmployeesParams> {

  final ProfileRepo profile;

  FetchEmployeesUseCase({required this.profile});

  @override
  DataResponse<FetchEmployeesModel> call(FetchEmployeesParams params) {
    return profile.fetchEmployees(params);
  }
}

class FetchEmployeesParams with Params{}
