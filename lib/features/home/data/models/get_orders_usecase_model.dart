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

GetOrdersUsecaseModel getOrdersUsecaseModelFromJson(str) => GetOrdersUsecaseModel.fromJson(str);

String getOrdersUsecaseModelToJson(GetOrdersUsecaseModel data) => json.encode(data.toJson());


GetOrdersUsecaseModelMeta getOrdersUsecaseModelMetaFromJson(str) => GetOrdersUsecaseModelMeta.fromJson(str);

String getOrdersUsecaseModelMetaToJson(GetOrdersUsecaseModelMeta data) => json.encode(data.toJson());


GetOrdersUsecaseModelDataItem getOrdersUsecaseModelDataItemFromJson(str) => GetOrdersUsecaseModelDataItem.fromJson(str);

String getOrdersUsecaseModelDataItemToJson(GetOrdersUsecaseModelDataItem data) => json.encode(data.toJson());


GetOrdersUsecaseModelDataItemOrderItemsItem getOrdersUsecaseModelDataItemOrderItemsItemFromJson(str) => GetOrdersUsecaseModelDataItemOrderItemsItem.fromJson(str);

String getOrdersUsecaseModelDataItemOrderItemsItemToJson(GetOrdersUsecaseModelDataItemOrderItemsItem data) => json.encode(data.toJson());


GetOrdersUsecaseModelDataItemOrderItemsItemProduct getOrdersUsecaseModelDataItemOrderItemsItemProductFromJson(str) => GetOrdersUsecaseModelDataItemOrderItemsItemProduct.fromJson(str);

String getOrdersUsecaseModelDataItemOrderItemsItemProductToJson(GetOrdersUsecaseModelDataItemOrderItemsItemProduct data) => json.encode(data.toJson());


GetOrdersUsecaseModelDataItemRestaurant getOrdersUsecaseModelDataItemRestaurantFromJson(str) => GetOrdersUsecaseModelDataItemRestaurant.fromJson(str);

String getOrdersUsecaseModelDataItemRestaurantToJson(GetOrdersUsecaseModelDataItemRestaurant data) => json.encode(data.toJson());


GetOrdersUsecaseModelDataItemUser getOrdersUsecaseModelDataItemUserFromJson(str) => GetOrdersUsecaseModelDataItemUser.fromJson(str);

String getOrdersUsecaseModelDataItemUserToJson(GetOrdersUsecaseModelDataItemUser data) => json.encode(data.toJson());


class GetOrdersUsecaseModel {
  List<GetOrdersUsecaseModelDataItem>? data;
  GetOrdersUsecaseModelMeta? meta;

  GetOrdersUsecaseModel({
    this.data,
    this.meta,
  });

  factory GetOrdersUsecaseModel.fromJson(Map<String, dynamic> json) {
    return GetOrdersUsecaseModel(
      data: json['data'] is List ? (json['data'] as List).whereType<Map>().map((item) => GetOrdersUsecaseModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      meta: json['meta'] is Map ? GetOrdersUsecaseModelMeta.fromJson(Map<String, dynamic>.from(json['meta'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}

class GetOrdersUsecaseModelMeta {
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;

  GetOrdersUsecaseModelMeta({
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
  });

  factory GetOrdersUsecaseModelMeta.fromJson(Map<String, dynamic> json) {
    return GetOrdersUsecaseModelMeta(
      currentPage: _asInt(json['current_page']),
      perPage: _asInt(json['per_page']),
      total: _asInt(json['total']),
      lastPage: _asInt(json['last_page']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'per_page': perPage,
      'total': total,
      'last_page': lastPage,
    };
  }
}

class GetOrdersUsecaseModelDataItem {
  int? id;
  String? status;
  int? totalAmount;
  String? createdAt;
  GetOrdersUsecaseModelDataItemUser? user;
  GetOrdersUsecaseModelDataItemRestaurant? restaurant;
  List<GetOrdersUsecaseModelDataItemOrderItemsItem>? orderItems;

  GetOrdersUsecaseModelDataItem({
    this.id,
    this.status,
    this.totalAmount,
    this.createdAt,
    this.user,
    this.restaurant,
    this.orderItems,
  });

  factory GetOrdersUsecaseModelDataItem.fromJson(Map<String, dynamic> json) {
    return GetOrdersUsecaseModelDataItem(
      id: _asInt(json['id']),
      status: _asString(json['status']),
      totalAmount: _asInt(json['totalAmount']),
      createdAt: _asString(json['createdAt']),
      user: json['user'] is Map ? GetOrdersUsecaseModelDataItemUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)) : null,
      restaurant: json['restaurant'] is Map ? GetOrdersUsecaseModelDataItemRestaurant.fromJson(Map<String, dynamic>.from(json['restaurant'] as Map)) : null,
      orderItems: json['orderItems'] is List ? (json['orderItems'] as List).whereType<Map>().map((item) => GetOrdersUsecaseModelDataItemOrderItemsItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'totalAmount': totalAmount,
      'createdAt': createdAt,
      'user': user?.toJson(),
      'restaurant': restaurant?.toJson(),
      'orderItems': orderItems?.map((item) => item.toJson()).toList(),
    };
  }
}

class GetOrdersUsecaseModelDataItemOrderItemsItem {
  int? id;
  int? quantity;
  GetOrdersUsecaseModelDataItemOrderItemsItemProduct? product;

  GetOrdersUsecaseModelDataItemOrderItemsItem({
    this.id,
    this.quantity,
    this.product,
  });

  factory GetOrdersUsecaseModelDataItemOrderItemsItem.fromJson(Map<String, dynamic> json) {
    return GetOrdersUsecaseModelDataItemOrderItemsItem(
      id: _asInt(json['id']),
      quantity: _asInt(json['quantity']),
      product: json['product'] is Map ? GetOrdersUsecaseModelDataItemOrderItemsItemProduct.fromJson(Map<String, dynamic>.from(json['product'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': product?.toJson(),
    };
  }
}

class GetOrdersUsecaseModelDataItemOrderItemsItemProduct {
  int? id;
  String? name;

  GetOrdersUsecaseModelDataItemOrderItemsItemProduct({
    this.id,
    this.name,
  });

  factory GetOrdersUsecaseModelDataItemOrderItemsItemProduct.fromJson(Map<String, dynamic> json) {
    return GetOrdersUsecaseModelDataItemOrderItemsItemProduct(
      id: _asInt(json['id']),
      name: _asString(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GetOrdersUsecaseModelDataItemRestaurant {
  int? id;
  String? name;

  GetOrdersUsecaseModelDataItemRestaurant({
    this.id,
    this.name,
  });

  factory GetOrdersUsecaseModelDataItemRestaurant.fromJson(Map<String, dynamic> json) {
    return GetOrdersUsecaseModelDataItemRestaurant(
      id: _asInt(json['id']),
      name: _asString(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GetOrdersUsecaseModelDataItemUser {
  int? id;
  String? name;
  String? email;

  GetOrdersUsecaseModelDataItemUser({
    this.id,
    this.name,
    this.email,
  });

  factory GetOrdersUsecaseModelDataItemUser.fromJson(Map<String, dynamic> json) {
    return GetOrdersUsecaseModelDataItemUser(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      email: _asString(json['email']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}