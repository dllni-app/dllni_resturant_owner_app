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

CreateProductUsecaseModel createProductUsecaseModelFromJson(str) => CreateProductUsecaseModel.fromJson(str);

String createProductUsecaseModelToJson(CreateProductUsecaseModel data) => json.encode(data.toJson());


CreateProductUsecaseModelData createProductUsecaseModelDataFromJson(str) => CreateProductUsecaseModelData.fromJson(str);

String createProductUsecaseModelDataToJson(CreateProductUsecaseModelData data) => json.encode(data.toJson());


class CreateProductUsecaseModel {
  CreateProductUsecaseModelData? data;
  String? message;

  CreateProductUsecaseModel({
    this.data,
    this.message,
  });

  factory CreateProductUsecaseModel.fromJson(Map<String, dynamic> json) {
    return CreateProductUsecaseModel(
      data: json['data'] is Map ? CreateProductUsecaseModelData.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
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

class CreateProductUsecaseModelData {
  int? id;
  String? name;
  int? price;
  int? stockQuantity;
  int? lowStockThreshold;

  CreateProductUsecaseModelData({
    this.id,
    this.name,
    this.price,
    this.stockQuantity,
    this.lowStockThreshold,
  });

  factory CreateProductUsecaseModelData.fromJson(Map<String, dynamic> json) {
    return CreateProductUsecaseModelData(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      price: _asInt(json['price']),
      stockQuantity: _asInt(json['stockQuantity']),
      lowStockThreshold: _asInt(json['lowStockThreshold']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stockQuantity': stockQuantity,
      'lowStockThreshold': lowStockThreshold,
    };
  }
}