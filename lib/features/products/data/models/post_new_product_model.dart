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

PostNewProductModel postNewProductModelFromJson(str) => PostNewProductModel.fromJson(str);

String postNewProductModelToJson(PostNewProductModel data) => json.encode(data.toJson());


PostNewProductModelData postNewProductModelDataFromJson(str) => PostNewProductModelData.fromJson(str);

String postNewProductModelDataToJson(PostNewProductModelData data) => json.encode(data.toJson());


PostNewProductModelDataSubstitutionsItem postNewProductModelDataSubstitutionsItemFromJson(str) => PostNewProductModelDataSubstitutionsItem.fromJson(str);

String postNewProductModelDataSubstitutionsItemToJson(PostNewProductModelDataSubstitutionsItem data) => json.encode(data.toJson());


PostNewProductModelDataModifierGroupsItem postNewProductModelDataModifierGroupsItemFromJson(str) => PostNewProductModelDataModifierGroupsItem.fromJson(str);

String postNewProductModelDataModifierGroupsItemToJson(PostNewProductModelDataModifierGroupsItem data) => json.encode(data.toJson());


PostNewProductModelDataCategory postNewProductModelDataCategoryFromJson(str) => PostNewProductModelDataCategory.fromJson(str);

String postNewProductModelDataCategoryToJson(PostNewProductModelDataCategory data) => json.encode(data.toJson());


PostNewProductModelDataRestaurant postNewProductModelDataRestaurantFromJson(str) => PostNewProductModelDataRestaurant.fromJson(str);

String postNewProductModelDataRestaurantToJson(PostNewProductModelDataRestaurant data) => json.encode(data.toJson());


class PostNewProductModel {
  PostNewProductModelData? data;

  PostNewProductModel({
    this.data,
  });

  factory PostNewProductModel.fromJson(Map<String, dynamic> json) {
    return PostNewProductModel(
      data: json['data'] is Map ? PostNewProductModelData.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class PostNewProductModelData {
  int? id;
  int? restaurantId;
  int? categoryId;
  String? name;
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
  PostNewProductModelDataRestaurant? restaurant;
  PostNewProductModelDataCategory? category;
  List<PostNewProductModelDataModifierGroupsItem>? modifierGroups;
  List<PostNewProductModelDataSubstitutionsItem>? substitutions;
  String? primaryImage;
  String? images;
  String? createdAt;
  String? updatedAt;

  PostNewProductModelData({
    this.id,
    this.restaurantId,
    this.categoryId,
    this.name,
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
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  factory PostNewProductModelData.fromJson(Map<String, dynamic> json) {
    return PostNewProductModelData(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurantId']),
      categoryId: _asInt(json['categoryId']),
      name: _asString(json['name']),
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
      restaurant: json['restaurant'] is Map ? PostNewProductModelDataRestaurant.fromJson(Map<String, dynamic>.from(json['restaurant'] as Map)) : null,
      category: json['category'] is Map ? PostNewProductModelDataCategory.fromJson(Map<String, dynamic>.from(json['category'] as Map)) : null,
      modifierGroups: json['modifierGroups'] is List ? (json['modifierGroups'] as List).whereType<Map>().map((item) => PostNewProductModelDataModifierGroupsItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      substitutions: json['substitutions'] is List ? (json['substitutions'] as List).whereType<Map>().map((item) => PostNewProductModelDataSubstitutionsItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      primaryImage: _asString(json['primaryImage']),
      images: _asString(json['images']),
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'categoryId': categoryId,
      'name': name,
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
      'images': images,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class PostNewProductModelDataSubstitutionsItem {
  int? id;
  int? restaurantId;
  int? productId;
  int? substituteProductId;
  String? createdAt;
  String? updatedAt;

  PostNewProductModelDataSubstitutionsItem({
    this.id,
    this.restaurantId,
    this.productId,
    this.substituteProductId,
    this.createdAt,
    this.updatedAt,
  });

  factory PostNewProductModelDataSubstitutionsItem.fromJson(Map<String, dynamic> json) {
    return PostNewProductModelDataSubstitutionsItem(
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

class PostNewProductModelDataModifierGroupsItem {
  int? id;
  int? restaurantId;
  String? name;
  bool? isRequired;
  int? minSelections;
  int? maxSelections;
  String? createdAt;
  String? updatedAt;

  PostNewProductModelDataModifierGroupsItem({
    this.id,
    this.restaurantId,
    this.name,
    this.isRequired,
    this.minSelections,
    this.maxSelections,
    this.createdAt,
    this.updatedAt,
  });

  factory PostNewProductModelDataModifierGroupsItem.fromJson(Map<String, dynamic> json) {
    return PostNewProductModelDataModifierGroupsItem(
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

class PostNewProductModelDataCategory {
  int? id;
  String? name;

  PostNewProductModelDataCategory({
    this.id,
    this.name,
  });

  factory PostNewProductModelDataCategory.fromJson(Map<String, dynamic> json) {
    return PostNewProductModelDataCategory(
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

class PostNewProductModelDataRestaurant {
  int? id;
  String? name;

  PostNewProductModelDataRestaurant({
    this.id,
    this.name,
  });

  factory PostNewProductModelDataRestaurant.fromJson(Map<String, dynamic> json) {
    return PostNewProductModelDataRestaurant(
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