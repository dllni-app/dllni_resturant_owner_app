import 'package:clipboard/clipboard.dart';
import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/create_coupon_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/manager/bloc/profile_bloc.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/create_coupon_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../data/models/fetch_coupons_model.dart';

enum _CouponAction { update, delete }

class CouponCard extends StatelessWidget {
  const CouponCard({super.key, required this.coupon});

  final FetchCouponsModelDataItem coupon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffF3F4F6), width: 1),
        color: context.onPrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: Offset(0, 1), blurRadius: 2)],
      ),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xff064E3B).withAlpha(25)),
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
                          child: AppText.titleMedium(coupon.code!, fontWeight: FontWeight.w400, color: Color(0xff064E3B)),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () async {
                            await FlutterClipboard.copy(coupon.code!);
                            if (context.mounted) {
                              AppToast.showToast(context: context, message: 'تم نسخ اسم الكوبون', type: ToastificationType.info);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xffF3F4F6)),
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                            child: Icon(Icons.copy_rounded, size: 20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: coupon.isActive != true ? context.error.withAlpha(127) : Color(0xff10B981).withAlpha(25),
                          ),
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 9, vertical: 6),
                          child: Row(
                            children: [
                              AppText.labelLarge(
                                coupon.isActive == true ? 'نشط' : 'غير نشط',
                                color: coupon.isActive != true ? context.onPrimary : Color(0xff10B981),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<_CouponAction>(
                icon: const Icon(Icons.more_vert, color: Color(0xFF6B7280)),
                onSelected: (value) {
                  if (value == _CouponAction.update) {
                    context.pushRoute('/couponsmanagement/new', arguments: CreateCouponScreenParams(coupon: coupon));
                  } else {
                    context.read<ProfileBloc>().add(
                      CreateCouponSubmitEvent(
                        params: CreateCouponParams(isDelete: true, id: coupon.id!),
                        context: context,
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<_CouponAction>(
                    value: _CouponAction.update,
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 18, color: Color(0xFF065F46)),
                        SizedBox(width: 8),
                        AppText.labelLarge('تعديل'),
                      ],
                    ),
                  ),
                  PopupMenuItem<_CouponAction>(
                    value: _CouponAction.delete,
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 18, color: Color(0xFFEF4444)),
                        SizedBox(width: 8),
                        AppText.labelLarge('حذف'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Color(0xffF9FAFB)),
            padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.labelLarge('قيمة الخصم', color: Color(0xff4B5563), fontWeight: FontWeight.w400),
                    AppText.bodyMedium(
                      '${coupon.discountValue} ${coupon.discountType == 'percentage' ? '%' : 'ل.س'}',
                      color: Color(0xff064E3B),
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.labelLarge('الحد الأدنى للطلب', color: Color(0xff4B5563), fontWeight: FontWeight.w400),
                    AppText.bodyMedium('${coupon.minOrderAmount}', color: Color(0xff064E3B), fontWeight: FontWeight.bold),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.labelLarge('عدد الاستخدامات', color: Color(0xff4B5563), fontWeight: FontWeight.w400),
                    AppText.bodyMedium('${coupon.usageCount} / ${coupon.usageLimit}', color: Color(0xff064E3B), fontWeight: FontWeight.bold),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.labelLarge('مدة العرض', color: Color(0xff4B5563), fontWeight: FontWeight.w400),
                    AppText.bodyMedium(
                      DateFormat('yyyy-MM-dd').format(DateTime.parse(coupon.endsAt!)),
                      color: Color(0xff064E3B),
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
