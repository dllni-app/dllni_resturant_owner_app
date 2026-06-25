import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/data/models/fetch_coupons_model.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/create_coupon_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../domain/usecases/fetch_coupons_summary_use_case.dart';
import '../../domain/usecases/fetch_coupons_use_case.dart';
import '../manager/bloc/profile_bloc.dart';
import '../widgets/create_coupon_app_bar.dart';
import '../widgets/create_coupon_code_card.dart';
import '../widgets/create_coupon_discount_card.dart';
import '../widgets/create_coupon_duration_card.dart';
import '../widgets/create_coupon_max_use_card.dart';
import '../widgets/create_coupon_min_amount_card.dart';
import '../widgets/create_offer_step_card.dart';

class CreateCouponScreenParams {
  final FetchCouponsModelDataItem? coupon;

  CreateCouponScreenParams({this.coupon});
}

@AutoRoutePage(path: '/couponsmanagement/new')
class CreateCouponScreen extends StatefulWidget {
  final CreateCouponScreenParams? params;

  const CreateCouponScreen({super.key, this.params});

  @override
  State<CreateCouponScreen> createState() => _CreateCouponScreenState();
}

class _CreateCouponScreenState extends State<CreateCouponScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController couponValueController = TextEditingController();
  final TextEditingController minAmountController = TextEditingController();
  final TextEditingController maxUseController = TextEditingController();
  final TextEditingController startsAtController = TextEditingController();
  final TextEditingController endsAtController = TextEditingController();

  String couponType = 'fixed_amount';
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    final coupon = widget.params?.coupon;
    if (coupon != null) {
      codeController.text = coupon.code ?? '';
      couponValueController.text = coupon.discountValue?.toString() ?? '';
      minAmountController.text = coupon.minOrderAmount?.toString() ?? '';
      maxUseController.text = coupon.usageLimit?.toString() ?? '';
      startsAtController.text = coupon.startsAt == null ? '' : DateFormat('yyyy-MM-dd').format(DateTime.parse(coupon.startsAt!));
      endsAtController.text = coupon.endsAt == null ? '' : DateFormat('yyyy-MM-dd').format(DateTime.parse(coupon.endsAt!));
      couponType = coupon.discountType ?? 'fixed_amount';
      isActive = coupon.isActive ?? true;
    }
  }

  @override
  void dispose() {
    codeController.dispose();
    couponValueController.dispose();
    minAmountController.dispose();
    maxUseController.dispose();
    startsAtController.dispose();
    endsAtController.dispose();
    super.dispose();
  }

  DateTime? _parseDate(String value) {
    if (value.trim().isEmpty) return null;
    return DateTime.tryParse(value.trim());
  }

  bool _validate(BuildContext context) {
    final code = codeController.text.trim();
    final value = double.tryParse(couponValueController.text.trim());
    final minAmountText = minAmountController.text.trim();
    final maxUseText = maxUseController.text.trim();
    final startsAt = _parseDate(startsAtController.text);
    final endsAt = _parseDate(endsAtController.text);
    final editingCoupon = widget.params?.coupon;

    if (code.isEmpty) {
      AppToast.showToast(context: context, message: 'أدخل كود الكوبون', type: ToastificationType.error);
      return false;
    }
    if (value == null || value <= 0) {
      AppToast.showToast(context: context, message: 'أدخل قيمة خصم صحيحة', type: ToastificationType.error);
      return false;
    }
    if (couponType == 'percentage' && (value <= 0 || value >= 100)) {
      AppToast.showToast(context: context, message: 'نسبة الخصم يجب أن تكون بين 1 و 99%', type: ToastificationType.error);
      return false;
    }
    if (minAmountText.isNotEmpty) {
      final minAmount = double.tryParse(minAmountText);
      if (minAmount == null || minAmount < 0) {
        AppToast.showToast(context: context, message: 'أدخل الحد الأدنى للطلب بشكل صحيح', type: ToastificationType.error);
        return false;
      }
    }
    if (maxUseText.isNotEmpty) {
      final maxUse = int.tryParse(maxUseText);
      final usedCount = editingCoupon?.usageCount ?? 0;
      if (maxUse == null || maxUse < 0) {
        AppToast.showToast(context: context, message: 'أدخل حد استخدام صحيح', type: ToastificationType.error);
        return false;
      }
      if (editingCoupon != null && maxUse < usedCount) {
        AppToast.showToast(context: context, message: 'حد الاستخدام لا يمكن أن يكون أقل من عدد الاستخدامات الحالي', type: ToastificationType.error);
        return false;
      }
    }
    if (startsAtController.text.trim().isNotEmpty && startsAt == null) {
      AppToast.showToast(context: context, message: 'تاريخ البداية غير صحيح', type: ToastificationType.error);
      return false;
    }
    if (endsAtController.text.trim().isNotEmpty && endsAt == null) {
      AppToast.showToast(context: context, message: 'تاريخ النهاية غير صحيح', type: ToastificationType.error);
      return false;
    }
    if (startsAt != null && endsAt != null && endsAt.isBefore(startsAt)) {
      AppToast.showToast(context: context, message: 'تاريخ النهاية يجب أن يكون بعد تاريخ البداية أو مساوياً له', type: ToastificationType.error);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final editingCoupon = widget.params?.coupon;
    final isEditing = editingCoupon != null;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CreateCouponAppBar(),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CreateOfferStepCard(number: 1, title: 'كود الكوبون', child: CreateCouponCodeCard(codeController: codeController)),
                    const SizedBox(height: 16),
                    CreateOfferStepCard(
                      number: 2,
                      title: 'نوع الخصم',
                      child: CreateCouponDiscountCard(
                        couponType: couponType,
                        couponTypeChanges: (value) => setState(() => couponType = value),
                        couponValueController: couponValueController,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CreateOfferStepCard(number: 3, title: 'الحد الأدنى لمبلغ الشراء', child: CreateCouponMinAmountCard(minAmountController: minAmountController)),
                    const SizedBox(height: 16),
                    CreateOfferStepCard(number: 4, title: 'الحد الأقصى لعدد الاستخدامات', child: CreateCouponMaxUseCard(maxUseController: maxUseController)),
                    const SizedBox(height: 16),
                    CreateOfferStepCard(
                      number: 5,
                      title: 'مدة الكوبون',
                      trailing: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xFFF3F4F6)),
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 4),
                        child: AppText.labelLarge('اختياري', color: const Color(0xFF6B7280), fontWeight: FontWeight.w700),
                      ),
                      child: CreateCouponDurationCard(startsAtController: startsAtController, endsAtController: endsAtController),
                    ),
                    const SizedBox(height: 16),
                    CreateOfferStepCard(
                      number: 6,
                      title: 'حالة الكوبون',
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(color: const Color(0xffF9FAFB), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xffE5E7EB))),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsetsDirectional.all(10),
                              decoration: BoxDecoration(color: isActive ? const Color(0xff10B981).withAlpha(25) : context.error.withAlpha(20), borderRadius: BorderRadius.circular(12)),
                              child: Icon(isActive ? Icons.check_circle_outline_rounded : Icons.pause_circle_outline_rounded, color: isActive ? const Color(0xff10B981) : context.error),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.bodyMedium('تفعيل الكوبون', fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                                  const SizedBox(height: 4),
                                  AppText.labelMedium('عند تعطيله لن يستطيع العملاء استخدامه.', color: const Color(0xff6B7280), textAlign: TextAlign.start),
                                ],
                              ),
                            ),
                            Switch.adaptive(value: isActive, onChanged: (value) => setState(() => isActive = value)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state.createCouponStatus == BlocStatus.success) {
                    context.pop();
                    context.read<ProfileBloc>().add(FetchCouponsEvent(params: FetchCouponsParams(status: 'all'), isReload: true));
                    context.read<ProfileBloc>().add(FetchCouponsSummaryEvent(params: FetchCouponsSummaryParams()));
                  }
                },
                listenWhen: (pre, cur) => pre.createCouponStatus != cur.createCouponStatus,
                builder: (context, state) {
                  final isLoading = state.createCouponStatus == BlocStatus.loading;
                  return Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          onTap: isLoading
                              ? null
                              : () {
                                  if (!_validate(context)) return;
                                  context.read<ProfileBloc>().add(
                                        CreateCouponSubmitEvent(
                                          context: context,
                                          params: CreateCouponParams(
                                            code: codeController.text.trim().toUpperCase(),
                                            discountType: couponType,
                                            discountValue: double.parse(couponValueController.text.trim()),
                                            minOrderAmount: double.tryParse(minAmountController.text.trim()),
                                            usageLimit: int.tryParse(maxUseController.text.trim()),
                                            startsAt: startsAtController.text.trim().isNotEmpty ? startsAtController.text.trim() : null,
                                            endsAt: endsAtController.text.trim().isNotEmpty ? endsAtController.text.trim() : null,
                                            isActive: isActive,
                                            isAddNew: !isEditing,
                                            id: editingCoupon?.id,
                                          ),
                                        ),
                                      );
                                },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: isLoading ? context.primary.withAlpha(153) : context.primary),
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 16),
                            child: isLoading
                                ? const SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator(strokeWidth: 2)))
                                : AppText.labelLarge(isEditing ? 'حفظ التعديلات' : 'إنشاء الكوبون', color: context.onPrimary, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: InkWell(
                          onTap: isLoading ? null : () => context.pop(),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.error.withAlpha(20), border: Border.all(color: context.error)),
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 16),
                            child: AppText.labelLarge('إلغاء', color: context.error, fontWeight: FontWeight.w500, textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
