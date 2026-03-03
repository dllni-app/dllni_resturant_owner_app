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

GetOrdersModel getOrdersModelFromJson(str) => GetOrdersModel.fromJson(str);

String getOrdersModelToJson(GetOrdersModel data) => json.encode(data.toJson());

GetOrdersModelMeta getOrdersModelMetaFromJson(str) => GetOrdersModelMeta.fromJson(str);

String getOrdersModelMetaToJson(GetOrdersModelMeta data) => json.encode(data.toJson());

GetOrdersModelLinks getOrdersModelLinksFromJson(str) => GetOrdersModelLinks.fromJson(str);

String getOrdersModelLinksToJson(GetOrdersModelLinks data) => json.encode(data.toJson());

GetOrdersModelDataItem getOrdersModelDataItemFromJson(str) => GetOrdersModelDataItem.fromJson(str);

String getOrdersModelDataItemToJson(GetOrdersModelDataItem data) => json.encode(data.toJson());

class GetOrdersModel {
  List<GetOrdersModelDataItem>? data;
  GetOrdersModelLinks? links;
  GetOrdersModelMeta? meta;

  GetOrdersModel({this.data, this.links, this.meta});

  factory GetOrdersModel.fromJson(Map<String, dynamic> json) {
    return GetOrdersModel(
      data: json['data'] is List
          ? (json['data'] as List).whereType<Map>().map((item) => GetOrdersModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList()
          : null,
      links: json['links'] is Map ? GetOrdersModelLinks.fromJson(Map<String, dynamic>.from(json['links'] as Map)) : null,
      meta: json['meta'] is Map ? GetOrdersModelMeta.fromJson(Map<String, dynamic>.from(json['meta'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data?.map((item) => item.toJson()).toList(), 'links': links?.toJson(), 'meta': meta?.toJson()};
  }
}

class GetOrdersModelMeta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  GetOrdersModelMeta({this.currentPage, this.from, this.lastPage, this.path, this.perPage, this.to, this.total});

  factory GetOrdersModelMeta.fromJson(Map<String, dynamic> json) {
    return GetOrdersModelMeta(
      currentPage: _asInt(json['current_page']),
      from: _asInt(json['from']),
      lastPage: _asInt(json['last_page']),
      path: _asString(json['path']),
      perPage: _asInt(json['per_page']),
      to: _asInt(json['to']),
      total: _asInt(json['total']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'current_page': currentPage, 'from': from, 'last_page': lastPage, 'path': path, 'per_page': perPage, 'to': to, 'total': total};
  }
}

class GetOrdersModelLinks {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  GetOrdersModelLinks({this.first, this.last, this.prev, this.next});

  factory GetOrdersModelLinks.fromJson(Map<String, dynamic> json) {
    return GetOrdersModelLinks(
      first: _asString(json['first']),
      last: _asString(json['last']),
      prev: _asDynamic(json['prev']),
      next: _asString(json['next']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'first': first, 'last': last, 'prev': prev, 'next': next};
  }
}

class GetOrdersModelDataItem {
  int? id;
  int? userId;
  int? restaurantId;
  int? promoCodeId;
  int? assignedStaffId;
  int? cancellationPolicyId;

  String? orderNumber;
  String? status;
  String? statusLabelAr;
  String? orderType;
  String? pickupMode;

  String? pickupScheduledFor;
  String? readyForPickupAt;
  String? pickedUpAt;
  String? customerPickupConfirmedAt;

  double? subtotal;
  double? discountAmount;
  double? taxAmount;
  double? serviceFee;
  double? totalAmount;
  double? cancellationFeeAmount;

  String? specialInstructions;
  String? acceptedAt;
  int? estimatedPreparationMinutes;
  String? kitchenNotes;
  String? preparingAt;
  String? completedAt;
  String? cancelledAt;
  String? cancellationReason;
  String? cancellationReasonCode;

  OrderUser? user;
  OrderRestaurant? restaurant;

  List<OrderItem>? orderItems;
  List<OrderStatusLog>? orderStatusLogs;

  String? createdAt;
  String? updatedAt;

  GetOrdersModelDataItem({
    this.id,
    this.userId,
    this.restaurantId,
    this.promoCodeId,
    this.assignedStaffId,
    this.cancellationPolicyId,
    this.orderNumber,
    this.status,
    this.statusLabelAr,
    this.orderType,
    this.pickupMode,
    this.pickupScheduledFor,
    this.readyForPickupAt,
    this.pickedUpAt,
    this.customerPickupConfirmedAt,
    this.subtotal,
    this.discountAmount,
    this.taxAmount,
    this.serviceFee,
    this.totalAmount,
    this.cancellationFeeAmount,
    this.specialInstructions,
    this.acceptedAt,
    this.estimatedPreparationMinutes,
    this.kitchenNotes,
    this.preparingAt,
    this.completedAt,
    this.cancelledAt,
    this.cancellationReason,
    this.cancellationReasonCode,
    this.user,
    this.restaurant,
    this.orderItems,
    this.orderStatusLogs,
    this.createdAt,
    this.updatedAt,
  });

  factory GetOrdersModelDataItem.fromJson(Map<String, dynamic> json) {
    return GetOrdersModelDataItem(
      id: _asInt(json['id']),
      userId: _asInt(json['userId']),
      restaurantId: _asInt(json['restaurantId']),
      promoCodeId: _asInt(json['promoCodeId']),
      assignedStaffId: _asInt(json['assignedStaffId']),
      cancellationPolicyId: _asInt(json['cancellationPolicyId']),
      orderNumber: _asString(json['orderNumber']),
      status: _asString(json['status']),
      statusLabelAr: _asString(json['statusLabelAr']),
      orderType: _asString(json['orderType']),
      pickupMode: _asString(json['pickupMode']),
      pickupScheduledFor: _asString(json['pickupScheduledFor']),
      readyForPickupAt: _asString(json['readyForPickupAt']),
      pickedUpAt: _asString(json['pickedUpAt']),
      customerPickupConfirmedAt: _asString(json['customerPickupConfirmedAt']),
      subtotal: _asDouble(json['subtotal']),
      discountAmount: _asDouble(json['discountAmount']),
      taxAmount: _asDouble(json['taxAmount']),
      serviceFee: _asDouble(json['serviceFee']),
      totalAmount: _asDouble(json['totalAmount']),
      cancellationFeeAmount: _asDouble(json['cancellationFeeAmount']),
      specialInstructions: _asString(json['specialInstructions']),
      acceptedAt: _asString(json['acceptedAt']),
      estimatedPreparationMinutes: _asInt(json['estimatedPreparationMinutes']),
      kitchenNotes: _asString(json['kitchenNotes']),
      preparingAt: _asString(json['preparingAt']),
      completedAt: _asString(json['completedAt']),
      cancelledAt: _asString(json['cancelledAt']),
      cancellationReason: _asString(json['cancellationReason']),
      cancellationReasonCode: _asString(json['cancellationReasonCode']),
      user: json['user'] is Map ? OrderUser.fromJson(Map<String, dynamic>.from(json['user'])) : null,
      restaurant: json['restaurant'] is Map ? OrderRestaurant.fromJson(Map<String, dynamic>.from(json['restaurant'])) : null,
      orderItems: json['orderItems'] is List
          ? (json['orderItems'] as List).whereType<Map>().map((e) => OrderItem.fromJson(Map<String, dynamic>.from(e))).toList()
          : null,
      orderStatusLogs: json['orderStatusLogs'] is List
          ? (json['orderStatusLogs'] as List).whereType<Map>().map((e) => OrderStatusLog.fromJson(Map<String, dynamic>.from(e))).toList()
          : null,
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "restaurantId": restaurantId,
    "orderNumber": orderNumber,
    "status": status,
    "orderType": orderType,
    "totalAmount": totalAmount,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class OrderUser {
  int? id;
  String? name;
  String? email;

  OrderUser({this.id, this.name, this.email});

  factory OrderUser.fromJson(Map<String, dynamic> json) {
    return OrderUser(id: _asInt(json['id']), name: _asString(json['name']), email: _asString(json['email']));
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "email": email};
}

class OrderRestaurant {
  int? id;
  String? name;
  String? slug;

  OrderRestaurant({this.id, this.name, this.slug});

  factory OrderRestaurant.fromJson(Map<String, dynamic> json) {
    return OrderRestaurant(id: _asInt(json['id']), name: _asString(json['name']), slug: _asString(json['slug']));
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "slug": slug};
}

class OrderItem {
  OrderItem();

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem();
  }

  Map<String, dynamic> toJson() => {};
}

class OrderStatusLog {
  OrderStatusLog();

  factory OrderStatusLog.fromJson(Map<String, dynamic> json) {
    return OrderStatusLog();
  }

  Map<String, dynamic> toJson() => {};
}
