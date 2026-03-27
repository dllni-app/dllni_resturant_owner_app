import 'dart:convert';

ReadAllNotificationsModel readAllNotificationsModelFromJson(dynamic str) {
  final map = str is Map<String, dynamic> ? str : Map<String, dynamic>.from(str as Map);
  return ReadAllNotificationsModel.fromJson(map);
}

String readAllNotificationsModelToJson(ReadAllNotificationsModel data) => json.encode(data.toJson());

class ReadAllNotificationsModel {
  ReadAllNotificationsModel();

  factory ReadAllNotificationsModel.fromJson(Map<String, dynamic> json) => ReadAllNotificationsModel();

  Map<String, dynamic> toJson() => {};
}
