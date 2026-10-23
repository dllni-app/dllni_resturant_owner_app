import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/add_employee_model.dart';

@lazySingleton
class AddEmployeeUseCase
    implements UseCase<AddEmployeeModel, AddEmployeeParams> {
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

  static String? normalizedPhone(String? value) {
    if (value == null) return null;
    final cleaned = value.trim().replaceAll(RegExp(r'[\s()-]'), '');
    final digits = cleaned.startsWith('+') ? cleaned.substring(1) : cleaned;
    final match = RegExp(r'^(?:00963|963|0)?(9[0-9]{8})$').firstMatch(digits);
    return match != null ? '+963${match.group(1)}' : cleaned;
  }

  @override
  BodyMap getBody() => {
    'name': name,
    'phone': normalizedPhone(phone),
    'password': password,
    if (isActive != null) 'isActive': isActive == true ? 1 : 0,
    'profileImage': image,
    'permissionIds': permissions,
    if (!isAddNew && !isDelete) 'syncPermissions': 1,
  }..removeWhere((key, val) => val == null);
}
