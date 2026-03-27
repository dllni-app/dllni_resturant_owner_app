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

HomeOverviewModel homeOverviewModelFromJson(str) => HomeOverviewModel.fromJson(str);

String homeOverviewModelToJson(HomeOverviewModel data) => json.encode(data.toJson());


HomeOverviewModelKpis homeOverviewModelKpisFromJson(str) => HomeOverviewModelKpis.fromJson(str);

String homeOverviewModelKpisToJson(HomeOverviewModelKpis data) => json.encode(data.toJson());


HomeOverviewModelKpisOrderActivityByHourItem homeOverviewModelKpisOrderActivityByHourItemFromJson(str) => HomeOverviewModelKpisOrderActivityByHourItem.fromJson(str);

String homeOverviewModelKpisOrderActivityByHourItemToJson(HomeOverviewModelKpisOrderActivityByHourItem data) => json.encode(data.toJson());


HomeOverviewModelKpisOrdersByStatus homeOverviewModelKpisOrdersByStatusFromJson(str) => HomeOverviewModelKpisOrdersByStatus.fromJson(str);

String homeOverviewModelKpisOrdersByStatusToJson(HomeOverviewModelKpisOrdersByStatus data) => json.encode(data.toJson());


class HomeOverviewModel {
  HomeOverviewModelKpis? kpis;

  HomeOverviewModel({
    this.kpis,
  });

  factory HomeOverviewModel.fromJson(Map<String, dynamic> json) {
    return HomeOverviewModel(
      kpis: json['kpis'] is Map ? HomeOverviewModelKpis.fromJson(Map<String, dynamic>.from(json['kpis'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kpis': kpis?.toJson(),
    };
  }
}

class HomeOverviewModelKpis {
  double? todayTotalSales;
  int? yesterdayTotalSales;
  int? salesChangePercent;
  int? todayOrders;
  HomeOverviewModelKpisOrdersByStatus? ordersByStatus;
  int? activeRestaurants;
  int? openDisputes;
  int? ordersPendingPickup;
  int? ordersReadyForPickup;
  int? lowStockAlertsCount;
  List<HomeOverviewModelKpisOrderActivityByHourItem>? orderActivityByHour;
  List<dynamic>? lowStockProducts;

  HomeOverviewModelKpis({
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

  factory HomeOverviewModelKpis.fromJson(Map<String, dynamic> json) {
    return HomeOverviewModelKpis(
      todayTotalSales: _asDouble(json['todayTotalSales']),
      yesterdayTotalSales: _asInt(json['yesterdayTotalSales']),
      salesChangePercent: _asInt(json['salesChangePercent']),
      todayOrders: _asInt(json['todayOrders']),
      ordersByStatus: json['ordersByStatus'] is Map ? HomeOverviewModelKpisOrdersByStatus.fromJson(Map<String, dynamic>.from(json['ordersByStatus'] as Map)) : null,
      activeRestaurants: _asInt(json['activeRestaurants']),
      openDisputes: _asInt(json['openDisputes']),
      ordersPendingPickup: _asInt(json['ordersPendingPickup']),
      ordersReadyForPickup: _asInt(json['ordersReadyForPickup']),
      lowStockAlertsCount: _asInt(json['lowStockAlertsCount']),
      orderActivityByHour: json['orderActivityByHour'] is List ? (json['orderActivityByHour'] as List).whereType<Map>().map((item) => HomeOverviewModelKpisOrderActivityByHourItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      lowStockProducts: _asDynamicList(json['lowStockProducts']),
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
      'lowStockProducts': lowStockProducts,
    };
  }
}

class HomeOverviewModelKpisOrderActivityByHourItem {
  int? hour;
  int? count;

  HomeOverviewModelKpisOrderActivityByHourItem({
    this.hour,
    this.count,
  });

  factory HomeOverviewModelKpisOrderActivityByHourItem.fromJson(Map<String, dynamic> json) {
    return HomeOverviewModelKpisOrderActivityByHourItem(
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

class HomeOverviewModelKpisOrdersByStatus {
  int? pending;
  int? accepted;
  int? preparing;
  int? readyForPickup;
  int? pickedUp;
  int? completed;
  int? cancelled;

  HomeOverviewModelKpisOrdersByStatus({
    this.pending,
    this.accepted,
    this.preparing,
    this.readyForPickup,
    this.pickedUp,
    this.completed,
    this.cancelled,
  });

  factory HomeOverviewModelKpisOrdersByStatus.fromJson(Map<String, dynamic> json) {
    return HomeOverviewModelKpisOrdersByStatus(
      pending: _asInt(json['pending']),
      accepted: _asInt(json['accepted']),
      preparing: _asInt(json['preparing']),
      readyForPickup: _asInt(json['readyForPickup']),
      pickedUp: _asInt(json['pickedUp']),
      completed: _asInt(json['completed']),
      cancelled: _asInt(json['cancelled']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending': pending,
      'accepted': accepted,
      'preparing': preparing,
      'readyForPickup': readyForPickup,
      'pickedUp': pickedUp,
      'completed': completed,
      'cancelled': cancelled,
    };
  }
}