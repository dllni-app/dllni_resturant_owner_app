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

GetDashboardOverviewUsecaseModel getDashboardOverviewUsecaseModelFromJson(str) => GetDashboardOverviewUsecaseModel.fromJson(str);

String getDashboardOverviewUsecaseModelToJson(GetDashboardOverviewUsecaseModel data) => json.encode(data.toJson());


GetDashboardOverviewUsecaseModelKpis getDashboardOverviewUsecaseModelKpisFromJson(str) => GetDashboardOverviewUsecaseModelKpis.fromJson(str);

String getDashboardOverviewUsecaseModelKpisToJson(GetDashboardOverviewUsecaseModelKpis data) => json.encode(data.toJson());


GetDashboardOverviewUsecaseModelKpisLowStockProductsItem getDashboardOverviewUsecaseModelKpisLowStockProductsItemFromJson(str) => GetDashboardOverviewUsecaseModelKpisLowStockProductsItem.fromJson(str);

String getDashboardOverviewUsecaseModelKpisLowStockProductsItemToJson(GetDashboardOverviewUsecaseModelKpisLowStockProductsItem data) => json.encode(data.toJson());


GetDashboardOverviewUsecaseModelKpisOrderActivityByHourItem getDashboardOverviewUsecaseModelKpisOrderActivityByHourItemFromJson(str) => GetDashboardOverviewUsecaseModelKpisOrderActivityByHourItem.fromJson(str);

String getDashboardOverviewUsecaseModelKpisOrderActivityByHourItemToJson(GetDashboardOverviewUsecaseModelKpisOrderActivityByHourItem data) => json.encode(data.toJson());


GetDashboardOverviewUsecaseModelKpisOrdersByStatus getDashboardOverviewUsecaseModelKpisOrdersByStatusFromJson(str) => GetDashboardOverviewUsecaseModelKpisOrdersByStatus.fromJson(str);

String getDashboardOverviewUsecaseModelKpisOrdersByStatusToJson(GetDashboardOverviewUsecaseModelKpisOrdersByStatus data) => json.encode(data.toJson());


class GetDashboardOverviewUsecaseModel {
  GetDashboardOverviewUsecaseModelKpis? kpis;

  GetDashboardOverviewUsecaseModel({
    this.kpis,
  });

  factory GetDashboardOverviewUsecaseModel.fromJson(Map<String, dynamic> json) {
    return GetDashboardOverviewUsecaseModel(
      kpis: json['kpis'] is Map ? GetDashboardOverviewUsecaseModelKpis.fromJson(Map<String, dynamic>.from(json['kpis'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kpis': kpis?.toJson(),
    };
  }
}

class GetDashboardOverviewUsecaseModelKpis {
  int? todayTotalSales;
  int? yesterdayTotalSales;
  int? salesChangePercent;
  int? todayOrders;
  GetDashboardOverviewUsecaseModelKpisOrdersByStatus? ordersByStatus;
  int? activeRestaurants;
  int? openDisputes;
  int? ordersPendingPickup;
  int? ordersReadyForPickup;
  int? lowStockAlertsCount;
  List<GetDashboardOverviewUsecaseModelKpisOrderActivityByHourItem>? orderActivityByHour;
  List<GetDashboardOverviewUsecaseModelKpisLowStockProductsItem>? lowStockProducts;

  GetDashboardOverviewUsecaseModelKpis({
    this.todayTotalSales,
    this.yesterdayTotalSales,
    this.salesChangePercent,
    this.todayOrders,
    this.ordersByStatus,
    this.activeRestaurants,
    this.openDisputes,
    this.ordersPendingPickup,
    this.ordersReadyForPickup,
    this.lowStockAlertsCount,
    this.orderActivityByHour,
    this.lowStockProducts,
  });

  factory GetDashboardOverviewUsecaseModelKpis.fromJson(Map<String, dynamic> json) {
    return GetDashboardOverviewUsecaseModelKpis(
      todayTotalSales: _asInt(json['todayTotalSales']),
      yesterdayTotalSales: _asInt(json['yesterdayTotalSales']),
      salesChangePercent: _asInt(json['salesChangePercent']),
      todayOrders: _asInt(json['todayOrders']),
      ordersByStatus: json['ordersByStatus'] is Map ? GetDashboardOverviewUsecaseModelKpisOrdersByStatus.fromJson(Map<String, dynamic>.from(json['ordersByStatus'] as Map)) : null,
      activeRestaurants: _asInt(json['activeRestaurants']),
      openDisputes: _asInt(json['openDisputes']),
      ordersPendingPickup: _asInt(json['ordersPendingPickup']),
      ordersReadyForPickup: _asInt(json['ordersReadyForPickup']),
      lowStockAlertsCount: _asInt(json['lowStockAlertsCount']),
      orderActivityByHour: json['orderActivityByHour'] is List ? (json['orderActivityByHour'] as List).whereType<Map>().map((item) => GetDashboardOverviewUsecaseModelKpisOrderActivityByHourItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      lowStockProducts: json['lowStockProducts'] is List ? (json['lowStockProducts'] as List).whereType<Map>().map((item) => GetDashboardOverviewUsecaseModelKpisLowStockProductsItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todayTotalSales': todayTotalSales,
      'yesterdayTotalSales': yesterdayTotalSales,
      'salesChangePercent': salesChangePercent,
      'todayOrders': todayOrders,
      'ordersByStatus': ordersByStatus?.toJson(),
      'activeRestaurants': activeRestaurants,
      'openDisputes': openDisputes,
      'ordersPendingPickup': ordersPendingPickup,
      'ordersReadyForPickup': ordersReadyForPickup,
      'lowStockAlertsCount': lowStockAlertsCount,
      'orderActivityByHour': orderActivityByHour?.map((item) => item.toJson()).toList(),
      'lowStockProducts': lowStockProducts?.map((item) => item.toJson()).toList(),
    };
  }
}

class GetDashboardOverviewUsecaseModelKpisLowStockProductsItem {
  int? id;
  String? name;
  int? stockQuantity;
  int? lowStockThreshold;

  GetDashboardOverviewUsecaseModelKpisLowStockProductsItem({
    this.id,
    this.name,
    this.stockQuantity,
    this.lowStockThreshold,
  });

  factory GetDashboardOverviewUsecaseModelKpisLowStockProductsItem.fromJson(Map<String, dynamic> json) {
    return GetDashboardOverviewUsecaseModelKpisLowStockProductsItem(
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

class GetDashboardOverviewUsecaseModelKpisOrderActivityByHourItem {
  int? hour;
  int? count;

  GetDashboardOverviewUsecaseModelKpisOrderActivityByHourItem({
    this.hour,
    this.count,
  });

  factory GetDashboardOverviewUsecaseModelKpisOrderActivityByHourItem.fromJson(Map<String, dynamic> json) {
    return GetDashboardOverviewUsecaseModelKpisOrderActivityByHourItem(
      hour: _asInt(json['hour']),
      count: _asInt(json['count']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'count': count,
    };
  }
}

class GetDashboardOverviewUsecaseModelKpisOrdersByStatus {
  int? pending;
  int? accepted;
  int? preparing;
  int? completed;
  int? cancelled;
  int? readyForPickup;
  int? pickedUp;

  GetDashboardOverviewUsecaseModelKpisOrdersByStatus({
    this.pending,
    this.accepted,
    this.preparing,
    this.completed,
    this.cancelled,
    this.readyForPickup,
    this.pickedUp,
  });

  factory GetDashboardOverviewUsecaseModelKpisOrdersByStatus.fromJson(Map<String, dynamic> json) {
    return GetDashboardOverviewUsecaseModelKpisOrdersByStatus(
      pending: _asInt(json['pending']),
      accepted: _asInt(json['accepted']),
      preparing: _asInt(json['preparing']),
      completed: _asInt(json['completed']),
      cancelled: _asInt(json['cancelled']),
      readyForPickup: _asInt(json['readyForPickup']),
      pickedUp: _asInt(json['pickedUp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending': pending,
      'accepted': accepted,
      'preparing': preparing,
      'completed': completed,
      'cancelled': cancelled,
      'readyForPickup': readyForPickup,
      'pickedUp': pickedUp,
    };
  }
}