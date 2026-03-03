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

GetCategoriesModel getCategoriesModelFromJson(str) => GetCategoriesModel.fromJson(str);

String getCategoriesModelToJson(GetCategoriesModel data) => json.encode(data.toJson());


GetCategoriesModelMeta getCategoriesModelMetaFromJson(str) => GetCategoriesModelMeta.fromJson(str);

String getCategoriesModelMetaToJson(GetCategoriesModelMeta data) => json.encode(data.toJson());


GetCategoriesModelLinks getCategoriesModelLinksFromJson(str) => GetCategoriesModelLinks.fromJson(str);

String getCategoriesModelLinksToJson(GetCategoriesModelLinks data) => json.encode(data.toJson());


GetCategoriesModelDataItem getCategoriesModelDataItemFromJson(str) => GetCategoriesModelDataItem.fromJson(str);

String getCategoriesModelDataItemToJson(GetCategoriesModelDataItem data) => json.encode(data.toJson());


class GetCategoriesModel {
  List<GetCategoriesModelDataItem>? data;
  GetCategoriesModelLinks? links;
  GetCategoriesModelMeta? meta;

  GetCategoriesModel({
    this.data,
    this.links,
    this.meta,
  });

  factory GetCategoriesModel.fromJson(Map<String, dynamic> json) {
    return GetCategoriesModel(
      data: json['data'] is List ? (json['data'] as List).whereType<Map>().map((item) => GetCategoriesModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      links: json['links'] is Map ? GetCategoriesModelLinks.fromJson(Map<String, dynamic>.from(json['links'] as Map)) : null,
      meta: json['meta'] is Map ? GetCategoriesModelMeta.fromJson(Map<String, dynamic>.from(json['meta'] as Map)) : null,
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

class GetCategoriesModelMeta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  GetCategoriesModelMeta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory GetCategoriesModelMeta.fromJson(Map<String, dynamic> json) {
    return GetCategoriesModelMeta(
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

class GetCategoriesModelLinks {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  GetCategoriesModelLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory GetCategoriesModelLinks.fromJson(Map<String, dynamic> json) {
    return GetCategoriesModelLinks(
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

class GetCategoriesModelDataItem {
  int? id;
  String? name;
  String? slug;
  int? restaurantId;
  String? createdAt;
  String? updatedAt;

  GetCategoriesModelDataItem({
    this.id,
    this.name,
    this.slug,
    this.restaurantId,
    this.createdAt,
    this.updatedAt,
  });

  factory GetCategoriesModelDataItem.fromJson(Map<String, dynamic> json) {
    return GetCategoriesModelDataItem(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      slug: _asString(json['slug']),
      restaurantId: _asInt(json['restaurantId']),
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'restaurantId': restaurantId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}