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
      data: json['data'] is List
          ? (json['data'] as List).map((item) => FetchCouponsModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList()
          : null,
      meta: json['meta'] != null ? FetchCouponsMeta.fromJson(Map<String, dynamic>.from(json['meta'])) : null,
    );
  }

  Map<String, dynamic> toJson() => {'data': data?.map((item) => item.toJson()).toList(), 'meta': meta?.toJson()};
}

class FetchCouponsModelDataItem {
  int? id;
  int? restaurantId;
  String? code;
  String? discountType;
  int? discountValue;
  int? minOrderAmount;
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
      id: json['id'] as int?,
      restaurantId: json['restaurantId'] as int?,
      code: json['code'] as String?,
      discountType: json['discountType'] as String?,
      discountValue: json['discountValue'] as int?,
      minOrderAmount: json['minOrderAmount'] as int?,
      usageLimit: json['usageLimit'] as int?,
      usageCount: json['usageCount'] as int?,
      startsAt: json['startsAt'] as String?,
      endsAt: json['endsAt'] as String?,
      isActive: json['isActive'] as bool?,
      performance: json['performance'] != null ? Performance.fromJson(Map<String, dynamic>.from(json['performance'])) : null,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
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
  int? totalSavings;
  int? revenueImpact;

  Performance({this.ordersCount, this.totalSavings, this.revenueImpact});

  factory Performance.fromJson(Map<String, dynamic> json) =>
      Performance(ordersCount: json['ordersCount'] as int?, totalSavings: json['totalSavings'] as int?, revenueImpact: json['revenueImpact'] as int?);

  Map<String, dynamic> toJson() => {'ordersCount': ordersCount, 'totalSavings': totalSavings, 'revenueImpact': revenueImpact};
}

class FetchCouponsMeta {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  FetchCouponsMeta({this.currentPage, this.lastPage, this.perPage, this.total});

  factory FetchCouponsMeta.fromJson(Map<String, dynamic> json) => FetchCouponsMeta(
    currentPage: json['currentPage'] as int?,
    lastPage: json['lastPage'] as int?,
    perPage: json['perPage'] as int?,
    total: json['total'] as int?,
  );

  Map<String, dynamic> toJson() => {'currentPage': currentPage, 'lastPage': lastPage, 'perPage': perPage, 'total': total};
}
