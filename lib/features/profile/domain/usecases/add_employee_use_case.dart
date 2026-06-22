import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/add_employee_model.dart';

@lazySingleton
class AddEmployeeUseCase implements UseCase<AddEmployeeModel, AddEmployeeParams> {
  final ProfileRepo profile;

  AddEmployeeUseCase({required this.profile});

  @override
  DataResponse<AddEmployeeModel> call(AddEmployeeParams params) {
    return profile.addEmployee(params);
  }
}

class AddEmployeeParams with Params {
  final String? name;
  final String? phone;
  final String? password;
  final bool? isActive;
  final File? image;
  final List<int>? permissions;

  final bool isAddNew;
  final bool isDelete;
  final int? id;

  AddEmployeeParams({
    this.name,
    this.phone,
    this.image,
    this.permissions,
    this.password,
    this.isActive,
    this.isAddNew = true,
    this.isDelete = false,
    this.id,
  });

  @override
  BodyMap getBody() => {
    'name': name,
    'phone': phone,
    'password': password,
    if (isActive != null) 'isActive': isActive == true ? 1 : 0,
    'profileImage': image,
    'permissionIds': permissions,
  }..removeWhere((key, val) => val == null);
}
