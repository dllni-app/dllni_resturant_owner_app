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

HomeOverviewPerformanceModel homeOverviewPerformanceModelFromJson(str) => HomeOverviewPerformanceModel.fromJson(str);

String homeOverviewPerformanceModelToJson(HomeOverviewPerformanceModel data) => json.encode(data.toJson());

HomeOverviewPerformanceModelOffersImpact homeOverviewPerformanceModelOffersImpactFromJson(str) =>
    HomeOverviewPerformanceModelOffersImpact.fromJson(str);

String homeOverviewPerformanceModelOffersImpactToJson(HomeOverviewPerformanceModelOffersImpact data) => json.encode(data.toJson());

HomeOverviewPerformanceModelFulfillment homeOverviewPerformanceModelFulfillmentFromJson(str) => HomeOverviewPerformanceModelFulfillment.fromJson(str);

String homeOverviewPerformanceModelFulfillmentToJson(HomeOverviewPerformanceModelFulfillment data) => json.encode(data.toJson());

HomeOverviewPerformanceModelTopProductsItem homeOverviewPerformanceModelTopProductsItemFromJson(str) =>
    HomeOverviewPerformanceModelTopProductsItem.fromJson(str);

String homeOverviewPerformanceModelTopProductsItemToJson(HomeOverviewPerformanceModelTopProductsItem data) => json.encode(data.toJson());

HomeOverviewPerformanceModelSummary homeOverviewPerformanceModelSummaryFromJson(str) => HomeOverviewPerformanceModelSummary.fromJson(str);

String homeOverviewPerformanceModelSummaryToJson(HomeOverviewPerformanceModelSummary data) => json.encode(data.toJson());

HomeOverviewPerformanceModelRange homeOverviewPerformanceModelRangeFromJson(str) => HomeOverviewPerformanceModelRange.fromJson(str);

String homeOverviewPerformanceModelRangeToJson(HomeOverviewPerformanceModelRange data) => json.encode(data.toJson());

class HomeOverviewPerformanceModel {
  HomeOverviewPerformanceModelRange? range;
  HomeOverviewPerformanceModelSummary? summary;
  List<HomeOverviewPerformanceModelTopProductsItem>? topProducts;
  HomeOverviewPerformanceModelFulfillment? fulfillment;
  HomeOverviewPerformanceModelOffersImpact? offersImpact;
  HomeOverviewModelBestOfferPerformance? bestOfferPerformance;

  HomeOverviewPerformanceModel({this.range, this.summary, this.topProducts, this.fulfillment, this.offersImpact, this.bestOfferPerformance});

  factory HomeOverviewPerformanceModel.fromJson(Map<String, dynamic> json) {
    return HomeOverviewPerformanceModel(
      range: json['range'] is Map ? HomeOverviewPerformanceModelRange.fromJson(Map<String, dynamic>.from(json['range'] as Map)) : null,
      summary: json['summary'] is Map ? HomeOverviewPerformanceModelSummary.fromJson(Map<String, dynamic>.from(json['summary'] as Map)) : null,
      topProducts: json['topProducts'] is List
          ? (json['topProducts'] as List)
                .whereType<Map>()
                .map((item) => HomeOverviewPerformanceModelTopProductsItem.fromJson(Map<String, dynamic>.from(item)))
                .toList()
          : null,
      fulfillment: json['fulfillment'] is Map
          ? HomeOverviewPerformanceModelFulfillment.fromJson(Map<String, dynamic>.from(json['fulfillment'] as Map))
          : null,
      offersImpact: json['offersImpact'] is Map
          ? HomeOverviewPerformanceModelOffersImpact.fromJson(Map<String, dynamic>.from(json['offersImpact'] as Map))
          : null,
      bestOfferPerformance: json['bestOfferPerformance'] is Map
          ? HomeOverviewModelBestOfferPerformance.fromJson(Map<String, dynamic>.from(json['bestOfferPerformance'] as Map))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'range': range?.toJson(),
      'summary': summary?.toJson(),
      'topProducts': topProducts?.map((item) => item.toJson()).toList(),
      'fulfillment': fulfillment?.toJson(),
      'offersImpact': offersImpact?.toJson(),
      'bestOfferPerformance': bestOfferPerformance,
    };
  }
}

class HomeOverviewPerformanceModelOffersImpact {
  int? discountedOrdersCount;
  int? conversionRatePercent;
  int? discountedRevenue;
  int? totalSavings;

  HomeOverviewPerformanceModelOffersImpact({this.discountedOrdersCount, this.conversionRatePercent, this.discountedRevenue, this.totalSavings});

  factory HomeOverviewPerformanceModelOffersImpact.fromJson(Map<String, dynamic> json) {
    return HomeOverviewPerformanceModelOffersImpact(
      discountedOrdersCount: _asInt(json['discountedOrdersCount']),
      conversionRatePercent: _asInt(json['conversionRatePercent']),
      discountedRevenue: _asInt(json['discountedRevenue']),
      totalSavings: _asInt(json['totalSavings']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'discountedOrdersCount': discountedOrdersCount,
      'conversionRatePercent': conversionRatePercent,
      'discountedRevenue': discountedRevenue,
      'totalSavings': totalSavings,
    };
  }
}

class HomeOverviewPerformanceModelFulfillment {
  int? averagePrepTimeMinutes;
  int? averageReadyToPickupMinutes;
  int? delayedOrdersPercent;
  int? onTimePercent;

  HomeOverviewPerformanceModelFulfillment({
    this.averagePrepTimeMinutes,
    this.averageReadyToPickupMinutes,
    this.delayedOrdersPercent,
    this.onTimePercent,
  });

  factory HomeOverviewPerformanceModelFulfillment.fromJson(Map<String, dynamic> json) {
    return HomeOverviewPerformanceModelFulfillment(
      averagePrepTimeMinutes: _asInt(json['averagePrepTimeMinutes']),
      averageReadyToPickupMinutes: _asInt(json['averageReadyToPickupMinutes']),
      delayedOrdersPercent: _asInt(json['delayedOrdersPercent']),
      onTimePercent: _asInt(json['onTimePercent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averagePrepTimeMinutes': averagePrepTimeMinutes,
      'averageReadyToPickupMinutes': averageReadyToPickupMinutes,
      'delayedOrdersPercent': delayedOrdersPercent,
      'onTimePercent': onTimePercent,
    };
  }
}

class HomeOverviewPerformanceModelTopProductsItem {
  int? productId;
  String? name;
  int? quantity;
  int? revenue;

  HomeOverviewPerformanceModelTopProductsItem({this.productId, this.name, this.quantity, this.revenue});

  factory HomeOverviewPerformanceModelTopProductsItem.fromJson(Map<String, dynamic> json) {
    return HomeOverviewPerformanceModelTopProductsItem(
      productId: _asInt(json['productId']),
      name: _asString(json['name']),
      quantity: _asInt(json['quantity']),
      revenue: _asInt(json['revenue']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'name': name, 'quantity': quantity, 'revenue': revenue};
  }
}

class HomeOverviewPerformanceModelSummary {
  int? totalOrders;
  int? newOrdersCount;
  int? confirmedOrdersCount;
  int? completedOrdersCount;
  int? cancelledOrdersCount;
  int? disputesCount;
  double? totalRevenue;
  double? averageOrderValue;
  int? cancellationRatePercent;

  HomeOverviewPerformanceModelSummary({
    this.totalOrders,
    this.newOrdersCount,
    this.confirmedOrdersCount,
    this.completedOrdersCount,
    this.cancelledOrdersCount,
    this.disputesCount,
    this.totalRevenue,
    this.averageOrderValue,
    this.cancellationRatePercent,
  });

  factory HomeOverviewPerformanceModelSummary.fromJson(Map<String, dynamic> json) {
    return HomeOverviewPerformanceModelSummary(
      totalOrders: _asInt(json['totalOrders']),
      newOrdersCount: _asInt(json['newOrdersCount']),
      confirmedOrdersCount: _asInt(json['confirmedOrdersCount']),
      completedOrdersCount: _asInt(json['completedOrdersCount']),
      cancelledOrdersCount: _asInt(json['cancelledOrdersCount']),
      disputesCount: _asInt(json['disputesCount']),
      totalRevenue: _asDouble(json['totalRevenue']),
      averageOrderValue: _asDouble(json['averageOrderValue']),
      cancellationRatePercent: _asInt(json['cancellationRatePercent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalOrders': totalOrders,
      'newOrdersCount': newOrdersCount,
      'confirmedOrdersCount': confirmedOrdersCount,
      'completedOrdersCount': completedOrdersCount,
      'cancelledOrdersCount': cancelledOrdersCount,
      'disputesCount': disputesCount,
      'totalRevenue': totalRevenue,
      'averageOrderValue': averageOrderValue,
      'cancellationRatePercent': cancellationRatePercent,
    };
  }
}

class HomeOverviewPerformanceModelRange {
  String? key;
  String? from;
  String? to;

  HomeOverviewPerformanceModelRange({this.key, this.from, this.to});

  factory HomeOverviewPerformanceModelRange.fromJson(Map<String, dynamic> json) {
    return HomeOverviewPerformanceModelRange(key: _asString(json['key']), from: _asString(json['from']), to: _asString(json['to']));
  }

  Map<String, dynamic> toJson() {
    return {'key': key, 'from': from, 'to': to};
  }
}

class HomeOverviewModelBestOfferPerformance {
  int? promoCodeId;
  String? code;
  String? discountType;
  double? discountValue;
  int? usesCount;
  double? revenue;
  double? totalSavings;

  HomeOverviewModelBestOfferPerformance({
    this.promoCodeId,
    this.code,
    this.discountType,
    this.discountValue,
    this.usesCount,
    this.revenue,
    this.totalSavings,
  });

  factory HomeOverviewModelBestOfferPerformance.fromJson(Map<String, dynamic> json) {
    return HomeOverviewModelBestOfferPerformance(
      promoCodeId: _asInt(json['promoCodeId']),
      code: _asString(json['code']),
      discountType: _asString(json['discountType']),
      discountValue: _asDouble(json['discountValue']),
      usesCount: _asInt(json['usesCount']),
      revenue: _asDouble(json['revenue']),
      totalSavings: _asDouble(json['totalSavings']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'promoCodeId': promoCodeId,
      'code': code,
      'discountType': discountType,
      'discountValue': discountValue,
      'usesCount': usesCount,
      'revenue': revenue,
      'totalSavings': totalSavings,
    };
  }
}
