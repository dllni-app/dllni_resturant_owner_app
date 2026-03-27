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

List<int>? _asIntList(dynamic value) {
  if (value == null) return null;
  if (value is List) {
    return value.map((e) => _asInt(e)).whereType<int>().toList();
  }
  return null;
}

CreateOfferModel createOfferModelFromJson(str) => CreateOfferModel.fromJson(str);

String createOfferModelToJson(CreateOfferModel data) => json.encode(data.toJson());

class CreateOfferModel {
  int? restaurantId;
  String? name;
  String? discountType;
  double? discountValue;
  String? startsAt;
  String? endsAt;
  bool? isActive;
  List<int>? productIds;

  CreateOfferModel({
    this.restaurantId,
    this.name,
    this.discountType,
    this.discountValue,
    this.startsAt,
    this.endsAt,
    this.isActive,
    this.productIds,
  });

  factory CreateOfferModel.fromJson(Map<String, dynamic> json) {
    return CreateOfferModel(
      restaurantId: _asInt(json['restaurantId']),
      name: _asString(json['name']),
      discountType: _asString(json['discountType']),
      discountValue: _asDouble(json['discountValue']),
      startsAt: _asString(json['startsAt']),
      endsAt: _asString(json['endsAt']),
      isActive: _asBool(json['isActive']),
      productIds: _asIntList(json['productIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'name': name,
      'discountType': discountType,
      'discountValue': discountValue,
      'startsAt': startsAt,
      'endsAt': endsAt,
      'isActive': isActive,
      'productIds': productIds,
    };
  }
}


