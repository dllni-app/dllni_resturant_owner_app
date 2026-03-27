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

FetchCategoriesModel fetchCategoriesModelFromJson(str) => FetchCategoriesModel.fromJson(str);

String fetchCategoriesModelToJson(FetchCategoriesModel data) => json.encode(data.toJson());


FetchCategoriesModelMeta fetchCategoriesModelMetaFromJson(str) => FetchCategoriesModelMeta.fromJson(str);

String fetchCategoriesModelMetaToJson(FetchCategoriesModelMeta data) => json.encode(data.toJson());


FetchCategoriesModelMetaLinksItem fetchCategoriesModelMetaLinksItemFromJson(str) => FetchCategoriesModelMetaLinksItem.fromJson(str);

String fetchCategoriesModelMetaLinksItemToJson(FetchCategoriesModelMetaLinksItem data) => json.encode(data.toJson());


FetchCategoriesModelLinks fetchCategoriesModelLinksFromJson(str) => FetchCategoriesModelLinks.fromJson(str);

String fetchCategoriesModelLinksToJson(FetchCategoriesModelLinks data) => json.encode(data.toJson());


FetchCategoriesModelDataItem fetchCategoriesModelDataItemFromJson(str) => FetchCategoriesModelDataItem.fromJson(str);

String fetchCategoriesModelDataItemToJson(FetchCategoriesModelDataItem data) => json.encode(data.toJson());


FetchCategoriesModelDataItemProductsItem fetchCategoriesModelDataItemProductsItemFromJson(str) => FetchCategoriesModelDataItemProductsItem.fromJson(str);

String fetchCategoriesModelDataItemProductsItemToJson(FetchCategoriesModelDataItemProductsItem data) => json.encode(data.toJson());


FetchCategoriesModelDataItemRestaurant fetchCategoriesModelDataItemRestaurantFromJson(str) => FetchCategoriesModelDataItemRestaurant.fromJson(str);

String fetchCategoriesModelDataItemRestaurantToJson(FetchCategoriesModelDataItemRestaurant data) => json.encode(data.toJson());


class FetchCategoriesModel {
  List<FetchCategoriesModelDataItem>? data;
  FetchCategoriesModelLinks? links;
  FetchCategoriesModelMeta? meta;

  FetchCategoriesModel({
    this.data,
    this.links,
    this.meta,
  });

  factory FetchCategoriesModel.fromJson(Map<String, dynamic> json) {
    return FetchCategoriesModel(
      data: json['data'] is List ? (json['data'] as List).whereType<Map>().map((item) => FetchCategoriesModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      links: json['links'] is Map ? FetchCategoriesModelLinks.fromJson(Map<String, dynamic>.from(json['links'] as Map)) : null,
      meta: json['meta'] is Map ? FetchCategoriesModelMeta.fromJson(Map<String, dynamic>.from(json['meta'] as Map)) : null,
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

class FetchCategoriesModelMeta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<FetchCategoriesModelMetaLinksItem>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  FetchCategoriesModelMeta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory FetchCategoriesModelMeta.fromJson(Map<String, dynamic> json) {
    return FetchCategoriesModelMeta(
      currentPage: _asInt(json['current_page']),
      from: _asInt(json['from']),
      lastPage: _asInt(json['last_page']),
      links: json['links'] is List ? (json['links'] as List).whereType<Map>().map((item) => FetchCategoriesModelMetaLinksItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
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
      'links': links?.map((item) => item.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

class FetchCategoriesModelMetaLinksItem {
  String? url;
  String? label;
  int? page;
  bool? active;

  FetchCategoriesModelMetaLinksItem({
    this.url,
    this.label,
    this.page,
    this.active,
  });

  factory FetchCategoriesModelMetaLinksItem.fromJson(Map<String, dynamic> json) {
    return FetchCategoriesModelMetaLinksItem(
      url: _asString(json['url']),
      label: _asString(json['label']),
      page: _asInt(json['page']),
      active: _asBool(json['active']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'page': page,
      'active': active,
    };
  }
}

class FetchCategoriesModelLinks {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  FetchCategoriesModelLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory FetchCategoriesModelLinks.fromJson(Map<String, dynamic> json) {
    return FetchCategoriesModelLinks(
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

class FetchCategoriesModelDataItem {
  int? id;
  int? restaurantId;
  String? name;
  String? slug;
  int? sortOrder;
  FetchCategoriesModelDataItemRestaurant? restaurant;
  List<FetchCategoriesModelDataItemProductsItem>? products;
  String? createdAt;
  String? updatedAt;

  FetchCategoriesModelDataItem({
    this.id,
    this.restaurantId,
    this.name,
    this.slug,
    this.sortOrder,
    this.restaurant,
    this.products,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchCategoriesModelDataItem.fromJson(Map<String, dynamic> json) {
    return FetchCategoriesModelDataItem(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurantId']),
      name: _asString(json['name']),
      slug: _asString(json['slug']),
      sortOrder: _asInt(json['sortOrder']),
      restaurant: json['restaurant'] is Map ? FetchCategoriesModelDataItemRestaurant.fromJson(Map<String, dynamic>.from(json['restaurant'] as Map)) : null,
      products: json['products'] is List ? (json['products'] as List).whereType<Map>().map((item) => FetchCategoriesModelDataItemProductsItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'slug': slug,
      'sortOrder': sortOrder,
      'restaurant': restaurant?.toJson(),
      'products': products?.map((item) => item.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class FetchCategoriesModelDataItemProductsItem {
  int? id;
  int? restaurantId;
  int? categoryId;
  dynamic masterProductId;
  String? name;
  String? slug;
  dynamic description;
  String? price;
  dynamic discountedPrice;
  bool? isAvailable;
  String? unavailableUntil;
  String? availabilityNote;
  int? stockQuantity;
  int? lowStockThreshold;
  int? preparationTime;
  bool? isFeatured;
  String? createdAt;
  String? updatedAt;

  FetchCategoriesModelDataItemProductsItem({
    this.id,
    this.restaurantId,
    this.categoryId,
    this.masterProductId,
    this.name,
    this.slug,
    this.description,
    this.price,
    this.discountedPrice,
    this.isAvailable,
    this.unavailableUntil,
    this.availabilityNote,
    this.stockQuantity,
    this.lowStockThreshold,
    this.preparationTime,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchCategoriesModelDataItemProductsItem.fromJson(Map<String, dynamic> json) {
    return FetchCategoriesModelDataItemProductsItem(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurant_id']),
      categoryId: _asInt(json['category_id']),
      masterProductId: _asDynamic(json['master_product_id']),
      name: _asString(json['name']),
      slug: _asString(json['slug']),
      description: _asDynamic(json['description']),
      price: _asString(json['price']),
      discountedPrice: _asDynamic(json['discounted_price']),
      isAvailable: _asBool(json['is_available']),
      unavailableUntil: _asString(json['unavailable_until']),
      availabilityNote: _asString(json['availability_note']),
      stockQuantity: _asInt(json['stock_quantity']),
      lowStockThreshold: _asInt(json['low_stock_threshold']),
      preparationTime: _asInt(json['preparation_time']),
      isFeatured: _asBool(json['is_featured']),
      createdAt: _asString(json['created_at']),
      updatedAt: _asString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'category_id': categoryId,
      'master_product_id': masterProductId,
      'name': name,
      'slug': slug,
      'description': description,
      'price': price,
      'discounted_price': discountedPrice,
      'is_available': isAvailable,
      'unavailable_until': unavailableUntil,
      'availability_note': availabilityNote,
      'stock_quantity': stockQuantity,
      'low_stock_threshold': lowStockThreshold,
      'preparation_time': preparationTime,
      'is_featured': isFeatured,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class FetchCategoriesModelDataItemRestaurant {
  int? id;
  String? name;

  FetchCategoriesModelDataItemRestaurant({
    this.id,
    this.name,
  });

  factory FetchCategoriesModelDataItemRestaurant.fromJson(Map<String, dynamic> json) {
    return FetchCategoriesModelDataItemRestaurant(
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