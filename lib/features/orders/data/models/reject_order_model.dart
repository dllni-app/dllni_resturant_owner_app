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

RejectOrderModel rejectOrderModelFromJson(str) => RejectOrderModel.fromJson(str);

String rejectOrderModelToJson(RejectOrderModel data) => json.encode(data.toJson());


RejectOrderModelData rejectOrderModelDataFromJson(str) => RejectOrderModelData.fromJson(str);

String rejectOrderModelDataToJson(RejectOrderModelData data) => json.encode(data.toJson());


RejectOrderModelDataDisputesItem rejectOrderModelDataDisputesItemFromJson(str) => RejectOrderModelDataDisputesItem.fromJson(str);

String rejectOrderModelDataDisputesItemToJson(RejectOrderModelDataDisputesItem data) => json.encode(data.toJson());


RejectOrderModelDataAssignedStaff rejectOrderModelDataAssignedStaffFromJson(str) => RejectOrderModelDataAssignedStaff.fromJson(str);

String rejectOrderModelDataAssignedStaffToJson(RejectOrderModelDataAssignedStaff data) => json.encode(data.toJson());


RejectOrderModelDataPromoCode rejectOrderModelDataPromoCodeFromJson(str) => RejectOrderModelDataPromoCode.fromJson(str);

String rejectOrderModelDataPromoCodeToJson(RejectOrderModelDataPromoCode data) => json.encode(data.toJson());


RejectOrderModelDataOrderStatusLogsItem rejectOrderModelDataOrderStatusLogsItemFromJson(str) => RejectOrderModelDataOrderStatusLogsItem.fromJson(str);

String rejectOrderModelDataOrderStatusLogsItemToJson(RejectOrderModelDataOrderStatusLogsItem data) => json.encode(data.toJson());


RejectOrderModelDataRestaurant rejectOrderModelDataRestaurantFromJson(str) => RejectOrderModelDataRestaurant.fromJson(str);

String rejectOrderModelDataRestaurantToJson(RejectOrderModelDataRestaurant data) => json.encode(data.toJson());


RejectOrderModelDataUser rejectOrderModelDataUserFromJson(str) => RejectOrderModelDataUser.fromJson(str);

String rejectOrderModelDataUserToJson(RejectOrderModelDataUser data) => json.encode(data.toJson());


class RejectOrderModel {
  RejectOrderModelData? data;
  String? message;

  RejectOrderModel({
    this.data,
    this.message,
  });

  factory RejectOrderModel.fromJson(Map<String, dynamic> json) {
    return RejectOrderModel(
      data: json['data'] is Map ? RejectOrderModelData.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
      message: _asString(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class RejectOrderModelData {
  int? id;
  int? userId;
  int? restaurantId;
  int? promoCodeId;
  int? assignedStaffId;
  int? cancellationPolicyId;
  String? orderNumber;
  String? status;
  String? statusLabelAr;
  String? orderType;
  String? pickupMode;
  String? pickupScheduledFor;
  String? readyForPickupAt;
  String? pickedUpAt;
  String? customerPickupConfirmedAt;
  int? subtotal;
  int? discountAmount;
  int? taxAmount;
  int? serviceFee;
  int? totalAmount;
  int? cancellationFeeAmount;
  List<dynamic>? cancellationPolicySnapshot;
  String? specialInstructions;
  String? acceptedAt;
  int? estimatedPreparationMinutes;
  String? kitchenNotes;
  String? preparingAt;
  String? completedAt;
  String? cancelledAt;
  String? cancellationReason;
  String? cancellationReasonCode;
  RejectOrderModelDataUser? user;
  RejectOrderModelDataRestaurant? restaurant;
  String? orderItems;
  List<RejectOrderModelDataOrderStatusLogsItem>? orderStatusLogs;
  RejectOrderModelDataPromoCode? promoCode;
  RejectOrderModelDataAssignedStaff? assignedStaff;
  List<RejectOrderModelDataDisputesItem>? disputes;
  String? createdAt;
  String? updatedAt;

  RejectOrderModelData({
    this.id,
    this.userId,
    this.restaurantId,
    this.promoCodeId,
    this.assignedStaffId,
    this.cancellationPolicyId,
    this.orderNumber,
    this.status,
    this.statusLabelAr,
    this.orderType,
    this.pickupMode,
    this.pickupScheduledFor,
    this.readyForPickupAt,
    this.pickedUpAt,
    this.customerPickupConfirmedAt,
    this.subtotal,
    this.discountAmount,
    this.taxAmount,
    this.serviceFee,
    this.totalAmount,
    this.cancellationFeeAmount,
    this.cancellationPolicySnapshot,
    this.specialInstructions,
    this.acceptedAt,
    this.estimatedPreparationMinutes,
    this.kitchenNotes,
    this.preparingAt,
    this.completedAt,
    this.cancelledAt,
    this.cancellationReason,
    this.cancellationReasonCode,
    this.user,
    this.restaurant,
    this.orderItems,
    this.orderStatusLogs,
    this.promoCode,
    this.assignedStaff,
    this.disputes,
    this.createdAt,
    this.updatedAt,
  });

  factory RejectOrderModelData.fromJson(Map<String, dynamic> json) {
    return RejectOrderModelData(
      id: _asInt(json['id']),
      userId: _asInt(json['userId']),
      restaurantId: _asInt(json['restaurantId']),
      promoCodeId: _asInt(json['promoCodeId']),
      assignedStaffId: _asInt(json['assignedStaffId']),
      cancellationPolicyId: _asInt(json['cancellationPolicyId']),
      orderNumber: _asString(json['orderNumber']),
      status: _asString(json['status']),
      statusLabelAr: _asString(json['statusLabelAr']),
      orderType: _asString(json['orderType']),
      pickupMode: _asString(json['pickupMode']),
      pickupScheduledFor: _asString(json['pickupScheduledFor']),
      readyForPickupAt: _asString(json['readyForPickupAt']),
      pickedUpAt: _asString(json['pickedUpAt']),
      customerPickupConfirmedAt: _asString(json['customerPickupConfirmedAt']),
      subtotal: _asInt(json['subtotal']),
      discountAmount: _asInt(json['discountAmount']),
      taxAmount: _asInt(json['taxAmount']),
      serviceFee: _asInt(json['serviceFee']),
      totalAmount: _asInt(json['totalAmount']),
      cancellationFeeAmount: _asInt(json['cancellationFeeAmount']),
      cancellationPolicySnapshot: _asDynamicList(json['cancellationPolicySnapshot']),
      specialInstructions: _asString(json['specialInstructions']),
      acceptedAt: _asString(json['acceptedAt']),
      estimatedPreparationMinutes: _asInt(json['estimatedPreparationMinutes']),
      kitchenNotes: _asString(json['kitchenNotes']),
      preparingAt: _asString(json['preparingAt']),
      completedAt: _asString(json['completedAt']),
      cancelledAt: _asString(json['cancelledAt']),
      cancellationReason: _asString(json['cancellationReason']),
      cancellationReasonCode: _asString(json['cancellationReasonCode']),
      user: json['user'] is Map ? RejectOrderModelDataUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)) : null,
      restaurant: json['restaurant'] is Map ? RejectOrderModelDataRestaurant.fromJson(Map<String, dynamic>.from(json['restaurant'] as Map)) : null,
      orderItems: _asString(json['orderItems']),
      orderStatusLogs: json['orderStatusLogs'] is List ? (json['orderStatusLogs'] as List).whereType<Map>().map((item) => RejectOrderModelDataOrderStatusLogsItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      promoCode: json['promoCode'] is Map ? RejectOrderModelDataPromoCode.fromJson(Map<String, dynamic>.from(json['promoCode'] as Map)) : null,
      assignedStaff: json['assignedStaff'] is Map ? RejectOrderModelDataAssignedStaff.fromJson(Map<String, dynamic>.from(json['assignedStaff'] as Map)) : null,
      disputes: json['disputes'] is List ? (json['disputes'] as List).whereType<Map>().map((item) => RejectOrderModelDataDisputesItem.fromJson(Map<String, dynamic>.from(item))).toList() : null,
      createdAt: _asString(json['createdAt']),
      updatedAt: _asString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'promoCodeId': promoCodeId,
      'assignedStaffId': assignedStaffId,
      'cancellationPolicyId': cancellationPolicyId,
      'orderNumber': orderNumber,
      'status': status,
      'statusLabelAr': statusLabelAr,
      'orderType': orderType,
      'pickupMode': pickupMode,
      'pickupScheduledFor': pickupScheduledFor,
      'readyForPickupAt': readyForPickupAt,
      'pickedUpAt': pickedUpAt,
      'customerPickupConfirmedAt': customerPickupConfirmedAt,
      'subtotal': subtotal,
      'discountAmount': discountAmount,
      'taxAmount': taxAmount,
      'serviceFee': serviceFee,
      'totalAmount': totalAmount,
      'cancellationFeeAmount': cancellationFeeAmount,
      'cancellationPolicySnapshot': cancellationPolicySnapshot,
      'specialInstructions': specialInstructions,
      'acceptedAt': acceptedAt,
      'estimatedPreparationMinutes': estimatedPreparationMinutes,
      'kitchenNotes': kitchenNotes,
      'preparingAt': preparingAt,
      'completedAt': completedAt,
      'cancelledAt': cancelledAt,
      'cancellationReason': cancellationReason,
      'cancellationReasonCode': cancellationReasonCode,
      'user': user?.toJson(),
      'restaurant': restaurant?.toJson(),
      'orderItems': orderItems,
      'orderStatusLogs': orderStatusLogs?.map((item) => item.toJson()).toList(),
      'promoCode': promoCode?.toJson(),
      'assignedStaff': assignedStaff?.toJson(),
      'disputes': disputes?.map((item) => item.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class RejectOrderModelDataDisputesItem {
  int? id;
  int? orderId;
  int? userId;
  String? ticketNumber;
  String? status;
  String? resolutionType;
  String? refundAmount;
  String? deductionAmount;
  String? payoutHoldStatus;
  String? description;
  int? resolvedByUserId;
  String? resolvedAt;
  String? adminNote;
  String? createdAt;
  String? updatedAt;

  RejectOrderModelDataDisputesItem({
    this.id,
    this.orderId,
    this.userId,
    this.ticketNumber,
    this.status,
    this.resolutionType,
    this.refundAmount,
    this.deductionAmount,
    this.payoutHoldStatus,
    this.description,
    this.resolvedByUserId,
    this.resolvedAt,
    this.adminNote,
    this.createdAt,
    this.updatedAt,
  });

  factory RejectOrderModelDataDisputesItem.fromJson(Map<String, dynamic> json) {
    return RejectOrderModelDataDisputesItem(
      id: _asInt(json['id']),
      orderId: _asInt(json['order_id']),
      userId: _asInt(json['user_id']),
      ticketNumber: _asString(json['ticket_number']),
      status: _asString(json['status']),
      resolutionType: _asString(json['resolution_type']),
      refundAmount: _asString(json['refund_amount']),
      deductionAmount: _asString(json['deduction_amount']),
      payoutHoldStatus: _asString(json['payout_hold_status']),
      description: _asString(json['description']),
      resolvedByUserId: _asInt(json['resolved_by_user_id']),
      resolvedAt: _asString(json['resolved_at']),
      adminNote: _asString(json['admin_note']),
      createdAt: _asString(json['created_at']),
      updatedAt: _asString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'user_id': userId,
      'ticket_number': ticketNumber,
      'status': status,
      'resolution_type': resolutionType,
      'refund_amount': refundAmount,
      'deduction_amount': deductionAmount,
      'payout_hold_status': payoutHoldStatus,
      'description': description,
      'resolved_by_user_id': resolvedByUserId,
      'resolved_at': resolvedAt,
      'admin_note': adminNote,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class RejectOrderModelDataAssignedStaff {
  int? id;
  String? name;
  String? email;

  RejectOrderModelDataAssignedStaff({
    this.id,
    this.name,
    this.email,
  });

  factory RejectOrderModelDataAssignedStaff.fromJson(Map<String, dynamic> json) {
    return RejectOrderModelDataAssignedStaff(
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

class RejectOrderModelDataPromoCode {
  int? id;
  int? restaurantId;
  String? code;
  String? discountType;
  String? discountValue;
  String? minOrderAmount;
  int? usageLimit;
  int? usageCount;
  String? startsAt;
  String? endsAt;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  RejectOrderModelDataPromoCode({
    this.id,
    this.restaurantId,
    this.code,
    this.discountType,
    this.discountValue,
    this.minOrderAmount,
    this.usageLimit,
    this.usageCount,
    this.startsAt,
    this.endsAt,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory RejectOrderModelDataPromoCode.fromJson(Map<String, dynamic> json) {
    return RejectOrderModelDataPromoCode(
      id: _asInt(json['id']),
      restaurantId: _asInt(json['restaurant_id']),
      code: _asString(json['code']),
      discountType: _asString(json['discount_type']),
      discountValue: _asString(json['discount_value']),
      minOrderAmount: _asString(json['min_order_amount']),
      usageLimit: _asInt(json['usage_limit']),
      usageCount: _asInt(json['usage_count']),
      startsAt: _asString(json['starts_at']),
      endsAt: _asString(json['ends_at']),
      isActive: _asBool(json['is_active']),
      createdAt: _asString(json['created_at']),
      updatedAt: _asString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'code': code,
      'discount_type': discountType,
      'discount_value': discountValue,
      'min_order_amount': minOrderAmount,
      'usage_limit': usageLimit,
      'usage_count': usageCount,
      'starts_at': startsAt,
      'ends_at': endsAt,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class RejectOrderModelDataOrderStatusLogsItem {
  int? id;
  int? orderId;
  String? fromStatus;
  String? toStatus;
  String? note;
  String? createdAt;
  String? updatedAt;

  RejectOrderModelDataOrderStatusLogsItem({
    this.id,
    this.orderId,
    this.fromStatus,
    this.toStatus,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory RejectOrderModelDataOrderStatusLogsItem.fromJson(Map<String, dynamic> json) {
    return RejectOrderModelDataOrderStatusLogsItem(
      id: _asInt(json['id']),
      orderId: _asInt(json['order_id']),
      fromStatus: _asString(json['from_status']),
      toStatus: _asString(json['to_status']),
      note: _asString(json['note']),
      createdAt: _asString(json['created_at']),
      updatedAt: _asString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'from_status': fromStatus,
      'to_status': toStatus,
      'note': note,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class RejectOrderModelDataRestaurant {
  int? id;
  String? name;
  String? slug;

  RejectOrderModelDataRestaurant({
    this.id,
    this.name,
    this.slug,
  });

  factory RejectOrderModelDataRestaurant.fromJson(Map<String, dynamic> json) {
    return RejectOrderModelDataRestaurant(
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

class RejectOrderModelDataUser {
  int? id;
  String? name;
  String? email;

  RejectOrderModelDataUser({
    this.id,
    this.name,
    this.email,
  });

  factory RejectOrderModelDataUser.fromJson(Map<String, dynamic> json) {
    return RejectOrderModelDataUser(
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