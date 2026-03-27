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

AcceptOrderModel acceptOrderModelFromJson(str) => AcceptOrderModel.fromJson(str);

String acceptOrderModelToJson(AcceptOrderModel data) => json.encode(data.toJson());

AcceptOrderModelData acceptOrderModelDataFromJson(str) => AcceptOrderModelData.fromJson(str);

String acceptOrderModelDataToJson(AcceptOrderModelData data) => json.encode(data.toJson());

AcceptOrderModelDataDisputesItem acceptOrderModelDataDisputesItemFromJson(str) => AcceptOrderModelDataDisputesItem.fromJson(str);

String acceptOrderModelDataDisputesItemToJson(AcceptOrderModelDataDisputesItem data) => json.encode(data.toJson());

AcceptOrderModelDataAssignedStaff acceptOrderModelDataAssignedStaffFromJson(str) => AcceptOrderModelDataAssignedStaff.fromJson(str);

String acceptOrderModelDataAssignedStaffToJson(AcceptOrderModelDataAssignedStaff data) => json.encode(data.toJson());

AcceptOrderModelDataPromoCode acceptOrderModelDataPromoCodeFromJson(str) => AcceptOrderModelDataPromoCode.fromJson(str);

String acceptOrderModelDataPromoCodeToJson(AcceptOrderModelDataPromoCode data) => json.encode(data.toJson());

AcceptOrderModelDataOrderStatusLogsItem acceptOrderModelDataOrderStatusLogsItemFromJson(str) => AcceptOrderModelDataOrderStatusLogsItem.fromJson(str);

String acceptOrderModelDataOrderStatusLogsItemToJson(AcceptOrderModelDataOrderStatusLogsItem data) => json.encode(data.toJson());

AcceptOrderModelDataRestaurant acceptOrderModelDataRestaurantFromJson(str) => AcceptOrderModelDataRestaurant.fromJson(str);

String acceptOrderModelDataRestaurantToJson(AcceptOrderModelDataRestaurant data) => json.encode(data.toJson());

AcceptOrderModelDataUser acceptOrderModelDataUserFromJson(str) => AcceptOrderModelDataUser.fromJson(str);

String acceptOrderModelDataUserToJson(AcceptOrderModelDataUser data) => json.encode(data.toJson());

class AcceptOrderModel {
  AcceptOrderModelData? data;
  String? message;

  AcceptOrderModel({this.data, this.message});

  factory AcceptOrderModel.fromJson(Map<String, dynamic> json) {
    return AcceptOrderModel(
      data: json['data'] is Map ? AcceptOrderModelData.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null,
      message: _asString(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data?.toJson(), 'message': message};
  }
}

class AcceptOrderModelData {
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
  AcceptOrderModelDataUser? user;
  AcceptOrderModelDataRestaurant? restaurant;
  String? orderItems;
  List<AcceptOrderModelDataOrderStatusLogsItem>? orderStatusLogs;
  AcceptOrderModelDataPromoCode? promoCode;
  AcceptOrderModelDataAssignedStaff? assignedStaff;
  List<AcceptOrderModelDataDisputesItem>? disputes;
  String? createdAt;
  String? updatedAt;

  AcceptOrderModelData({
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

  factory AcceptOrderModelData.fromJson(Map<String, dynamic> json) {
    return AcceptOrderModelData(
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
      user: json['user'] is Map ? AcceptOrderModelDataUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)) : null,
      restaurant: json['restaurant'] is Map ? AcceptOrderModelDataRestaurant.fromJson(Map<String, dynamic>.from(json['restaurant'] as Map)) : null,
      orderItems: _asString(json['orderItems']),
      orderStatusLogs: json['orderStatusLogs'] is List
          ? (json['orderStatusLogs'] as List)
                .whereType<Map>()
                .map((item) => AcceptOrderModelDataOrderStatusLogsItem.fromJson(Map<String, dynamic>.from(item)))
                .toList()
          : null,
      promoCode: json['promoCode'] is Map ? AcceptOrderModelDataPromoCode.fromJson(Map<String, dynamic>.from(json['promoCode'] as Map)) : null,
      assignedStaff: json['assignedStaff'] is Map
          ? AcceptOrderModelDataAssignedStaff.fromJson(Map<String, dynamic>.from(json['assignedStaff'] as Map))
          : null,
      disputes: json['disputes'] is List
          ? (json['disputes'] as List)
                .whereType<Map>()
                .map((item) => AcceptOrderModelDataDisputesItem.fromJson(Map<String, dynamic>.from(item)))
                .toList()
          : null,
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

class AcceptOrderModelDataDisputesItem {
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

  AcceptOrderModelDataDisputesItem({
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

  factory AcceptOrderModelDataDisputesItem.fromJson(Map<String, dynamic> json) {
    return AcceptOrderModelDataDisputesItem(
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

class AcceptOrderModelDataAssignedStaff {
  int? id;
  String? name;
  String? email;

  AcceptOrderModelDataAssignedStaff({this.id, this.name, this.email});

  factory AcceptOrderModelDataAssignedStaff.fromJson(Map<String, dynamic> json) {
    return AcceptOrderModelDataAssignedStaff(id: _asInt(json['id']), name: _asString(json['name']), email: _asString(json['email']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}

class AcceptOrderModelDataPromoCode {
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

  AcceptOrderModelDataPromoCode({
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

  factory AcceptOrderModelDataPromoCode.fromJson(Map<String, dynamic> json) {
    return AcceptOrderModelDataPromoCode(
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

class AcceptOrderModelDataOrderStatusLogsItem {
  int? id;
  int? orderId;
  String? fromStatus;
  String? toStatus;
  String? note;
  String? createdAt;
  String? updatedAt;

  AcceptOrderModelDataOrderStatusLogsItem({this.id, this.orderId, this.fromStatus, this.toStatus, this.note, this.createdAt, this.updatedAt});

  factory AcceptOrderModelDataOrderStatusLogsItem.fromJson(Map<String, dynamic> json) {
    return AcceptOrderModelDataOrderStatusLogsItem(
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

class AcceptOrderModelDataRestaurant {
  int? id;
  String? name;
  String? slug;

  AcceptOrderModelDataRestaurant({this.id, this.name, this.slug});

  factory AcceptOrderModelDataRestaurant.fromJson(Map<String, dynamic> json) {
    return AcceptOrderModelDataRestaurant(id: _asInt(json['id']), name: _asString(json['name']), slug: _asString(json['slug']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug};
  }
}

class AcceptOrderModelDataUser {
  int? id;
  String? name;
  String? email;

  AcceptOrderModelDataUser({this.id, this.name, this.email});

  factory AcceptOrderModelDataUser.fromJson(Map<String, dynamic> json) {
    return AcceptOrderModelDataUser(id: _asInt(json['id']), name: _asString(json['name']), email: _asString(json['email']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
