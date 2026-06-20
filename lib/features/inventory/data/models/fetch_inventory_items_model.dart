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
  if (value is String) return int.tryParse(value) ?? double.tryParse(value)?.toInt();
  return null;
}

double? _asDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

FetchInventoryItemsModel fetchInventoryItemsModelFromJson(str) => FetchInventoryItemsModel.fromJson(str);

String fetchInventoryItemsModelToJson(FetchInventoryItemsModel data) => json.encode(data.toJson());

FetchInventoryItemsModelDataItem fetchInventoryItemsModelDataItemFromJson(str) => FetchInventoryItemsModelDataItem.fromJson(str);

String fetchInventoryItemsModelDataItemToJson(FetchInventoryItemsModelDataItem data) => json.encode(data.toJson());

class FetchInventoryItemsModel {
  List<FetchInventoryItemsModelDataItem>? data;

  FetchInventoryItemsModel({this.data});

  factory FetchInventoryItemsModel.fromJson(Map<String, dynamic> json) {
    return FetchInventoryItemsModel(
      data: json['data'] is List
          ? (json['data'] as List).whereType<Map>().map((item) => FetchInventoryItemsModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {'data': data?.map((item) => item.toJson()).toList()};
}

class FetchInventoryItemsModelDataItem {
  int? id;
  String? name;
  String? unit;
  String? createdAt;
  String? updatedAt;
  double? quantity;
  double? minimumLimit;
  double? unitCost;
  List<InventoryLinkedProduct>? products;

  FetchInventoryItemsModelDataItem({
    this.id,
    this.name,
    this.unit,
    this.quantity,
    this.minimumLimit,
    this.unitCost,
    this.products,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchInventoryItemsModelDataItem.fromJson(Map<String, dynamic> json) {
    return FetchInventoryItemsModelDataItem(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      unit: _asString(json['unit']),
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
      quantity: _asDouble(json['quantity']),
      minimumLimit: _asDouble(json['minimumLimit']),
      unitCost: _asDouble(json['unitCost']),
      products: json['products'] is List
          ? (json['products'] as List).whereType<Map>().map((item) => InventoryLinkedProduct.fromJson(Map<String, dynamic>.from(item))).toList()
          : <InventoryLinkedProduct>[],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'unit': unit,
        'quantity': quantity,
        'minimumLimit': minimumLimit,
        'unitCost': unitCost,
        'products': products?.map((item) => item.toJson()).toList(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class InventoryLinkedProduct {
  int? id;
  String? name;
  double? quantityUsed;

  InventoryLinkedProduct({this.id, this.name, this.quantityUsed});

  factory InventoryLinkedProduct.fromJson(Map<String, dynamic> json) {
    return InventoryLinkedProduct(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      quantityUsed: _asDouble(json['quantityUsed']),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'quantityUsed': quantityUsed};
}
