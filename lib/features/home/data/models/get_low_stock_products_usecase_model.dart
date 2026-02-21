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

GetLowStockProductsUsecaseModel getLowStockProductsUsecaseModelFromJson(str) => GetLowStockProductsUsecaseModel.fromJson(str);

String getLowStockProductsUsecaseModelToJson(GetLowStockProductsUsecaseModel data) => json.encode(data.toJson());


GetLowStockProductsUsecaseModelMeta getLowStockProductsUsecaseModelMetaFromJson(str) => GetLowStockProductsUsecaseModelMeta.fromJson(str);

String getLowStockProductsUsecaseModelMetaToJson(GetLowStockProductsUsecaseModelMeta data) => json.encode(data.toJson());


GetLowStockProductsUsecaseModelDataItem getLowStockProductsUsecaseModelDataItemFromJson(str) => GetLowStockProductsUsecaseModelDataItem.fromJson(str);

String getLowStockProductsUsecaseModelDataItemToJson(GetLowStockProductsUsecaseModelDataItem data) => json.encode(data.toJson());


class GetLowStockProductsUsecaseModel {
  List<GetLowStockProductsUsecaseModelDataItem>? data;
  GetLowStockProductsUsecaseModelMeta? meta;

  GetLowStockProductsUsecaseModel({
    this.data,
    this.meta,
  });

  factory GetLowStockProductsUsecaseModel.fromJson(Map<String, dynamic> json) {
    return GetLowStockProductsUsecaseModel(
      data: json['data'] is List ? (json['data'] as List).whereType<Map>().map((item) => GetLowStockProductsUsecaseModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      meta: json['meta'] is Map ? GetLowStockProductsUsecaseModelMeta.fromJson(Map<String, dynamic>.from(json['meta'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}

class GetLowStockProductsUsecaseModelMeta {
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;

  GetLowStockProductsUsecaseModelMeta({
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
  });

  factory GetLowStockProductsUsecaseModelMeta.fromJson(Map<String, dynamic> json) {
    return GetLowStockProductsUsecaseModelMeta(
      currentPage: _asInt(json['current_page']),
      perPage: _asInt(json['per_page']),
      total: _asInt(json['total']),
      lastPage: _asInt(json['last_page']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'per_page': perPage,
      'total': total,
      'last_page': lastPage,
    };
  }
}

class GetLowStockProductsUsecaseModelDataItem {
  int? id;
  String? name;
  int? stockQuantity;
  int? lowStockThreshold;

  GetLowStockProductsUsecaseModelDataItem({
    this.id,
    this.name,
    this.stockQuantity,
    this.lowStockThreshold,
  });

  factory GetLowStockProductsUsecaseModelDataItem.fromJson(Map<String, dynamic> json) {
    return GetLowStockProductsUsecaseModelDataItem(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      stockQuantity: _asInt(json['stockQuantity']),
      lowStockThreshold: _asInt(json['lowStockThreshold']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stockQuantity': stockQuantity,
      'lowStockThreshold': lowStockThreshold,
    };
  }
}