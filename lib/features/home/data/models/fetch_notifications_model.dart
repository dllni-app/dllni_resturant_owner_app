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

dynamic _asDynamic(dynamic value) {
  if (value == null) return null;
  if (value is List) return value.map(_asDynamic).toList();
  if (value is Map) {
    final map = <String, dynamic>{};
    value.forEach((key, nestedValue) {
      map['$key'] = _asDynamic(nestedValue);
    });
    return map;
  }
  if (value is String || value is num || value is bool) return value;
  return value.toString();
}

FetchNotificationsModel fetchNotificationsModelFromJson(str) => FetchNotificationsModel.fromJson(str);

String fetchNotificationsModelToJson(FetchNotificationsModel data) => json.encode(data.toJson());

FetchNotificationsModelDataItem fetchNotificationsModelDataItemFromJson(str) => FetchNotificationsModelDataItem.fromJson(str);

String fetchNotificationsModelDataItemToJson(FetchNotificationsModelDataItem data) => json.encode(data.toJson());

class FetchNotificationsModel {
  List<FetchNotificationsModelDataItem>? data;
  FetchNotificationsModelMeta? meta;

  FetchNotificationsModel({this.data, this.meta});

  factory FetchNotificationsModel.fromJson(Map<String, dynamic> json) {
    return FetchNotificationsModel(
      data: json['data'] is List
          ? (json['data'] as List).whereType<Map>().map((item) => FetchNotificationsModelDataItem.fromJson(Map<String, dynamic>.from(item))).toList()
          : null,
      meta: json['meta'] is Map ? FetchNotificationsModelMeta.fromJson(Map<String, dynamic>.from(json['meta'])) : null,
    );
  }

  Map<String, dynamic> toJson() => {'data': data?.map((item) => item.toJson()).toList(), 'meta': meta?.toJson()};
}

class FetchNotificationsModelDataItem {
  String? id;
  String? source;
  String? category;
  String? title;
  String? body;
  String? type;
  bool? isRead;
  String? createdAt;
  Map<String, dynamic>? meta;

  FetchNotificationsModelDataItem({this.id, this.source, this.category, this.title, this.body, this.type, this.isRead, this.createdAt, this.meta});

  factory FetchNotificationsModelDataItem.fromJson(Map<String, dynamic> json) {
    return FetchNotificationsModelDataItem(
      id: _asString(json['id']),
      source: _asString(json['source']),
      category: _asString(json['category']),
      title: _asString(json['title']),
      body: _asString(json['body']),
      type: _asString(json['type']),
      isRead: _asBool(json['isRead']),
      createdAt: _asString(json['createdAt']),
      meta: json['meta'] is Map ? Map<String, dynamic>.from(_asDynamic(json['meta']) as Map) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'source': source,
        'category': category,
        'title': title,
        'body': body,
        'type': type,
        'isRead': isRead,
        'createdAt': createdAt,
        'meta': meta,
      };
  FetchNotificationsModelDataItem copyWith({
    bool? isRead,
  }) {
    return FetchNotificationsModelDataItem(
      // باقي الحقول
      isRead: isRead ?? this.isRead,
    );
  }
}

class FetchNotificationsModelMeta {
  int? page;
  int? perPage;
  int? total;
  int? lastPage;
  int? unreadTotal;
  Map<String, dynamic>? tabCounts;

  FetchNotificationsModelMeta({this.page, this.perPage, this.total, this.lastPage, this.unreadTotal, this.tabCounts});

  factory FetchNotificationsModelMeta.fromJson(Map<String, dynamic> json) {
    return FetchNotificationsModelMeta(
      page: _asInt(json['page']),
      perPage: _asInt(json['perPage']),
      total: _asInt(json['total']),
      lastPage: _asInt(json['lastPage']),
      unreadTotal: _asInt(json['unreadTotal']),
      tabCounts: json['tabCounts'] is Map ? Map<String, dynamic>.from(json['tabCounts']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'page': page, 'perPage': perPage, 'total': total, 'lastPage': lastPage, 'unreadTotal': unreadTotal, 'tabCounts': tabCounts};
}
