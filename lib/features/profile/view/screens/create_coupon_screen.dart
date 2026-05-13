import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/data/models/fetch_coupons_model.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/create_coupon_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  TextEditingController codeController = TextEditingController();
  TextEditingController couponValueController = TextEditingController();
  TextEditingController minAmountController = TextEditingController();
  TextEditingController maxUseController = TextEditingController();
  TextEditingController startsAtController = TextEditingController();
  TextEditingController endsAtController = TextEditingController();

  String couponType = 'fixed_amount';

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
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      CreateOfferStepCard(
                        number: 1,
                        title: 'كود الكوبون',
                        child: CreateCouponCodeCard(codeController: codeController),
                      ),
                      const SizedBox(height: 16),
                      CreateOfferStepCard(
                        number: 2,
                        title: 'نوع الخصم',
                        child: CreateCouponDiscountCard(
                          couponType: couponType,
                          couponTypeChanges: (value) => setState(() {
                            couponType = value;
                          }),
                          couponValueController: couponValueController,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CreateOfferStepCard(
                        number: 3,
                        title: 'الحد الأدنى لمبلغ الشراء',
                        child: CreateCouponMinAmountCard(minAmountController: minAmountController),
                      ),
                      const SizedBox(height: 16),
                      CreateOfferStepCard(
                        number: 4,
                        title: 'الحد الأقصى لعدد الاستخدامات',
                        child: CreateCouponMaxUseCard(maxUseController: maxUseController),
                      ),
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
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              BlocListener<ProfileBloc, ProfileState>(
                listener: (context, state) {},
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                  child: BlocBuilder<ProfileBloc, ProfileState>(
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
                                      final editingCoupon = widget.params?.coupon;
                                      context.read<ProfileBloc>().add(
                                        CreateCouponSubmitEvent(
                                          context: context,
                                          params: CreateCouponParams(
                                            code: codeController.text,
                                            discountType: couponType,
                                            discountValue: double.tryParse(couponValueController.text) ?? 0,
                                            minOrderAmount: double.tryParse(minAmountController.text) ?? 0,
                                            usageLimit: int.tryParse(maxUseController.text) ?? 0,
                                            startsAt: startsAtController.text.isNotEmpty ? startsAtController.text : null,
                                            endsAt: endsAtController.text.isNotEmpty ? endsAtController.text : null,
                                            isActive: true,
                                            isAddNew: editingCoupon == null,
                                            id: editingCoupon?.id,
                                          ),
                                        ),
                                      );
                                    },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: isLoading ? context.primary.withAlpha(153) : context.primary,
                                ),
                                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 16),
                                child: isLoading
                                    ? const SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator(strokeWidth: 2)))
                                    : AppText.labelLarge('حفظ وتفعيل', color: context.onPrimary, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: InkWell(
                              onTap: isLoading
                                  ? null
                                  : () {
                                      context.pop();
                                    },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: context.error.withAlpha(20),
                                  border: Border.all(color: context.error),
                                ),
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
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
    );
  }
}
