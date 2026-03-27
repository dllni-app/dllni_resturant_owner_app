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

CreateInventoryItemModel createInventoryItemModelFromJson(str) =>
    CreateInventoryItemModel.fromJson(str);

String createInventoryItemModelToJson(CreateInventoryItemModel data) =>
    json.encode(data.toJson());

CreateInventoryItemModelData createInventoryItemModelDataFromJson(str) =>
    CreateInventoryItemModelData.fromJson(str);

String createInventoryItemModelDataToJson(CreateInventoryItemModelData data) =>
    json.encode(data.toJson());

CreateInventoryItemModelRestaurant createInventoryItemModelRestaurantFromJson(
        str) =>
    CreateInventoryItemModelRestaurant.fromJson(str);

String createInventoryItemModelRestaurantToJson(
        CreateInventoryItemModelRestaurant data) =>
    json.encode(data.toJson());

class CreateInventoryItemModel {
  CreateInventoryItemModelData? data;

  CreateInventoryItemModel({this.data});

  factory CreateInventoryItemModel.fromJson(Map<String, dynamic> json) {
    return CreateInventoryItemModel(
      data: json['data'] is Map
          ? CreateInventoryItemModelData.fromJson(
              Map<String, dynamic>.from(json['data'] as Map))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data?.toJson()};
  }
}

class CreateInventoryItemModelData {
  int? id;
  int? restaurantId;
  String? name;
  String? unit;
  int? quantity;
  int? minimumLimit;
  double? unitCost;
  CreateInventoryItemModelRestaurant? restaurant;
  String? products;
  String? createdAt;
  String? updatedAt;

  CreateInventoryItemModelData({
    this.id,
    this.restaurantId,
    this.name,
    this.unit,
    this.quantity,
    this.minimumLimit,
    this.unitCost,
    this.restaurant,
    this.products,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateInventoryItemModelData.fromJson(Map<String, dynamic> json) {
    return CreateInventoryItemModelData(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurantId']),
      name: _asString(json['name']),
      unit: _asString(json['unit']),
      quantity: _asInt(json['quantity']),
      minimumLimit: _asInt(json['minimumLimit']),
      unitCost: _asDouble(json['unitCost']),
      restaurant: json['restaurant'] is Map
          ? CreateInventoryItemModelRestaurant.fromJson(
              Map<String, dynamic>.from(json['restaurant'] as Map))
          : null,
      products: _asString(json['products']),
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'unit': unit,
      'quantity': quantity,
      'minimumLimit': minimumLimit,
      'unitCost': unitCost,
      'restaurant': restaurant?.toJson(),
      'products': products,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class CreateInventoryItemModelRestaurant {
  int? id;
  String? name;

  CreateInventoryItemModelRestaurant({this.id, this.name});

  factory CreateInventoryItemModelRestaurant.fromJson(
      Map<String, dynamic> json) {
    return CreateInventoryItemModelRestaurant(
      id: _asInt(json['id']),
      name: _asString(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
