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
  if (value is num) return value == 1 ? true : value == 0 ? false : null;
  if (value is String) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'true' || normalized == '1') return true;
    if (normalized == 'false' || normalized == '0') return false;
  }
  return null;
}

FetchCouponsModel fetchCouponsModelFromJson(str) => FetchCouponsModel.fromJson(str);

String fetchCouponsModelToJson(FetchCouponsModel data) => json.encode(data.toJson());

FetchCouponsModelDataItem fetchCouponsModelDataItemFromJson(str) => FetchCouponsModelDataItem.fromJson(str);

String fetchCouponsModelDataItemToJson(FetchCouponsModelDataItem data) => json.encode(data.toJson());

class FetchCouponsModel {
  List<FetchCouponsModelDataItem>? data;
  FetchCouponsMeta? meta;

  FetchCouponsModel({this.data, this.meta});

  factory FetchCouponsModel.fromJson(Map<String, dynamic> json) {
    return FetchCouponsModel(
      data: json['data'] is List ? (json['data'] as List).whereType<Map>().map((item) => FetchCouponsModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      meta: json['meta'] is Map ? FetchCouponsMeta.fromJson(Map<String, dynamic>.from(json['meta'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() => {'data': data?.map((item) => item.toJson()).toList(), 'meta': meta?.toJson()};
}

class FetchCouponsModelDataItem {
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
  Performance? performance;
  String? createdAt;
  String? updatedAt;

  FetchCouponsModelDataItem({
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
    this.performance,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchCouponsModelDataItem.fromJson(Map<String, dynamic> json) {
    return FetchCouponsModelDataItem(
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
      performance: json['performance'] is Map ? Performance.fromJson(Map<String, dynamic>.from(json['performance'] as Map)) : null,
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
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
        'performance': performance?.toJson(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class Performance {
  int? ordersCount;
  double? totalSavings;
  double? revenueImpact;

  Performance({this.ordersCount, this.totalSavings, this.revenueImpact});

  factory Performance.fromJson(Map<String, dynamic> json) => Performance(
        ordersCount: _asInt(json['ordersCount']),
        totalSavings: _asDouble(json['totalSavings']),
        revenueImpact: _asDouble(json['revenueImpact']),
      );

  Map<String, dynamic> toJson() => {'ordersCount': ordersCount, 'totalSavings': totalSavings, 'revenueImpact': revenueImpact};
}

class FetchCouponsMeta {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  FetchCouponsMeta({this.currentPage, this.lastPage, this.perPage, this.total});

  factory FetchCouponsMeta.fromJson(Map<String, dynamic> json) => FetchCouponsMeta(
        currentPage: _asInt(json['currentPage']),
        lastPage: _asInt(json['lastPage']),
        perPage: _asInt(json['perPage']),
        total: _asInt(json['total']),
      );

  Map<String, dynamic> toJson() => {'currentPage': currentPage, 'lastPage': lastPage, 'perPage': perPage, 'total': total};
}
