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

CreateCouponModel createCouponModelFromJson(str) => CreateCouponModel.fromJson(str);

String createCouponModelToJson(CreateCouponModel data) => json.encode(data.toJson());

class CreateCouponModel {
  int? id;
  int? restaurantId;
  String? code;
  String? discountType;
  double? discountValue;
  double? minOrderAmount;
  int? usageLimit;
  int? usageCount;
  String? startsAt;
  String? endsAt;
  bool? isActive;

  CreateCouponModel({
    this.id,
    this.restaurantId,
    this.code,
    this.discountType,
    this.discountValue,
    this.minOrderAmount,
    this.usageLimit,
    this.usageCount,
    this.startsAt,
    this.endsAt,
    this.isActive,
  });

  factory CreateCouponModel.fromJson(Map<String, dynamic> json) {
    return CreateCouponModel(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurantId']),
      code: _asString(json['code']),
      discountType: _asString(json['discountType']),
      discountValue: _asDouble(json['discountValue']),
      minOrderAmount: _asDouble(json['minOrderAmount']),
      usageLimit: _asInt(json['usageLimit']),
      usageCount: _asInt(json['usageCount']),
      startsAt: _asString(json['startsAt']),
      endsAt: _asString(json['endsAt']),
      isActive: _asBool(json['isActive']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'code': code,
      'discountType': discountType,
      'discountValue': discountValue,
      'minOrderAmount': minOrderAmount,
      'usageLimit': usageLimit,
      'usageCount': usageCount,
      'startsAt': startsAt,
      'endsAt': endsAt,
      'isActive': isActive,
    };
  }
}

