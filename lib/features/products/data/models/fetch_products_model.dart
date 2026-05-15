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

FetchProductsModel fetchProductsModelFromJson(str) => FetchProductsModel.fromJson(str);

String fetchProductsModelToJson(FetchProductsModel data) => json.encode(data.toJson());


FetchProductsModelMeta fetchProductsModelMetaFromJson(str) => FetchProductsModelMeta.fromJson(str);

String fetchProductsModelMetaToJson(FetchProductsModelMeta data) => json.encode(data.toJson());


FetchProductsModelMetaLinksItem fetchProductsModelMetaLinksItemFromJson(str) => FetchProductsModelMetaLinksItem.fromJson(str);

String fetchProductsModelMetaLinksItemToJson(FetchProductsModelMetaLinksItem data) => json.encode(data.toJson());


FetchProductsModelLinks fetchProductsModelLinksFromJson(str) => FetchProductsModelLinks.fromJson(str);

String fetchProductsModelLinksToJson(FetchProductsModelLinks data) => json.encode(data.toJson());


FetchProductsModelDataItem fetchProductsModelDataItemFromJson(str) => FetchProductsModelDataItem.fromJson(str);

String fetchProductsModelDataItemToJson(FetchProductsModelDataItem data) => json.encode(data.toJson());


FetchProductsModelDataItemSubstitutionsItem fetchProductsModelDataItemSubstitutionsItemFromJson(str) => FetchProductsModelDataItemSubstitutionsItem.fromJson(str);

String fetchProductsModelDataItemSubstitutionsItemToJson(FetchProductsModelDataItemSubstitutionsItem data) => json.encode(data.toJson());


FetchProductsModelDataItemModifierGroupsItem fetchProductsModelDataItemModifierGroupsItemFromJson(str) => FetchProductsModelDataItemModifierGroupsItem.fromJson(str);

String fetchProductsModelDataItemModifierGroupsItemToJson(FetchProductsModelDataItemModifierGroupsItem data) => json.encode(data.toJson());


FetchProductsModelDataItemCategory fetchProductsModelDataItemCategoryFromJson(str) => FetchProductsModelDataItemCategory.fromJson(str);

String fetchProductsModelDataItemCategoryToJson(FetchProductsModelDataItemCategory data) => json.encode(data.toJson());


FetchProductsModelDataItemRestaurant fetchProductsModelDataItemRestaurantFromJson(str) => FetchProductsModelDataItemRestaurant.fromJson(str);

String fetchProductsModelDataItemRestaurantToJson(FetchProductsModelDataItemRestaurant data) => json.encode(data.toJson());


class FetchProductsModel {
  List<FetchProductsModelDataItem>? data;
  FetchProductsModelLinks? links;
  FetchProductsModelMeta? meta;

  FetchProductsModel({
    this.data,
    this.links,
    this.meta,
  });

  factory FetchProductsModel.fromJson(Map<String, dynamic> json) {
    return FetchProductsModel(
      data: json['data'] is List ? (json['data'] as List).whereType<Map>().map((item) => FetchProductsModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      links: json['links'] is Map ? FetchProductsModelLinks.fromJson(Map<String, dynamic>.from(json['links'] as Map)) : null,
      meta: json['meta'] is Map ? FetchProductsModelMeta.fromJson(Map<String, dynamic>.from(json['meta'] as Map)) : null,
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

class FetchProductsModelMeta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<FetchProductsModelMetaLinksItem>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  FetchProductsModelMeta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory FetchProductsModelMeta.fromJson(Map<String, dynamic> json) {
    return FetchProductsModelMeta(
      currentPage: _asInt(json['current_page']),
      from: _asInt(json['from']),
      lastPage: _asInt(json['last_page']),
      links: json['links'] is List ? (json['links'] as List).whereType<Map>().map((item) => FetchProductsModelMetaLinksItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
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

class FetchProductsModelMetaLinksItem {
  String? url;
  String? label;
  bool? active;

  FetchProductsModelMetaLinksItem({
    this.url,
    this.label,
    this.active,
  });

  factory FetchProductsModelMetaLinksItem.fromJson(Map<String, dynamic> json) {
    return FetchProductsModelMetaLinksItem(
      url: _asString(json['url']),
      label: _asString(json['label']),
      active: _asBool(json['active']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

class FetchProductsModelLinks {
  String? first;
  String? last;
  String? prev;
  String? next;

  FetchProductsModelLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory FetchProductsModelLinks.fromJson(Map<String, dynamic> json) {
    return FetchProductsModelLinks(
      first: _asString(json['first']),
      last: _asString(json['last']),
      prev: _asString(json['prev']),
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

class FetchProductsModelDataItem {
  int? id;
  int? restaurantId;
  int? categoryId;
  int? masterProductId;
  String? name;
  String? slug;
  String? description;
  int? price;
  int? discountedPrice;
  bool? isAvailable;
  bool? isAvailableNow;
  String? availabilityMode;
  String? unavailableUntil;
  String? availabilityNote;
  int? stockQuantity;
  int? lowStockThreshold;
  int? preparationTime;
  bool? isFeatured;
  FetchProductsModelDataItemRestaurant? restaurant;
  FetchProductsModelDataItemCategory? category;
  List<FetchProductsModelDataItemModifierGroupsItem>? modifierGroups;
  List<FetchProductsModelDataItemSubstitutionsItem>? substitutions;
  /// Main image URL from the API (`primaryImage`).
  String? primaryImage;
  String? createdAt;
  String? updatedAt;

  FetchProductsModelDataItem({
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
    this.isAvailableNow,
    this.availabilityMode,
    this.unavailableUntil,
    this.availabilityNote,
    this.stockQuantity,
    this.lowStockThreshold,
    this.preparationTime,
    this.isFeatured,
    this.restaurant,
    this.category,
    this.modifierGroups,
    this.substitutions,
    this.primaryImage,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchProductsModelDataItem.fromJson(Map<String, dynamic> json) {
    return FetchProductsModelDataItem(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurantId']),
      categoryId: _asInt(json['categoryId']),
      masterProductId: _asInt(json['masterProductId']),
      name: _asString(json['name']),
      slug: _asString(json['slug']),
      description: _asString(json['description']),
      price: _asInt(json['price']),
      discountedPrice: _asInt(json['discountedPrice']),
      isAvailable: _asBool(json['isAvailable']),
      isAvailableNow: _asBool(json['isAvailableNow']),
      availabilityMode: _asString(json['availabilityMode']),
      unavailableUntil: _asString(json['unavailableUntil']),
      availabilityNote: _asString(json['availabilityNote']),
      stockQuantity: _asInt(json['stockQuantity']),
      lowStockThreshold: _asInt(json['lowStockThreshold']),
      preparationTime: _asInt(json['preparationTime']),
      isFeatured: _asBool(json['isFeatured']),
      restaurant: json['restaurant'] is Map ? FetchProductsModelDataItemRestaurant.fromJson(Map<String, dynamic>.from(json['restaurant'] as Map)) : null,
      category: json['category'] is Map ? FetchProductsModelDataItemCategory.fromJson(Map<String, dynamic>.from(json['category'] as Map)) : null,
      modifierGroups: json['modifierGroups'] is List ? (json['modifierGroups'] as List).whereType<Map>().map((item) => FetchProductsModelDataItemModifierGroupsItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      substitutions: json['substitutions'] is List ? (json['substitutions'] as List).whereType<Map>().map((item) => FetchProductsModelDataItemSubstitutionsItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      primaryImage: _asString(json['primaryImage']),
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'categoryId': categoryId,
      'masterProductId': masterProductId,
      'name': name,
      'slug': slug,
      'description': description,
      'price': price,
      'discountedPrice': discountedPrice,
      'isAvailable': isAvailable,
      'isAvailableNow': isAvailableNow,
      'availabilityMode': availabilityMode,
      'unavailableUntil': unavailableUntil,
      'availabilityNote': availabilityNote,
      'stockQuantity': stockQuantity,
      'lowStockThreshold': lowStockThreshold,
      'preparationTime': preparationTime,
      'isFeatured': isFeatured,
      'restaurant': restaurant?.toJson(),
      'category': category?.toJson(),
      'modifierGroups': modifierGroups?.map((item) => item.toJson()).toList(),
      'substitutions': substitutions?.map((item) => item.toJson()).toList(),
      'primaryImage': primaryImage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class FetchProductsModelDataItemSubstitutionsItem {
  int? id;
  int? restaurantId;
  int? productId;
  int? substituteProductId;
  String? createdAt;
  String? updatedAt;

  FetchProductsModelDataItemSubstitutionsItem({
    this.id,
    this.restaurantId,
    this.productId,
    this.substituteProductId,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchProductsModelDataItemSubstitutionsItem.fromJson(Map<String, dynamic> json) {
    return FetchProductsModelDataItemSubstitutionsItem(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurant_id']),
      productId: _asInt(json['product_id']),
      substituteProductId: _asInt(json['substitute_product_id']),
      createdAt: _asString(json['created_at']),
      updatedAt: _asString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'product_id': productId,
      'substitute_product_id': substituteProductId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class FetchProductsModelDataItemModifierGroupsItem {
  int? id;
  int? restaurantId;
  String? name;
  bool? isRequired;
  int? minSelections;
  int? maxSelections;
  String? createdAt;
  String? updatedAt;

  FetchProductsModelDataItemModifierGroupsItem({
    this.id,
    this.restaurantId,
    this.name,
    this.isRequired,
    this.minSelections,
    this.maxSelections,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchProductsModelDataItemModifierGroupsItem.fromJson(Map<String, dynamic> json) {
    return FetchProductsModelDataItemModifierGroupsItem(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurant_id']),
      name: _asString(json['name']),
      isRequired: _asBool(json['is_required']),
      minSelections: _asInt(json['min_selections']),
      maxSelections: _asInt(json['max_selections']),
      createdAt: _asString(json['created_at']),
      updatedAt: _asString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'name': name,
      'is_required': isRequired,
      'min_selections': minSelections,
      'max_selections': maxSelections,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class FetchProductsModelDataItemCategory {
  int? id;
  String? name;

  FetchProductsModelDataItemCategory({
    this.id,
    this.name,
  });

  factory FetchProductsModelDataItemCategory.fromJson(Map<String, dynamic> json) {
    return FetchProductsModelDataItemCategory(
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

class FetchProductsModelDataItemRestaurant {
  int? id;
  String? name;

  FetchProductsModelDataItemRestaurant({
    this.id,
    this.name,
  });

  factory FetchProductsModelDataItemRestaurant.fromJson(Map<String, dynamic> json) {
    return FetchProductsModelDataItemRestaurant(
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