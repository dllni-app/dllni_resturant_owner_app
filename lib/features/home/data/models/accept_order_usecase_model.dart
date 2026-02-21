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

AcceptOrderUsecaseModel acceptOrderUsecaseModelFromJson(str) => AcceptOrderUsecaseModel.fromJson(str);

String acceptOrderUsecaseModelToJson(AcceptOrderUsecaseModel data) => json.encode(data.toJson());


AcceptOrderUsecaseModelData acceptOrderUsecaseModelDataFromJson(str) => AcceptOrderUsecaseModelData.fromJson(str);

String acceptOrderUsecaseModelDataToJson(AcceptOrderUsecaseModelData data) => json.encode(data.toJson());


AcceptOrderUsecaseModelDataOrderItemsItem acceptOrderUsecaseModelDataOrderItemsItemFromJson(str) => AcceptOrderUsecaseModelDataOrderItemsItem.fromJson(str);

String acceptOrderUsecaseModelDataOrderItemsItemToJson(AcceptOrderUsecaseModelDataOrderItemsItem data) => json.encode(data.toJson());


AcceptOrderUsecaseModelDataOrderItemsItemProduct acceptOrderUsecaseModelDataOrderItemsItemProductFromJson(str) => AcceptOrderUsecaseModelDataOrderItemsItemProduct.fromJson(str);

String acceptOrderUsecaseModelDataOrderItemsItemProductToJson(AcceptOrderUsecaseModelDataOrderItemsItemProduct data) => json.encode(data.toJson());


AcceptOrderUsecaseModelDataUser acceptOrderUsecaseModelDataUserFromJson(str) => AcceptOrderUsecaseModelDataUser.fromJson(str);

String acceptOrderUsecaseModelDataUserToJson(AcceptOrderUsecaseModelDataUser data) => json.encode(data.toJson());


class AcceptOrderUsecaseModel {
  AcceptOrderUsecaseModelData? data;
  String? message;

  AcceptOrderUsecaseModel({
    this.data,
    this.message,
  });

  factory AcceptOrderUsecaseModel.fromJson(Map<String, dynamic> json) {
    return AcceptOrderUsecaseModel(
      data: json['data'] is Map ? AcceptOrderUsecaseModelData.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
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

class AcceptOrderUsecaseModelData {
  int? id;
  String? status;
  String? acceptedAt;
  AcceptOrderUsecaseModelDataUser? user;
  List<AcceptOrderUsecaseModelDataOrderItemsItem>? orderItems;

  AcceptOrderUsecaseModelData({
    this.id,
    this.status,
    this.acceptedAt,
    this.user,
    this.orderItems,
  });

  factory AcceptOrderUsecaseModelData.fromJson(Map<String, dynamic> json) {
    return AcceptOrderUsecaseModelData(
      id: _asInt(json['id']),
      status: _asString(json['status']),
      acceptedAt: _asString(json['acceptedAt']),
      user: json['user'] is Map ? AcceptOrderUsecaseModelDataUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)) : null,
      orderItems: json['orderItems'] is List ? (json['orderItems'] as List).whereType<Map>().map((item) => AcceptOrderUsecaseModelDataOrderItemsItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'acceptedAt': acceptedAt,
      'user': user?.toJson(),
      'orderItems': orderItems?.map((item) => item.toJson()).toList(),
    };
  }
}

class AcceptOrderUsecaseModelDataOrderItemsItem {
  int? id;
  int? quantity;
  AcceptOrderUsecaseModelDataOrderItemsItemProduct? product;

  AcceptOrderUsecaseModelDataOrderItemsItem({
    this.id,
    this.quantity,
    this.product,
  });

  factory AcceptOrderUsecaseModelDataOrderItemsItem.fromJson(Map<String, dynamic> json) {
    return AcceptOrderUsecaseModelDataOrderItemsItem(
      id: _asInt(json['id']),
      quantity: _asInt(json['quantity']),
      product: json['product'] is Map ? AcceptOrderUsecaseModelDataOrderItemsItemProduct.fromJson(Map<String, dynamic>.from(json['product'] as Map)) : null,
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

class AcceptOrderUsecaseModelDataOrderItemsItemProduct {
  int? id;
  String? name;

  AcceptOrderUsecaseModelDataOrderItemsItemProduct({
    this.id,
    this.name,
  });

  factory AcceptOrderUsecaseModelDataOrderItemsItemProduct.fromJson(Map<String, dynamic> json) {
    return AcceptOrderUsecaseModelDataOrderItemsItemProduct(
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

class AcceptOrderUsecaseModelDataUser {
  int? id;
  String? name;
  String? email;

  AcceptOrderUsecaseModelDataUser({
    this.id,
    this.name,
    this.email,
  });

  factory AcceptOrderUsecaseModelDataUser.fromJson(Map<String, dynamic> json) {
    return AcceptOrderUsecaseModelDataUser(
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