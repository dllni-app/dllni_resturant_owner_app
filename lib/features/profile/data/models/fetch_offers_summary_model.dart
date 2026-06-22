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

FetchOffersSummaryModel fetchOffersSummaryModelFromJson(str) => FetchOffersSummaryModel.fromJson(str);

String fetchOffersSummaryModelToJson(FetchOffersSummaryModel data) => json.encode(data.toJson());

FetchOffersSummaryModelSummary fetchOffersSummaryModelSummaryFromJson(str) => FetchOffersSummaryModelSummary.fromJson(str);

String fetchOffersSummaryModelSummaryToJson(FetchOffersSummaryModelSummary data) => json.encode(data.toJson());

FetchOffersSummaryModelSummaryTopPerforming fetchOffersSummaryModelSummaryTopPerformingFromJson(str) => FetchOffersSummaryModelSummaryTopPerforming.fromJson(str);

String fetchOffersSummaryModelSummaryTopPerformingToJson(FetchOffersSummaryModelSummaryTopPerforming data) => json.encode(data.toJson());

class FetchOffersSummaryModel {
  FetchOffersSummaryModelSummary? summary;

  FetchOffersSummaryModel({this.summary});

  factory FetchOffersSummaryModel.fromJson(Map<String, dynamic> json) {
    return FetchOffersSummaryModel(
      summary: json['summary'] is Map ? FetchOffersSummaryModelSummary.fromJson(Map<String, dynamic>.from(json['summary'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() => {'summary': summary?.toJson()};
}

class FetchOffersSummaryModelSummary {
  int? activeCount;
  int? expiredCount;
  int? totalUsageOrders;
  num? totalSavings;
  num? revenueImpact;
  FetchOffersSummaryModelSummaryTopPerforming? topPerforming;

  FetchOffersSummaryModelSummary({
    this.activeCount,
    this.expiredCount,
    this.totalUsageOrders,
    this.totalSavings,
    this.revenueImpact,
    this.topPerforming,
  });

  factory FetchOffersSummaryModelSummary.fromJson(Map<String, dynamic> json) {
    return FetchOffersSummaryModelSummary(
      activeCount: _asInt(json['activeCount']),
      expiredCount: _asInt(json['expiredCount']),
      totalUsageOrders: _asInt(json['totalUsageOrders']),
      totalSavings: _asNum(json['totalSavings']),
      revenueImpact: _asNum(json['revenueImpact']),
      topPerforming: json['topPerforming'] is Map ? FetchOffersSummaryModelSummaryTopPerforming.fromJson(Map<String, dynamic>.from(json['topPerforming'] as Map)) : null,
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

class FetchOffersSummaryModelSummaryTopPerforming {
  int? id;
  String? name;
  int? usageCount;
  num? generatedRevenue;

  FetchOffersSummaryModelSummaryTopPerforming({
    this.id,
    this.name,
    this.usageCount,
    this.generatedRevenue,
  });

  factory FetchOffersSummaryModelSummaryTopPerforming.fromJson(Map<String, dynamic> json) {
    return FetchOffersSummaryModelSummaryTopPerforming(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      usageCount: _asInt(json['usageCount']),
      generatedRevenue: _asNum(json['generatedRevenue']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'usageCount': usageCount,
      'generatedRevenue': generatedRevenue,
    };
  }
}
