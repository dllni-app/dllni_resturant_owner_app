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

CreateOrderUsecaseModel createOrderUsecaseModelFromJson(str) => CreateOrderUsecaseModel.fromJson(str);

String createOrderUsecaseModelToJson(CreateOrderUsecaseModel data) => json.encode(data.toJson());


CreateOrderUsecaseModelData createOrderUsecaseModelDataFromJson(str) => CreateOrderUsecaseModelData.fromJson(str);

String createOrderUsecaseModelDataToJson(CreateOrderUsecaseModelData data) => json.encode(data.toJson());


CreateOrderUsecaseModelDataOrderItemsItem createOrderUsecaseModelDataOrderItemsItemFromJson(str) => CreateOrderUsecaseModelDataOrderItemsItem.fromJson(str);

String createOrderUsecaseModelDataOrderItemsItemToJson(CreateOrderUsecaseModelDataOrderItemsItem data) => json.encode(data.toJson());


CreateOrderUsecaseModelDataOrderItemsItemProduct createOrderUsecaseModelDataOrderItemsItemProductFromJson(str) => CreateOrderUsecaseModelDataOrderItemsItemProduct.fromJson(str);

String createOrderUsecaseModelDataOrderItemsItemProductToJson(CreateOrderUsecaseModelDataOrderItemsItemProduct data) => json.encode(data.toJson());


class CreateOrderUsecaseModel {
  CreateOrderUsecaseModelData? data;
  String? message;

  CreateOrderUsecaseModel({
    this.data,
    this.message,
  });

  factory CreateOrderUsecaseModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderUsecaseModel(
      data: json['data'] is Map ? CreateOrderUsecaseModelData.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
      message: _asString(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class CreateOrderUsecaseModelData {
  int? id;
  String? status;
  int? totalAmount;
  String? createdAt;
  List<CreateOrderUsecaseModelDataOrderItemsItem>? orderItems;

  CreateOrderUsecaseModelData({
    this.id,
    this.status,
    this.totalAmount,
    this.createdAt,
    this.orderItems,
  });

  factory CreateOrderUsecaseModelData.fromJson(Map<String, dynamic> json) {
    return CreateOrderUsecaseModelData(
      id: _asInt(json['id']),
      status: _asString(json['status']),
      totalAmount: _asInt(json['totalAmount']),
      createdAt: _asString(json['createdAt']),
      orderItems: json['orderItems'] is List ? (json['orderItems'] as List).whereType<Map>().map((item) => CreateOrderUsecaseModelDataOrderItemsItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'totalAmount': totalAmount,
      'createdAt': createdAt,
      'orderItems': orderItems?.map((item) => item.toJson()).toList(),
    };
  }
}

class CreateOrderUsecaseModelDataOrderItemsItem {
  int? id;
  int? quantity;
  CreateOrderUsecaseModelDataOrderItemsItemProduct? product;

  CreateOrderUsecaseModelDataOrderItemsItem({
    this.id,
    this.quantity,
    this.product,
  });

  factory CreateOrderUsecaseModelDataOrderItemsItem.fromJson(Map<String, dynamic> json) {
    return CreateOrderUsecaseModelDataOrderItemsItem(
      id: _asInt(json['id']),
      quantity: _asInt(json['quantity']),
      product: json['product'] is Map ? CreateOrderUsecaseModelDataOrderItemsItemProduct.fromJson(Map<String, dynamic>.from(json['product'] as Map)) : null,
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

class CreateOrderUsecaseModelDataOrderItemsItemProduct {
  int? id;
  String? name;

  CreateOrderUsecaseModelDataOrderItemsItemProduct({
    this.id,
    this.name,
  });

  factory CreateOrderUsecaseModelDataOrderItemsItemProduct.fromJson(Map<String, dynamic> json) {
    return CreateOrderUsecaseModelDataOrderItemsItemProduct(
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