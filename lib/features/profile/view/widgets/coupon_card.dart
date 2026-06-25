import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/create_coupon_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/manager/bloc/profile_bloc.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/create_coupon_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../data/models/fetch_coupons_model.dart';

enum _CouponAction { update, toggle, delete }

class CouponCard extends StatelessWidget {
  const CouponCard({super.key, required this.coupon});

  final FetchCouponsModelDataItem coupon;

  String _formatMoney(num? value) {
    if (value == null) return '0';
    if (value % 1 == 0) return value.toInt().toString();
    return value.toStringAsFixed(2);
  }

  String _formatDate(String? value) {
    if (value == null || value.trim().isEmpty) return 'غير محدد';
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    return DateFormat('yyyy-MM-dd').format(parsed);
  }

  String _discountLabel() {
    final value = _formatMoney(coupon.discountValue);
    return coupon.discountType == 'percentage' ? '$value%' : '$value ل.س';
  }

  CreateCouponParams _updateParams({bool? isActive}) {
    return CreateCouponParams(
      id: coupon.id,
      code: coupon.code,
      discountType: coupon.discountType,
      discountValue: coupon.discountValue,
      minOrderAmount: coupon.minOrderAmount,
      usageLimit: coupon.usageLimit,
      startsAt: coupon.startsAt,
      endsAt: coupon.endsAt,
      isActive: isActive ?? coupon.isActive ?? true,
      isAddNew: false,
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: AppText.titleLarge('حذف الكوبون', fontWeight: FontWeight.bold),
        content: AppText.bodyMedium('هل أنت متأكد من حذف هذا الكوبون؟ لا يمكن التراجع عن هذه العملية.', textAlign: TextAlign.start),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: AppText.labelLarge('إلغاء')),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: AppText.labelLarge('حذف', color: context.error, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    if (shouldDelete != true || !context.mounted || coupon.id == null) return;
    context.read<ProfileBloc>().add(
          CreateCouponSubmitEvent(
            params: CreateCouponParams(isDelete: true, id: coupon.id),
            context: context,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final code = coupon.code?.trim().isNotEmpty == true ? coupon.code!.trim() : '-';
    final isActive = coupon.isActive == true;
    final usageLimit = coupon.usageLimit == null ? 'غير محدود' : coupon.usageLimit.toString();
    final minOrderAmount = coupon.minOrderAmount == null ? 'لا يوجد' : '${_formatMoney(coupon.minOrderAmount)} ل.س';
    final performance = coupon.performance;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffF3F4F6), width: 1),
        color: context.onPrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: const Offset(0, 1), blurRadius: 2)],
      ),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
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
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xff064E3B).withAlpha(25)),
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
                            child: AppText.titleMedium(code, fontWeight: FontWeight.w400, color: const Color(0xff064E3B), scrollText: true),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(text: code));
                            if (context.mounted) {
                              AppToast.showToast(context: context, message: 'تم نسخ اسم الكوبون', type: ToastificationType.info);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffF3F4F6)),
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                            child: const Icon(Icons.copy_rounded, size: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: !isActive ? context.error.withAlpha(127) : const Color(0xff10B981).withAlpha(25),
                          ),
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 9, vertical: 6),
                          child: AppText.labelLarge(
                            isActive ? 'نشط' : 'غير نشط',
                            color: !isActive ? context.onPrimary : const Color(0xff10B981),
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
                  } else if (value == _CouponAction.toggle) {
                    context.read<ProfileBloc>().add(
                          CreateCouponSubmitEvent(
                            params: _updateParams(isActive: !isActive),
                            context: context,
                          ),
                        );
                  } else {
                    _confirmDelete(context);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<_CouponAction>(
                    value: _CouponAction.update,
                    child: Row(
                      children: [
                        const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF065F46)),
                        const SizedBox(width: 8),
                        AppText.labelLarge('تعديل'),
                      ],
                    ),
                  ),
                  PopupMenuItem<_CouponAction>(
                    value: _CouponAction.toggle,
                    child: Row(
                      children: [
                        Icon(isActive ? Icons.pause_circle_outline_rounded : Icons.play_circle_outline_rounded, size: 18, color: const Color(0xFF2563EB)),
                        const SizedBox(width: 8),
                        AppText.labelLarge(isActive ? 'تعطيل الكوبون' : 'تفعيل الكوبون'),
                      ],
                    ),
                  ),
                  PopupMenuItem<_CouponAction>(
                    value: _CouponAction.delete,
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline, size: 18, color: Color(0xFFEF4444)),
                        const SizedBox(width: 8),
                        AppText.labelLarge('حذف'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xffF9FAFB)),
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              spacing: 10,
              children: [
                _InfoRow(title: 'قيمة الخصم', value: _discountLabel()),
                _InfoRow(title: 'الحد الأدنى للطلب', value: minOrderAmount),
                _InfoRow(title: 'عدد الاستخدامات', value: '${coupon.usageCount ?? 0} / $usageLimit'),
                _InfoRow(title: 'مدة العرض', value: _formatDate(coupon.endsAt)),
                const Divider(height: 8, color: Color(0xffE5E7EB)),
                _InfoRow(title: 'طلبات استخدمت الكوبون', value: '${performance?.ordersCount ?? 0}'),
                _InfoRow(title: 'إجمالي الخصومات', value: '${_formatMoney(performance?.totalSavings)} ل.س'),
                _InfoRow(title: 'أثر الإيرادات', value: '${_formatMoney(performance?.revenueImpact)} ل.س'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: AppText.labelLarge(title, color: const Color(0xff4B5563), fontWeight: FontWeight.w400, textAlign: TextAlign.start)),
        const SizedBox(width: 8),
        Flexible(child: AppText.bodyMedium(value, color: const Color(0xff064E3B), fontWeight: FontWeight.bold, textAlign: TextAlign.end, scrollText: true)),
      ],
    );
  }
}
