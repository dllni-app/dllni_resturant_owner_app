import 'dart:convert';

String? _s(dynamic v) => v == null
    ? null
    : v is String
    ? v
    : v is num || v is bool
    ? v.toString()
    : null;

int? _i(dynamic v) => v == null
    ? null
    : v is int
    ? v
    : v is num
    ? v.toInt()
    : v is String
    ? (int.tryParse(v) ?? double.tryParse(v)?.toInt())
    : null;

double? _d(dynamic v) => v == null
    ? null
    : v is double
    ? v
    : v is num
    ? v.toDouble()
    : v is String
    ? double.tryParse(v)
    : null;

bool? _b(dynamic v) => v is bool
    ? v
    : v is num
    ? v == 1
    : v is String
    ? (v == '1' || v.toLowerCase() == 'true')
    : null;

Map<String, dynamic> _m(dynamic v) => v is Map<String, dynamic>
    ? v
    : v is Map
    ? Map<String, dynamic>.from(v)
    : <String, dynamic>{};

OwnerOrderDetailsModel ownerOrderDetailsModelFromJson(dynamic value) =>
    OwnerOrderDetailsModel.fromJson(_m(value));

String ownerOrderDetailsModelToJson(OwnerOrderDetailsModel data) =>
    json.encode(data.toJson());

class OwnerOrderDetailsModel {
  final OwnerOrderDetailsData? data;
  final String? message;

  const OwnerOrderDetailsModel({this.data, this.message});

  factory OwnerOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OwnerOrderDetailsModel(
        data: json['data'] is Map
            ? OwnerOrderDetailsData.fromJson(_m(json['data']))
            : null,
        message: _s(json['message']),
      );

  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'message': message};
}

class OwnerOrderDetailsData {
  final int id;
  final int? userId;
  final int? userAddressId;
  final int restaurantId;
  final String? orderNumber;
  final String? status;
  final String? statusLabelAr;
  final String? orderType;
  final String? pickupMode;
  final String? pickupScheduledFor;
  final String? readyForPickupAt;
  final String? acceptedAt;
  final String? createdAt;
  final String? updatedAt;
  final int? estimatedPreparationMinutes;
  final String? specialInstructions;
  final String? kitchenNotes;
  final String? cancellationReason;
  final OwnerOrderCustomer? customer;
  final OwnerOrderAddress? customerAddress;
  final OwnerOrderDeliveryInfo? delivery;
  final List<OwnerOrderDetailsItem> items;
  final OwnerOrderAmounts amounts;
  final bool canEditItems;
  final OwnerPaymentBreakdown? paymentBreakdown;

  const OwnerOrderDetailsData({
    required this.id,
    this.userId,
    this.userAddressId,
    required this.restaurantId,
    this.orderNumber,
    this.status,
    this.statusLabelAr,
    this.orderType,
    this.pickupMode,
    this.pickupScheduledFor,
    this.readyForPickupAt,
    this.acceptedAt,
    this.createdAt,
    this.updatedAt,
    this.estimatedPreparationMinutes,
    this.specialInstructions,
    this.kitchenNotes,
    this.cancellationReason,
    this.customer,
    this.customerAddress,
    this.delivery,
    this.items = const [],
    required this.amounts,
    this.canEditItems = false,
    this.paymentBreakdown,
  });

  factory OwnerOrderDetailsData.fromJson(Map<String, dynamic> json) {
    final id = _i(json['id']);
    final restaurantId = _i(json['restaurantId']);
    if (id == null)
      throw const FormatException('Owner order details response is missing id');
    if (restaurantId == null)
      throw const FormatException(
        'Owner order details response is missing restaurantId',
      );

    final rawItems = json['items'] is List ? json['items'] : json['orderItems'];
    final amounts = _m(json['amounts']);
    final paymentBreakdown = _m(json['paymentBreakdown']);
    final addressMap = json['customerAddress'] is Map
        ? _m(json['customerAddress'])
        : json['userAddress'] is Map
        ? _m(json['userAddress'])
        : <String, dynamic>{};
    final address = addressMap.isEmpty
        ? null
        : OwnerOrderAddress.fromJson(addressMap);
    final deliveryMap = _m(json['delivery']);

    return OwnerOrderDetailsData(
      id: id,
      userId: _i(json['userId']),
      userAddressId: _i(json['userAddressId']),
      restaurantId: restaurantId,
      orderNumber: _s(json['orderNumber']),
      status: _s(json['status']),
      statusLabelAr: _s(json['statusLabelAr']),
      orderType: _s(json['orderType']),
      pickupMode: _s(json['pickupMode']),
      pickupScheduledFor: _s(json['pickupScheduledFor']),
      readyForPickupAt: _s(json['readyForPickupAt']),
      acceptedAt: _s(json['acceptedAt']),
      createdAt: _s(json['createdAt']),
      updatedAt: _s(json['updatedAt']),
      estimatedPreparationMinutes: _i(json['estimatedPreparationMinutes']),
      specialInstructions: _s(json['specialInstructions']),
      kitchenNotes: _s(json['kitchenNotes']),
      cancellationReason: _s(json['cancellationReason']),
      customer: json['customer'] is Map
          ? OwnerOrderCustomer.fromJson(_m(json['customer']))
          : json['user'] is Map
          ? OwnerOrderCustomer.fromJson(_m(json['user']))
          : null,
      customerAddress: address,
      delivery: deliveryMap.isEmpty && address == null
          ? null
          : OwnerOrderDeliveryInfo.fromJson(
              deliveryMap,
              fallbackAddress: address,
            ),
      items: rawItems is List
          ? rawItems
                .whereType<Map>()
                .map((e) => OwnerOrderDetailsItem.fromJson(_m(e)))
                .toList()
          : const [],
      amounts: OwnerOrderAmounts.fromJson(
        amounts.isEmpty
            ? {
                'subtotal': json['subtotal'],
                'discount': json['discountAmount'],
                'tax': json['taxAmount'],
                'serviceFee': json['serviceFee'],
                'total': json['totalAmount'],
              }
            : amounts,
      ),
      canEditItems: _b(json['canEditItems']) ?? false,
      paymentBreakdown: paymentBreakdown.isEmpty
          ? null
          : OwnerPaymentBreakdown.fromJson(paymentBreakdown),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'userAddressId': userAddressId,
    'restaurantId': restaurantId,
    'orderNumber': orderNumber,
    'status': status,
    'statusLabelAr': statusLabelAr,
    'items': items.map((e) => e.toJson()).toList(),
    'amounts': amounts.toJson(),
    'customer': customer?.toJson(),
    'customerAddress': customerAddress?.toJson(),
    'delivery': delivery?.toJson(),
    'canEditItems': canEditItems,
  };
}

class OwnerOrderCustomer {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;

  const OwnerOrderCustomer({this.id, this.name, this.phone, this.email});

  factory OwnerOrderCustomer.fromJson(Map<String, dynamic> json) =>
      OwnerOrderCustomer(
        id: _i(json['id']),
        name: _s(json['name']),
        phone: _s(json['phone']) ?? _s(json['mobile']),
        email: _s(json['email']),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
  };
}

class OwnerOrderAddress {
  final int? id;
  final String? label;
  final String? mobile;
  final String? city;
  final String? neighborhood;
  final String? street;
  final String? building;
  final String? floor;
  final String? directions;
  final double? latitude;
  final double? longitude;
  final String? formatted;

  const OwnerOrderAddress({
    this.id,
    this.label,
    this.mobile,
    this.city,
    this.neighborhood,
    this.street,
    this.building,
    this.floor,
    this.directions,
    this.latitude,
    this.longitude,
    this.formatted,
  });

  factory OwnerOrderAddress.fromJson(Map<String, dynamic> json) =>
      OwnerOrderAddress(
        id: _i(json['id']),
        label: _s(json['label']),
        mobile: _s(json['mobile']),
        city: _s(json['city']),
        neighborhood: _s(json['neighborhood']),
        street: _s(json['street']),
        building: _s(json['building']),
        floor: _s(json['floor']),
        directions: _s(json['directions']),
        latitude: _d(json['latitude']),
        longitude: _d(json['longitude']),
        formatted: _s(json['formatted']),
      );

  String get displayText {
    final fromServer = formatted?.trim();
    if (fromServer != null && fromServer.isNotEmpty) return fromServer;
    final parts =
        [
              city,
              neighborhood,
              street,
              building == null ? null : 'بناء $building',
              floor == null ? null : 'طابق $floor',
              directions,
            ]
            .whereType<String>()
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
    return parts.join('، ');
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'mobile': mobile,
    'city': city,
    'neighborhood': neighborhood,
    'street': street,
    'building': building,
    'floor': floor,
    'directions': directions,
    'latitude': latitude,
    'longitude': longitude,
    'formatted': formatted,
  };
}

class OwnerOrderDeliveryInfo {
  final OrderType orderType;
  final String? orderTypeLabelAr;
  final PickupMode pickupMode;
  final String? scheduledFor;
  final OwnerOrderAddress? address;
  final double? deliveryFee;
  final double? distanceKm;
  final int? estimatedDeliveryMinutes;

  const OwnerOrderDeliveryInfo({
    this.orderType= OrderType.unknown,
    this.orderTypeLabelAr,
    this.pickupMode = PickupMode.unknown,
    this.scheduledFor,
    this.address,
    this.deliveryFee,
    this.distanceKm,
    this.estimatedDeliveryMinutes,
  });

  factory OwnerOrderDeliveryInfo.fromJson(
    Map<String, dynamic> json, {
    OwnerOrderAddress? fallbackAddress,
  }) => OwnerOrderDeliveryInfo(
    orderType: OrderType.fromString(_s(json['orderType'])),
    pickupMode: PickupMode.fromString(_s(json['pickupMode'])),
    orderTypeLabelAr: _s(json['orderTypeLabelAr']),

    scheduledFor: _s(json['scheduledFor']),
    address: json['address'] is Map
        ? OwnerOrderAddress.fromJson(_m(json['address']))
        : fallbackAddress,
    deliveryFee: _d(json['deliveryFee']),
    distanceKm: _d(json['distanceKm']),
    estimatedDeliveryMinutes: _i(json['estimatedDeliveryMinutes']),
  );

  Map<String, dynamic> toJson() => {
    'orderType': orderType.toApiString(),
    'orderTypeLabelAr': orderTypeLabelAr,
    'pickupMode': pickupMode,
    'scheduledFor': scheduledFor,
    'address': address?.toJson(),
    'deliveryFee': deliveryFee,
    'distanceKm': distanceKm,
    'estimatedDeliveryMinutes': estimatedDeliveryMinutes,
  };
}


enum PickupMode {
  immediatePickup(label: 'استلام فوري'),
  scheduledPickup(label: 'استلام مجدول'),
  unknown(label: 'غير محدد');

  final String label;

  const PickupMode({required this.label});

  // دالة لتحويل النص القادم من الـ API إلى الـ Enum
  static PickupMode fromString(String? mode) {
    switch (mode) {
      case 'immediate_pickup':
        return PickupMode.immediatePickup;
      case 'scheduled_pickup':
        return PickupMode.scheduledPickup;
      default:
        return PickupMode.unknown;
    }
  }
}


enum OrderType {
  delivery(label: 'توصيل'),
  pickup(label: 'استلام'),
  dineIn(label: 'داخل المطعم'),
  unknown(label: 'غير محدد');

  final String label;
  const OrderType({required this.label});

  static OrderType fromString(String? type) {
    switch (type) {
      case 'delivery': return OrderType.delivery;
      case 'pickup': return OrderType.pickup;
      case 'dine_in': return OrderType.dineIn;
      default: return OrderType.unknown;
    }
  }

  // دالة لإعادة القيمة الأصلية التي يتوقعها الـ API
  String toApiString() {
    switch (this) {
      case OrderType.delivery: return 'delivery';
      case OrderType.pickup: return 'pickup';
      case OrderType.dineIn: return 'dine_in';
      default: return '';
    }
  }
}
class OwnerOrderDetailsItem {
  final int id;
  final int? orderId;
  final int productId;
  final String? name;
  final String? imageUrl;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final String? specialInstructions;

  const OwnerOrderDetailsItem({
    required this.id,
    this.orderId,
    required this.productId,
    this.name,
    this.imageUrl,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.specialInstructions,
  });

  factory OwnerOrderDetailsItem.fromJson(Map<String, dynamic> json) {
    final product = _m(json['product']);
    return OwnerOrderDetailsItem(
      id: _i(json['id']) ?? 0,
      orderId: _i(json['orderId']),
      productId: _i(json['productId']) ?? _i(product['id']) ?? 0,
      name: _s(json['name']) ?? _s(product['name']),
      imageUrl:
          _s(json['imageUrl']) ??
          _s(json['primaryImage']) ??
          _s(product['imageUrl']) ??
          _s(product['primaryImage']),
      quantity: _i(json['quantity']) ?? 0,
      unitPrice: _d(json['unitPrice']) ?? 0,
      totalPrice: _d(json['totalPrice']) ?? 0,
      specialInstructions: _s(json['specialInstructions']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'orderId': orderId,
    'productId': productId,
    'name': name,
    'imageUrl': imageUrl,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'totalPrice': totalPrice,
    'specialInstructions': specialInstructions,
  };
}

class OwnerOrderAmounts {
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double tax;
  final double serviceFee;
  final double total;

  const OwnerOrderAmounts({
    this.subtotal = 0,
    this.deliveryFee = 0,
    this.discount = 0,
    this.tax = 0,
    this.serviceFee = 0,
    this.total = 0,
  });

  factory OwnerOrderAmounts.fromJson(Map<String, dynamic> json) =>
      OwnerOrderAmounts(
        subtotal: _d(json['subtotal']) ?? 0,
        deliveryFee: _d(json['deliveryFee']) ?? 0,
        discount: _d(json['discount']) ?? _d(json['discountAmount']) ?? 0,
        tax: _d(json['tax']) ?? _d(json['taxAmount']) ?? 0,
        serviceFee: _d(json['serviceFee']) ?? 0,
        total: _d(json['total']) ?? _d(json['totalAmount']) ?? 0,
      );

  Map<String, dynamic> toJson() => {
    'subtotal': subtotal,
    'deliveryFee': deliveryFee,
    'discount': discount,
    'tax': tax,
    'serviceFee': serviceFee,
    'total': total,
  };
}

class OwnerPaymentBreakdown {
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double tax;
  final double discount;
  final double total;

  const OwnerPaymentBreakdown({
    this.subtotal = 0,
    this.deliveryFee = 0,
    this.serviceFee = 0,
    this.tax = 0,
    this.discount = 0,
    this.total = 0,
  });

  factory OwnerPaymentBreakdown.fromJson(Map<String, dynamic> json) =>
      OwnerPaymentBreakdown(
        subtotal: _d(json['subtotal']) ?? 0,
        deliveryFee: _d(json['deliveryFee']) ?? 0,
        serviceFee: _d(json['serviceFee']) ?? 0,
        tax: _d(json['tax']) ?? 0,
        discount: _d(json['discount']) ?? 0,
        total: _d(json['total']) ?? 0,
      );

  Map<String, dynamic> toJson() => {
    'subtotal': subtotal,
    'deliveryFee': deliveryFee,
    'serviceFee': serviceFee,
    'tax': tax,
    'discount': discount,
    'total': total,
  };
}
