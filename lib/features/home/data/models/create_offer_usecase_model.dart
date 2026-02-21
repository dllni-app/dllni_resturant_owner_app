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

CreateOfferUsecaseModel createOfferUsecaseModelFromJson(str) => CreateOfferUsecaseModel.fromJson(str);

String createOfferUsecaseModelToJson(CreateOfferUsecaseModel data) => json.encode(data.toJson());


CreateOfferUsecaseModelData createOfferUsecaseModelDataFromJson(str) => CreateOfferUsecaseModelData.fromJson(str);

String createOfferUsecaseModelDataToJson(CreateOfferUsecaseModelData data) => json.encode(data.toJson());


class CreateOfferUsecaseModel {
  CreateOfferUsecaseModelData? data;
  String? message;

  CreateOfferUsecaseModel({
    this.data,
    this.message,
  });

  factory CreateOfferUsecaseModel.fromJson(Map<String, dynamic> json) {
    return CreateOfferUsecaseModel(
      data: json['data'] is Map ? CreateOfferUsecaseModelData.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
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

class CreateOfferUsecaseModelData {
  int? id;
  String? title;
  int? discountPercentage;
  String? startsAt;
  String? endsAt;

  CreateOfferUsecaseModelData({
    this.id,
    this.title,
    this.discountPercentage,
    this.startsAt,
    this.endsAt,
  });

  factory CreateOfferUsecaseModelData.fromJson(Map<String, dynamic> json) {
    return CreateOfferUsecaseModelData(
      id: _asInt(json['id']),
      title: _asString(json['title']),
      discountPercentage: _asInt(json['discountPercentage']),
      startsAt: _asString(json['startsAt']),
      endsAt: _asString(json['endsAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'discountPercentage': discountPercentage,
      'startsAt': startsAt,
      'endsAt': endsAt,
    };
  }
}