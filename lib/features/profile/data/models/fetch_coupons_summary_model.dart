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

FetchCouponsSummaryModel fetchCouponsSummaryModelFromJson(str) => FetchCouponsSummaryModel.fromJson(str);

String fetchCouponsSummaryModelToJson(FetchCouponsSummaryModel data) => json.encode(data.toJson());


FetchCouponsSummaryModelSummary fetchCouponsSummaryModelSummaryFromJson(str) => FetchCouponsSummaryModelSummary.fromJson(str);

String fetchCouponsSummaryModelSummaryToJson(FetchCouponsSummaryModelSummary data) => json.encode(data.toJson());


FetchCouponsSummaryModelSummaryTopPerforming fetchCouponsSummaryModelSummaryTopPerformingFromJson(str) => FetchCouponsSummaryModelSummaryTopPerforming.fromJson(str);

String fetchCouponsSummaryModelSummaryTopPerformingToJson(FetchCouponsSummaryModelSummaryTopPerforming data) => json.encode(data.toJson());


class FetchCouponsSummaryModel {
  FetchCouponsSummaryModelSummary? summary;

  FetchCouponsSummaryModel({
    this.summary,
  });

  factory FetchCouponsSummaryModel.fromJson(Map<String, dynamic> json) {
    return FetchCouponsSummaryModel(
      summary: json['summary'] is Map ? FetchCouponsSummaryModelSummary.fromJson(Map<String, dynamic>.from(json['summary'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary?.toJson(),
    };
  }
}

class FetchCouponsSummaryModelSummary {
  int? activeCount;
  int? expiredCount;
  int? totalUsageOrders;
  int? totalSavings;
  int? revenueImpact;
  FetchCouponsSummaryModelSummaryTopPerforming? topPerforming;

  FetchCouponsSummaryModelSummary({
    this.activeCount,
    this.expiredCount,
    this.totalUsageOrders,
    this.totalSavings,
    this.revenueImpact,
    this.topPerforming,
  });

  factory FetchCouponsSummaryModelSummary.fromJson(Map<String, dynamic> json) {
    return FetchCouponsSummaryModelSummary(
      activeCount: _asInt(json['activeCount']),
      expiredCount: _asInt(json['expiredCount']),
      totalUsageOrders: _asInt(json['totalUsageOrders']),
      totalSavings: _asInt(json['totalSavings']),
      revenueImpact: _asInt(json['revenueImpact']),
      topPerforming: json['topPerforming'] is Map ? FetchCouponsSummaryModelSummaryTopPerforming.fromJson(Map<String, dynamic>.from(json['topPerforming'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeCount': activeCount,
      'expiredCount': expiredCount,
      'totalUsageOrders': totalUsageOrders,
      'totalSavings': totalSavings,
      'revenueImpact': revenueImpact,
      'topPerforming': topPerforming?.toJson(),
    };
  }
}

class FetchCouponsSummaryModelSummaryTopPerforming {
  int? id;
  String? code;
  int? usedCount;
  int? generatedRevenue;

  FetchCouponsSummaryModelSummaryTopPerforming({
    this.id,
    this.code,
    this.usedCount,
    this.generatedRevenue,
  });

  factory FetchCouponsSummaryModelSummaryTopPerforming.fromJson(Map<String, dynamic> json) {
    return FetchCouponsSummaryModelSummaryTopPerforming(
      id: _asInt(json['id']),
      code: _asString(json['code']),
      usedCount: _asInt(json['usedCount']),
      generatedRevenue: _asInt(json['generatedRevenue']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'usedCount': usedCount,
      'generatedRevenue': generatedRevenue,
    };
  }
}