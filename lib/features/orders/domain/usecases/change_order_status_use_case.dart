import 'package:common_package/helpers/typedef.dart';

class ChangeOrderStatusParams with Params {
  final int orderId;
  final String status;
  final String? reason;
  final String? note;

  ChangeOrderStatusParams({required this.orderId, required this.status, this.reason, this.note});

  @override
  BodyMap getBody() {
    final body = <String, dynamic>{
      'status': status,
      'reason': reason,
      'customerMessage': note,
    };
    body.removeWhere((key, value) => value == null || (value is String && value.trim().isEmpty));
    return body;
  }
}
