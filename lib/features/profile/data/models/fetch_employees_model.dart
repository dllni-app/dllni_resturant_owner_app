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

FetchEmployeesModel fetchEmployeesModelFromJson(str) => FetchEmployeesModel.fromJson(str);

String fetchEmployeesModelToJson(FetchEmployeesModel data) => json.encode(data.toJson());


FetchEmployeesModelDataItem fetchEmployeesModelDataItemFromJson(str) => FetchEmployeesModelDataItem.fromJson(str);

String fetchEmployeesModelDataItemToJson(FetchEmployeesModelDataItem data) => json.encode(data.toJson());


FetchEmployeesModelDataItemUser fetchEmployeesModelDataItemUserFromJson(str) => FetchEmployeesModelDataItemUser.fromJson(str);

String fetchEmployeesModelDataItemUserToJson(FetchEmployeesModelDataItemUser data) => json.encode(data.toJson());


class FetchEmployeesModel {
  List<FetchEmployeesModelDataItem>? data;

  FetchEmployeesModel({
    this.data,
  });

  factory FetchEmployeesModel.fromJson(Map<String, dynamic> json) {
    return FetchEmployeesModel(
      data: json['data'] is List ? (json['data'] as List).whereType<Map>().map((item) => FetchEmployeesModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class FetchEmployeesModelDataItem {
  int? id;
  int? restaurantId;
  int? userId;
  bool? isActive;
  FetchEmployeesModelDataItemUser? user;
  List<dynamic>? permissionIds;
  List<dynamic>? effectivePermissions;
  String? createdAt;
  String? updatedAt;

  FetchEmployeesModelDataItem({
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

  factory FetchEmployeesModelDataItem.fromJson(Map<String, dynamic> json) {
    return FetchEmployeesModelDataItem(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurantId']),
      userId: _asInt(json['userId']),
      isActive: _asBool(json['isActive']),
      user: json['user'] is Map ? FetchEmployeesModelDataItemUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)) : null,
      permissionIds: _asDynamicList(json['permissionIds']),
      effectivePermissions: _asDynamicList(json['effectivePermissions']),
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

class FetchEmployeesModelDataItemUser {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? profileImageUrl;

  FetchEmployeesModelDataItemUser({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profileImageUrl,
  });

  factory FetchEmployeesModelDataItemUser.fromJson(Map<String, dynamic> json) {
    return FetchEmployeesModelDataItemUser(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      email: _asString(json['email']),
      phone: _asString(json['phone']),
      profileImageUrl: _asString(json['profileImageUrl']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
    };
  }
}