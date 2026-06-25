import 'dart:convert';

String? _s(dynamic v) => v == null ? null : v is String ? v : v is num || v is bool ? v.toString() : null;
int? _i(dynamic v) => v == null ? null : v is int ? v : v is num ? v.toInt() : v is String ? (int.tryParse(v) ?? double.tryParse(v)?.toInt()) : null;

OrderActionResultModel orderActionResultModelFromJson(dynamic value) => OrderActionResultModel.fromJson(Map<String, dynamic>.from(value as Map));
String orderActionResultModelToJson(OrderActionResultModel data) => json.encode(data.toJson());

class OrderActionResultModel {
  final OrderActionResult? data;
  final String? message;
  const OrderActionResultModel({this.data, this.message});
  factory OrderActionResultModel.fromJson(Map<String, dynamic> json) => OrderActionResultModel(
    data: json['data'] is Map ? OrderActionResult.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
    message: _s(json['message']),
  );
  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'message': message};
}

class OrderActionResult {
  final int? id;
  final int? restaurantId;
  final String? status;
  final String? acceptedAt;
  final String? cancelledAt;
  final int? estimatedPreparationMinutes;
  final String? kitchenNotes;
  final String? cancellationReason;
  const OrderActionResult({this.id, this.restaurantId, this.status, this.acceptedAt, this.cancelledAt, this.estimatedPreparationMinutes, this.kitchenNotes, this.cancellationReason});
  factory OrderActionResult.fromJson(Map<String, dynamic> json) => OrderActionResult(
    id: _i(json['id']),
    restaurantId: _i(json['restaurantId']),
    status: _s(json['status']),
    acceptedAt: _s(json['acceptedAt']),
    cancelledAt: _s(json['cancelledAt']),
    estimatedPreparationMinutes: _i(json['estimatedPreparationMinutes']),
    kitchenNotes: _s(json['kitchenNotes']),
    cancellationReason: _s(json['cancellationReason']),
  );
  Map<String, dynamic> toJson() => {'id': id, 'restaurantId': restaurantId, 'status': status, 'acceptedAt': acceptedAt, 'cancelledAt': cancelledAt, 'estimatedPreparationMinutes': estimatedPreparationMinutes, 'kitchenNotes': kitchenNotes, 'cancellationReason': cancellationReason};
}
