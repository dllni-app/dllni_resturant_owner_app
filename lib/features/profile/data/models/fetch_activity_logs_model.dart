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

Map<String, dynamic>? _asMap(dynamic value) {
  if (value is! Map) return null;
  return Map<String, dynamic>.from(_asDynamic(value) as Map);
}

FetchActivityLogsModel fetchActivityLogsModelFromJson(dynamic value) {
  if (value is String) return FetchActivityLogsModel.fromJson(json.decode(value) as Map<String, dynamic>);
  return FetchActivityLogsModel.fromJson(Map<String, dynamic>.from(value as Map));
}

String fetchActivityLogsModelToJson(FetchActivityLogsModel data) => json.encode(data.toJson());

class FetchActivityLogsModel {
  final List<ActivityLogItem> data;
  final ActivityLogLinks? links;
  final ActivityLogMeta? meta;

  const FetchActivityLogsModel({this.data = const [], this.links, this.meta});

  factory FetchActivityLogsModel.fromJson(Map<String, dynamic> json) {
    return FetchActivityLogsModel(
      data: json['data'] is List
          ? (json['data'] as List)
              .whereType<Map>()
              .map((item) => ActivityLogItem.fromJson(Map<String, dynamic>.from(item)))
              .toList()
          : const [],
      links: json['links'] is Map ? ActivityLogLinks.fromJson(Map<String, dynamic>.from(json['links'] as Map)) : null,
      meta: json['meta'] is Map ? ActivityLogMeta.fromJson(Map<String, dynamic>.from(json['meta'] as Map)) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((item) => item.toJson()).toList(),
        'links': links?.toJson(),
        'meta': meta?.toJson(),
      };
}

class ActivityLogItem {
  final int? id;
  final String? description;
  final String? event;
  final String? logName;
  final ActivityLogCauser? causer;
  final String? subjectType;
  final dynamic subjectId;
  final Map<String, dynamic>? properties;
  final String? createdAt;

  const ActivityLogItem({
    this.id,
    this.description,
    this.event,
    this.logName,
    this.causer,
    this.subjectType,
    this.subjectId,
    this.properties,
    this.createdAt,
  });

  factory ActivityLogItem.fromJson(Map<String, dynamic> json) {
    return ActivityLogItem(
      id: _asInt(json['id']),
      description: _asString(json['description']),
      event: _asString(json['event']),
      logName: _asString(json['logName'] ?? json['log_name']),
      causer: json['causer'] is Map ? ActivityLogCauser.fromJson(Map<String, dynamic>.from(json['causer'] as Map)) : null,
      subjectType: _asString(json['subjectType'] ?? json['subject_type']),
      subjectId: _asDynamic(json['subjectId'] ?? json['subject_id']),
      properties: _asMap(json['properties']),
      createdAt: _asString(json['createdAt'] ?? json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'event': event,
        'logName': logName,
        'causer': causer?.toJson(),
        'subjectType': subjectType,
        'subjectId': subjectId,
        'properties': properties,
        'createdAt': createdAt,
      };
}

class ActivityLogCauser {
  final int? id;
  final String? name;
  final String? avatarUrl;

  const ActivityLogCauser({this.id, this.name, this.avatarUrl});

  factory ActivityLogCauser.fromJson(Map<String, dynamic> json) => ActivityLogCauser(
        id: _asInt(json['id']),
        name: _asString(json['name']),
        avatarUrl: _asString(json['avatarUrl'] ?? json['avatar_url']),
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'avatarUrl': avatarUrl};
}

class ActivityLogLinks {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  const ActivityLogLinks({this.first, this.last, this.prev, this.next});

  factory ActivityLogLinks.fromJson(Map<String, dynamic> json) => ActivityLogLinks(
        first: _asString(json['first']),
        last: _asString(json['last']),
        prev: _asString(json['prev']),
        next: _asString(json['next']),
      );

  Map<String, dynamic> toJson() => {'first': first, 'last': last, 'prev': prev, 'next': next};
}

class ActivityLogMeta {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  const ActivityLogMeta({this.currentPage, this.lastPage, this.perPage, this.total});

  factory ActivityLogMeta.fromJson(Map<String, dynamic> json) => ActivityLogMeta(
        currentPage: _asInt(json['currentPage'] ?? json['current_page']),
        lastPage: _asInt(json['lastPage'] ?? json['last_page']),
        perPage: _asInt(json['perPage'] ?? json['per_page']),
        total: _asInt(json['total']),
      );

  Map<String, dynamic> toJson() => {'currentPage': currentPage, 'lastPage': lastPage, 'perPage': perPage, 'total': total};
}
