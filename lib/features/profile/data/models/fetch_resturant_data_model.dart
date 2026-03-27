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

FetchResturantDataModel fetchResturantDataModelFromJson(str) => FetchResturantDataModel.fromJson(str);

String fetchResturantDataModelToJson(FetchResturantDataModel data) => json.encode(data.toJson());


FetchResturantDataModelData fetchResturantDataModelDataFromJson(str) => FetchResturantDataModelData.fromJson(str);

String fetchResturantDataModelDataToJson(FetchResturantDataModelData data) => json.encode(data.toJson());


FetchResturantDataModelDataOperatingHoursItem fetchResturantDataModelDataOperatingHoursItemFromJson(str) => FetchResturantDataModelDataOperatingHoursItem.fromJson(str);

String fetchResturantDataModelDataOperatingHoursItemToJson(FetchResturantDataModelDataOperatingHoursItem data) => json.encode(data.toJson());


FetchResturantDataModelDataCuisineTypesItem fetchResturantDataModelDataCuisineTypesItemFromJson(str) => FetchResturantDataModelDataCuisineTypesItem.fromJson(str);

String fetchResturantDataModelDataCuisineTypesItemToJson(FetchResturantDataModelDataCuisineTypesItem data) => json.encode(data.toJson());


FetchResturantDataModelDataUser fetchResturantDataModelDataUserFromJson(str) => FetchResturantDataModelDataUser.fromJson(str);

String fetchResturantDataModelDataUserToJson(FetchResturantDataModelDataUser data) => json.encode(data.toJson());


class FetchResturantDataModel {
  FetchResturantDataModelData? data;

  FetchResturantDataModel({
    this.data,
  });

  factory FetchResturantDataModel.fromJson(Map<String, dynamic> json) {
    return FetchResturantDataModel(
      data: json['data'] is Map ? FetchResturantDataModelData.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class FetchResturantDataModelData {
  int? id;
  int? userId;
  String? name;
  String? slug;
  String? description;
  String? address;
  String? city;
  String? district;
  String? locationDetails;
  double? latitude;
  double? longitude;
  String? phone;
  String? whatsappNumber;
  String? email;
  String? instagramUsername;
  String? facebookPageName;
  double? averageRating;
  int? totalReviews;
  int? estimatedPreparationTime;
  int? minimumOrderAmount;
  String? priceRange;
  int? reputationScore;
  int? warningCount;
  int? visibilityScore;
  bool? manualVisibilityOverride;
  bool? isActive;
  bool? isFeatured;
  bool? isTemporarilyClosed;
  dynamic suspensionUntil;
  String? primaryImage;
  List<dynamic>? images;
  FetchResturantDataModelDataUser? user;
  List<FetchResturantDataModelDataCuisineTypesItem>? cuisineTypes;
  List<FetchResturantDataModelDataOperatingHoursItem>? operatingHours;
  List<dynamic>? documents;
  List<dynamic>? reputationLogs;
  List<dynamic>? penalties;
  String? createdAt;
  String? updatedAt;

  FetchResturantDataModelData({
    this.id,
    this.userId,
    this.name,
    this.slug,
    this.description,
    this.address,
    this.city,
    this.district,
    this.locationDetails,
    this.latitude,
    this.longitude,
    this.phone,
    this.whatsappNumber,
    this.email,
    this.instagramUsername,
    this.facebookPageName,
    this.averageRating,
    this.totalReviews,
    this.estimatedPreparationTime,
    this.minimumOrderAmount,
    this.priceRange,
    this.reputationScore,
    this.warningCount,
    this.visibilityScore,
    this.manualVisibilityOverride,
    this.isActive,
    this.isFeatured,
    this.isTemporarilyClosed,
    this.suspensionUntil,
    this.primaryImage,
    this.images,
    this.user,
    this.cuisineTypes,
    this.operatingHours,
    this.documents,
    this.reputationLogs,
    this.penalties,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchResturantDataModelData.fromJson(Map<String, dynamic> json) {
    return FetchResturantDataModelData(
      id: _asInt(json['id']),
      userId: _asInt(json['userId']),
      name: _asString(json['name']),
      slug: _asString(json['slug']),
      description: _asString(json['description']),
      address: _asString(json['address']),
      city: _asString(json['city']),
      district: _asString(json['district']),
      locationDetails: _asString(json['locationDetails']),
      latitude: _asDouble(json['latitude']),
      longitude: _asDouble(json['longitude']),
      phone: _asString(json['phone']),
      whatsappNumber: _asString(json['whatsappNumber']),
      email: _asString(json['email']),
      instagramUsername: _asString(json['instagramUsername']),
      facebookPageName: _asString(json['facebookPageName']),
      averageRating: _asDouble(json['averageRating']),
      totalReviews: _asInt(json['totalReviews']),
      estimatedPreparationTime: _asInt(json['estimatedPreparationTime']),
      minimumOrderAmount: _asInt(json['minimumOrderAmount']),
      priceRange: _asString(json['priceRange']),
      reputationScore: _asInt(json['reputationScore']),
      warningCount: _asInt(json['warningCount']),
      visibilityScore: _asInt(json['visibilityScore']),
      manualVisibilityOverride: _asBool(json['manualVisibilityOverride']),
      isActive: _asBool(json['isActive']),
      isFeatured: _asBool(json['isFeatured']),
      isTemporarilyClosed: _asBool(json['isTemporarilyClosed']),
      suspensionUntil: _asDynamic(json['suspensionUntil']),
      primaryImage: _asString(json['primaryImage']),
      images: _asDynamicList(json['images']),
      user: json['user'] is Map ? FetchResturantDataModelDataUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)) : null,
      cuisineTypes: json['cuisineTypes'] is List ? (json['cuisineTypes'] as List).whereType<Map>().map((item) => FetchResturantDataModelDataCuisineTypesItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      operatingHours: json['operatingHours'] is List ? (json['operatingHours'] as List).whereType<Map>().map((item) => FetchResturantDataModelDataOperatingHoursItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      documents: _asDynamicList(json['documents']),
      reputationLogs: _asDynamicList(json['reputationLogs']),
      penalties: _asDynamicList(json['penalties']),
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'slug': slug,
      'description': description,
      'address': address,
      'city': city,
      'district': district,
      'locationDetails': locationDetails,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'whatsappNumber': whatsappNumber,
      'email': email,
      'instagramUsername': instagramUsername,
      'facebookPageName': facebookPageName,
      'averageRating': averageRating,
      'totalReviews': totalReviews,
      'estimatedPreparationTime': estimatedPreparationTime,
      'minimumOrderAmount': minimumOrderAmount,
      'priceRange': priceRange,
      'reputationScore': reputationScore,
      'warningCount': warningCount,
      'visibilityScore': visibilityScore,
      'manualVisibilityOverride': manualVisibilityOverride,
      'isActive': isActive,
      'isFeatured': isFeatured,
      'isTemporarilyClosed': isTemporarilyClosed,
      'suspensionUntil': suspensionUntil,
      'primaryImage': primaryImage,
      'images': images,
      'user': user?.toJson(),
      'cuisineTypes': cuisineTypes?.map((item) => item.toJson()).toList(),
      'operatingHours': operatingHours?.map((item) => item.toJson()).toList(),
      'documents': documents,
      'reputationLogs': reputationLogs,
      'penalties': penalties,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class FetchResturantDataModelDataOperatingHoursItem {
  int? id;
  int? restaurantId;
  String? dayOfWeek;
  String? openTime;
  String? closeTime;
  bool? isClosed;
  dynamic createdAt;
  String? updatedAt;

  FetchResturantDataModelDataOperatingHoursItem({
    this.id,
    this.restaurantId,
    this.dayOfWeek,
    this.openTime,
    this.closeTime,
    this.isClosed,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchResturantDataModelDataOperatingHoursItem.fromJson(Map<String, dynamic> json) {
    return FetchResturantDataModelDataOperatingHoursItem(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurant_id']),
      dayOfWeek: _asString(json['day_of_week']),
      openTime: _asString(json['open_time']),
      closeTime: _asString(json['close_time']),
      isClosed: _asBool(json['is_closed']),
      createdAt: _asDynamic(json['created_at']),
      updatedAt: _asString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'day_of_week': dayOfWeek,
      'open_time': openTime,
      'close_time': closeTime,
      'is_closed': isClosed,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class FetchResturantDataModelDataCuisineTypesItem {
  int? id;
  String? name;
  String? slug;

  FetchResturantDataModelDataCuisineTypesItem({
    this.id,
    this.name,
    this.slug,
  });

  factory FetchResturantDataModelDataCuisineTypesItem.fromJson(Map<String, dynamic> json) {
    return FetchResturantDataModelDataCuisineTypesItem(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      slug: _asString(json['slug']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}

class FetchResturantDataModelDataUser {
  int? id;
  String? name;
  String? email;

  FetchResturantDataModelDataUser({
    this.id,
    this.name,
    this.email,
  });

  factory FetchResturantDataModelDataUser.fromJson(Map<String, dynamic> json) {
    return FetchResturantDataModelDataUser(
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