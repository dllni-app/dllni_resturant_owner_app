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

  Map<String, dynamic> toJson() {
    return {'data': data?.map((item) => item.toJson()).toList()};
  }
}

class FetchInventoryItemsModelDataItem {
  int? id;
  String? name;
  String? unit;
  String? createdAt;
  String? updatedAt;
  int? quantity;
  int? minimumLimit;
  double? unitCost;

  FetchInventoryItemsModelDataItem({this.id, this.name, this.unit, this.quantity, this.minimumLimit, this.unitCost, this.createdAt, this.updatedAt});

  factory FetchInventoryItemsModelDataItem.fromJson(Map<String, dynamic> json) {
    return FetchInventoryItemsModelDataItem(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      unit: _asString(json['unit']),
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
      quantity: _asInt(json['quantity']),
      minimumLimit: _asInt(json['minimumLimit']),
      unitCost: _asDouble(json['unitCost']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'unit': unit, 'quantity': quantity, 'minimumLimit': minimumLimit, 'unitCost': unitCost};
  }
}
