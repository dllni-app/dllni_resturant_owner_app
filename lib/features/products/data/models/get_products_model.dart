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

GetProductsModel getProductsModelFromJson(str) => GetProductsModel.fromJson(str);

String getProductsModelToJson(GetProductsModel data) => json.encode(data.toJson());


GetProductsModelMeta getProductsModelMetaFromJson(str) => GetProductsModelMeta.fromJson(str);

String getProductsModelMetaToJson(GetProductsModelMeta data) => json.encode(data.toJson());


GetProductsModelLinks getProductsModelLinksFromJson(str) => GetProductsModelLinks.fromJson(str);

String getProductsModelLinksToJson(GetProductsModelLinks data) => json.encode(data.toJson());


GetProductsModelDataItem getProductsModelDataItemFromJson(str) => GetProductsModelDataItem.fromJson(str);

String getProductsModelDataItemToJson(GetProductsModelDataItem data) => json.encode(data.toJson());


class GetProductsModel {
  List<GetProductsModelDataItem>? data;
  GetProductsModelLinks? links;
  GetProductsModelMeta? meta;

  GetProductsModel({
    this.data,
    this.links,
    this.meta,
  });

  factory GetProductsModel.fromJson(Map<String, dynamic> json) {
    return GetProductsModel(
      data: json['data'] is List ? (json['data'] as List).whereType<Map>().map((item) => GetProductsModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      links: json['links'] is Map ? GetProductsModelLinks.fromJson(Map<String, dynamic>.from(json['links'] as Map)) : null,
      meta: json['meta'] is Map ? GetProductsModelMeta.fromJson(Map<String, dynamic>.from(json['meta'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
      'links': links?.toJson(),
      'meta': meta?.toJson(),
    };
  }
}

class GetProductsModelMeta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  GetProductsModelMeta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory GetProductsModelMeta.fromJson(Map<String, dynamic> json) {
    return GetProductsModelMeta(
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
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

class GetProductsModelLinks {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  GetProductsModelLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory GetProductsModelLinks.fromJson(Map<String, dynamic> json) {
    return GetProductsModelLinks(
      first: _asString(json['first']),
      last: _asString(json['last']),
      prev: _asDynamic(json['prev']),
      next: _asString(json['next']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
}

class GetProductsModelDataItem {
  int? id;
  String? name;
  String? slug;
  String? description;
  double? price;
  dynamic discountedPrice;
  bool? isAvailable;
  bool? isFeatured;
  int? restaurantId;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  GetProductsModelDataItem({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.price,
    this.discountedPrice,
    this.isAvailable,
    this.isFeatured,
    this.restaurantId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory GetProductsModelDataItem.fromJson(Map<String, dynamic> json) {
    return GetProductsModelDataItem(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      slug: _asString(json['slug']),
      description: _asString(json['description']),
      price: _asDouble(json['price']),
      discountedPrice: _asDynamic(json['discountedPrice']),
      isAvailable: _asBool(json['isAvailable']),
      isFeatured: _asBool(json['isFeatured']),
      restaurantId: _asInt(json['restaurantId']),
      categoryId: _asInt(json['categoryId']),
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'price': price,
      'discountedPrice': discountedPrice,
      'isAvailable': isAvailable,
      'isFeatured': isFeatured,
      'restaurantId': restaurantId,
      'categoryId': categoryId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}