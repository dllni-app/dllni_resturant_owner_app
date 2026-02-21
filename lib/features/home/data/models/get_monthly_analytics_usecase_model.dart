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

GetMonthlyAnalyticsUsecaseModel getMonthlyAnalyticsUsecaseModelFromJson(str) => GetMonthlyAnalyticsUsecaseModel.fromJson(str);

String getMonthlyAnalyticsUsecaseModelToJson(GetMonthlyAnalyticsUsecaseModel data) => json.encode(data.toJson());


GetMonthlyAnalyticsUsecaseModelData getMonthlyAnalyticsUsecaseModelDataFromJson(str) => GetMonthlyAnalyticsUsecaseModelData.fromJson(str);

String getMonthlyAnalyticsUsecaseModelDataToJson(GetMonthlyAnalyticsUsecaseModelData data) => json.encode(data.toJson());


class GetMonthlyAnalyticsUsecaseModel {
  GetMonthlyAnalyticsUsecaseModelData? data;

  GetMonthlyAnalyticsUsecaseModel({
    this.data,
  });

  factory GetMonthlyAnalyticsUsecaseModel.fromJson(Map<String, dynamic> json) {
    return GetMonthlyAnalyticsUsecaseModel(
      data: json['data'] is Map ? GetMonthlyAnalyticsUsecaseModelData.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class GetMonthlyAnalyticsUsecaseModelData {
  String? month;
  int? totalSales;
  int? totalOrders;
  int? completedOrders;
  int? cancelledOrders;

  GetMonthlyAnalyticsUsecaseModelData({
    this.month,
    this.totalSales,
    this.totalOrders,
    this.completedOrders,
    this.cancelledOrders,
  });

  factory GetMonthlyAnalyticsUsecaseModelData.fromJson(Map<String, dynamic> json) {
    return GetMonthlyAnalyticsUsecaseModelData(
      month: _asString(json['month']),
      totalSales: _asInt(json['totalSales']),
      totalOrders: _asInt(json['totalOrders']),
      completedOrders: _asInt(json['completedOrders']),
      cancelledOrders: _asInt(json['cancelledOrders']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'totalSales': totalSales,
      'totalOrders': totalOrders,
      'completedOrders': completedOrders,
      'cancelledOrders': cancelledOrders,
    };
  }
}