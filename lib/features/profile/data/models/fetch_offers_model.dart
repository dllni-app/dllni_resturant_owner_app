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

FetchOffersModel fetchOffersModelFromJson(str) => FetchOffersModel.fromJson(str);

String fetchOffersModelToJson(FetchOffersModel data) => json.encode(data.toJson());

FetchOffersModelDataItem fetchOffersModelDataItemFromJson(str) => FetchOffersModelDataItem.fromJson(str);

String fetchOffersModelDataItemToJson(FetchOffersModelDataItem data) => json.encode(data.toJson());

class FetchOffersModel {
  List<FetchOffersModelDataItem>? data;
  FetchOffersModelMeta? meta;

  FetchOffersModel({this.data, this.meta});

  factory FetchOffersModel.fromJson(Map<String, dynamic> json) {
    return FetchOffersModel(
      data: json['data'] is List
          ? (json['data'] as List).whereType<Map>().map((item) => FetchOffersModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList()
          : null,
      meta: json['meta'] is Map ? FetchOffersModelMeta.fromJson(Map<String, dynamic>.from(json['meta'])) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data?.map((item) => item.toJson()).toList(), 'meta': meta?.toJson()};
  }
}

class FetchOffersModelProduct {
  int? id;
  String? name;

  FetchOffersModelProduct({this.id, this.name});

  factory FetchOffersModelProduct.fromJson(Map<String, dynamic> json) {
    return FetchOffersModelProduct(id: _asInt(json['id']), name: _asString(json['name']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class FetchOffersModelPerformance {
  int? ordersCount;
  double? revenueImpact;

  FetchOffersModelPerformance({this.ordersCount, this.revenueImpact});

  factory FetchOffersModelPerformance.fromJson(Map<String, dynamic> json) {
    return FetchOffersModelPerformance(ordersCount: _asInt(json['ordersCount']), revenueImpact: _asDouble(json['revenueImpact']));
  }

  Map<String, dynamic> toJson() {
    return {'ordersCount': ordersCount, 'revenueImpact': revenueImpact};
  }
}

class FetchOffersModelMeta {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  FetchOffersModelMeta({this.currentPage, this.lastPage, this.perPage, this.total});

  factory FetchOffersModelMeta.fromJson(Map<String, dynamic> json) {
    return FetchOffersModelMeta(
      currentPage: _asInt(json['currentPage']),
      lastPage: _asInt(json['lastPage']),
      perPage: _asInt(json['perPage']),
      total: _asInt(json['total']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'currentPage': currentPage, 'lastPage': lastPage, 'perPage': perPage, 'total': total};
  }
}

class FetchOffersModelDataItem {
  int? id;
  int? restaurantId;

  String? name;
  String? discountType;
  double? discountValue;

  String? startsAt;
  String? endsAt;

  bool? isActive;

  List<FetchOffersModelProduct>? products;
  FetchOffersModelPerformance? performance;

  String? createdAt;
  String? updatedAt;

  FetchOffersModelDataItem({
    this.id,
    this.restaurantId,
    this.name,
    this.discountType,
    this.discountValue,
    this.startsAt,
    this.endsAt,
    this.isActive,
    this.products,
    this.performance,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchOffersModelDataItem.fromJson(Map<String, dynamic> json) {
    return FetchOffersModelDataItem(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurantId']),
      name: _asString(json['name']),
      discountType: _asString(json['discountType']),
      discountValue: _asDouble(json['discountValue']),
      startsAt: _asString(json['startsAt']),
      endsAt: _asString(json['endsAt']),
      isActive: _asBool(json['isActive']),
      products: json['products'] is List
          ? (json['products'] as List).whereType<Map>().map((e) => FetchOffersModelProduct.fromJson(Map<String, dynamic>.from(e))).toList()
          : null,
      performance: json['performance'] is Map ? FetchOffersModelPerformance.fromJson(Map<String, dynamic>.from(json['performance'])) : null,
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'discountType': discountType,
      'discountValue': discountValue,
      'startsAt': startsAt,
      'endsAt': endsAt,
      'isActive': isActive,
      'products': products?.map((e) => e.toJson()).toList(),
      'performance': performance?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// Calculates the offer status based on startsAt and endsAt dates
  /// Returns: 'scheduled', 'active', or 'expired'
  String calculateStatus() {
    final now = DateTime.now();
    DateTime? startDate;
    DateTime? endDate;

    try {
      if (startsAt != null) {
        startDate = DateTime.parse(startsAt!);
      }
      if (endsAt != null) {
        endDate = DateTime.parse(endsAt!);
      }
    } catch (e) {
      // If date parsing fails, default to active
      return 'active';
    }

    // If both dates are null, default to active
    if (startDate == null && endDate == null) {
      return 'active';
    }

    // If start date is in the future, it's scheduled
    if (startDate != null && startDate.isAfter(now)) {
      return 'scheduled';
    }

    // If end date is in the past, it's expired
    if (endDate != null && endDate.isBefore(now)) {
      return 'expired';
    }

    // If start date is in the past (or null) and end date is in the future (or null), it's active
    if ((startDate == null || startDate.isBefore(now) || startDate.isAtSameMomentAs(now)) &&
        (endDate == null || endDate.isAfter(now) || endDate.isAtSameMomentAs(now))) {
      return 'active';
    }

    // Default to active
    return 'active';
  }
}
