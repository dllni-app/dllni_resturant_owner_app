import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/create_coupon_model.dart';

@lazySingleton
class CreateCouponUseCase implements UseCase<CreateCouponModel, CreateCouponParams> {
  final ProfileRepo profile;

  CreateCouponUseCase({required this.profile});

  @override
  DataResponse<CreateCouponModel> call(CreateCouponParams params) {
    return profile.createCoupon(params);
  }
}

class CreateCouponParams with Params {
  final String? code;
  final String? discountType;
  final double? discountValue;
  final double? minOrderAmount;
  final int? usageLimit;
  final String? startsAt;
  final String? endsAt;
  final bool? isActive;

  final bool isAddNew;
  final bool isDelete;
  final int? id;

  CreateCouponParams({
    this.code,
    this.discountType,
    this.discountValue,
    this.minOrderAmount,
    this.usageLimit,
    this.startsAt,
    this.endsAt,
    this.isActive = true,
    this.isAddNew = true,
    this.isDelete = false,
    this.id,
  });

  String _formatDate(DateTime value) {
    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  @override
  BodyMap getBody() {
    if (isDelete) return {};

    final now = DateTime.now();
    final normalizedStartsAt = startsAt?.trim().isNotEmpty == true ? startsAt!.trim() : (isAddNew ? _formatDate(now) : null);
    final normalizedEndsAt = endsAt?.trim().isNotEmpty == true ? endsAt!.trim() : (isAddNew ? _formatDate(now.add(const Duration(days: 365))) : null);

    return {
      'code': code,
      'discountType': discountType,
      'discountValue': discountValue,
      'minOrderAmount': minOrderAmount,
      'usageLimit': usageLimit,
      'isActive': isActive,
      'startsAt': normalizedStartsAt,
      'endsAt': normalizedEndsAt,
    }..removeWhere((key, val) => val == null);
  }

  @override
  QueryParams getParams() => {};
}
