import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/fetch_employees_permissions_model.dart';

@lazySingleton
class FetchEmployeesPermissionsUseCase implements UseCase<FetchEmployeesPermissionsModel, FetchEmployeesPermissionsParams> {

  final ProfileRepo profile;

  FetchEmployeesPermissionsUseCase({required this.profile});

  @override
  DataResponse<FetchEmployeesPermissionsModel> call(FetchEmployeesPermissionsParams params) {
    return profile.fetchEmployeesPermissions(params);
  }
}

class FetchEmployeesPermissionsParams with Params{}
