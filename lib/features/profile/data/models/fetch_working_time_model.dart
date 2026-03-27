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

FetchWorkingTimeModel fetchWorkingTimeModelFromJson(str) => FetchWorkingTimeModel.fromJson(str);

String fetchWorkingTimeModelToJson(FetchWorkingTimeModel data) => json.encode(data.toJson());

FetchWorkingTimeData fetchWorkingTimeDataFromJson(str) => FetchWorkingTimeData.fromJson(str);

String fetchWorkingTimeDataToJson(FetchWorkingTimeData data) => json.encode(data.toJson());

FetchWorkingTimeDay fetchWorkingTimeDayFromJson(str) => FetchWorkingTimeDay.fromJson(str);

String fetchWorkingTimeDayToJson(FetchWorkingTimeData data) => json.encode(data.toJson());

class FetchWorkingTimeModel {
  FetchWorkingTimeData? data;

  FetchWorkingTimeModel({this.data});

  factory FetchWorkingTimeModel.fromJson(Map<String, dynamic> json) {
    return FetchWorkingTimeModel(data: json['data'] != null ? FetchWorkingTimeData.fromJson(Map<String, dynamic>.from(json['data'])) : null);
  }

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class FetchWorkingTimeData {
  bool? isTemporarilyClosed;
  List<FetchWorkingTimeDay>? dailyHours;

  FetchWorkingTimeData({this.isTemporarilyClosed, this.dailyHours});

  factory FetchWorkingTimeData.fromJson(Map<String, dynamic> json) {
    return FetchWorkingTimeData(
      isTemporarilyClosed: _asBool(json['isTemporarilyClosed']),
      dailyHours: json['dailyHours'] is List
          ? (json['dailyHours'] as List).map((e) => FetchWorkingTimeDay.fromJson(Map<String, dynamic>.from(e))).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {"isTemporarilyClosed": isTemporarilyClosed, "dailyHours": dailyHours?.map((e) => e.toJson()).toList()};
}

class FetchWorkingTimeDay {
  String? dayOfWeek;
  bool? isEnabled;
  List<FetchWorkingTimeSlot>? timeSlots;

  FetchWorkingTimeDay({this.dayOfWeek, this.isEnabled, this.timeSlots});

  factory FetchWorkingTimeDay.fromJson(Map<String, dynamic> json) {
    return FetchWorkingTimeDay(
      dayOfWeek: _asString(json['dayOfWeek']),
      isEnabled: _asBool(json['isEnabled']),
      timeSlots: json['timeSlots'] is List
          ? (json['timeSlots'] as List).map((e) => FetchWorkingTimeSlot.fromJson(Map<String, dynamic>.from(e))).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {"dayOfWeek": dayOfWeek, "isEnabled": isEnabled, "timeSlots": timeSlots?.map((e) => e.toJson()).toList()};
}

class FetchWorkingTimeSlot {
  String? startTime;
  String? endTime;

  FetchWorkingTimeSlot({this.startTime, this.endTime});

  factory FetchWorkingTimeSlot.fromJson(Map<String, dynamic> json) {
    return FetchWorkingTimeSlot(startTime: _asString(json['startTime']), endTime: _asString(json['endTime']));
  }

  Map<String, dynamic> toJson() => {"startTime": startTime, "endTime": endTime};
}
