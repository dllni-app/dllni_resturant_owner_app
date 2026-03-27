import 'dart:convert';

String? _asString(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is num || value is bool) return value.toString();
  return null;
}

int? _asInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) {
    return int.tryParse(value) ?? double.tryParse(value)?.toInt();
  }
  return null;
}

double? _asDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

num? _asNum(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) return num.tryParse(value);
  return null;
}

bool? _asBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) {
    if (value == 1) return true;
    if (value == 0) return false;
  }
  if (value is String) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'true' || normalized == '1') return true;
    if (normalized == 'false' || normalized == '0') return false;
  }
  return null;
}

List<dynamic>? _asDynamicList(dynamic value) {
  if (value is! List) return null;
  return value.map(_asDynamic).toList();
}

dynamic _asDynamic(dynamic value) {
  if (value == null) return null;
  if (value is List) {
    return value.map(_asDynamic).toList();
  }
  if (value is Map) {
    final map = <String, dynamic>{};
    value.forEach((key, nestedValue) {
      map['$key'] = _asDynamic(nestedValue);
    });
    return map;
  }
  if (value is String || value is num || value is bool) {
    return value;
  }
  return value.toString();
}

AddEmployeeModel addEmployeeModelFromJson(str) => AddEmployeeModel.fromJson(str);

String addEmployeeModelToJson(AddEmployeeModel data) => json.encode(data.toJson());


AddEmployeeModelData addEmployeeModelDataFromJson(str) => AddEmployeeModelData.fromJson(str);

String addEmployeeModelDataToJson(AddEmployeeModelData data) => json.encode(data.toJson());


AddEmployeeModelDataUser addEmployeeModelDataUserFromJson(str) => AddEmployeeModelDataUser.fromJson(str);

String addEmployeeModelDataUserToJson(AddEmployeeModelDataUser data) => json.encode(data.toJson());


class AddEmployeeModel {
  AddEmployeeModelData? data;
  String? message;

  AddEmployeeModel({
    this.data,
    this.message,
  });

  factory AddEmployeeModel.fromJson(Map<String, dynamic> json) {
    return AddEmployeeModel(
      data: json['data'] is Map ? AddEmployeeModelData.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
      message: _asString(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class AddEmployeeModelData {
  int? id;
  int? restaurantId;
  int? userId;
  bool? isActive;
  AddEmployeeModelDataUser? user;
  String? permissionIds;
  String? effectivePermissions;
  String? createdAt;
  String? updatedAt;

  AddEmployeeModelData({
    this.id,
    this.restaurantId,
    this.userId,
    this.isActive,
    this.user,
    this.permissionIds,
    this.effectivePermissions,
    this.createdAt,
    this.updatedAt,
  });

  factory AddEmployeeModelData.fromJson(Map<String, dynamic> json) {
    return AddEmployeeModelData(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurantId']),
      userId: _asInt(json['userId']),
      isActive: _asBool(json['isActive']),
      user: json['user'] is Map ? AddEmployeeModelDataUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)) : null,
      permissionIds: _asString(json['permissionIds']),
      effectivePermissions: _asString(json['effectivePermissions']),
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'userId': userId,
      'isActive': isActive,
      'user': user?.toJson(),
      'permissionIds': permissionIds,
      'effectivePermissions': effectivePermissions,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class AddEmployeeModelDataUser {
  String? id;
  String? name;
  String? email;
  String? phone;

  AddEmployeeModelDataUser({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  factory AddEmployeeModelDataUser.fromJson(Map<String, dynamic> json) {
    return AddEmployeeModelDataUser(
      id: _asString(json['id']),
      name: _asString(json['name']),
      email: _asString(json['email']),
      phone: _asString(json['phone']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}