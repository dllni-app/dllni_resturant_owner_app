import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/data/models/fetch_offers_model.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/create_offer_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../manager/bloc/profile_bloc.dart';
import '../widgets/create_offer_app_bar.dart';
import '../widgets/create_offer_basic_info_card.dart';
import '../widgets/create_offer_discount_card.dart';
import '../widgets/create_offer_duration_card.dart';
import '../widgets/create_offer_products_section.dart';
import '../widgets/create_offer_selected_products_card.dart';
import '../widgets/create_offer_step_card.dart';

class CreateOfferScreenParams {
  final FetchOffersModelDataItem? offer;

  CreateOfferScreenParams({this.offer});
}

@AutoRoutePage(path: '/offersmanagement/new')
class CreateOfferScreen extends StatefulWidget {
  final CreateOfferScreenParams? params;

  const CreateOfferScreen({super.key, this.params});

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController offerValueController = TextEditingController();
  TextEditingController startsAtController = TextEditingController();
  TextEditingController endsAtController = TextEditingController();

  bool isImmediate = false;
  String offerType = 'fixed_amount';

  @override
  void initState() {
    super.initState();
    final offer = widget.params?.offer;
    if (offer != null) {
      nameController.text = offer.name ?? '';
      offerValueController.text = offer.discountValue?.toString() ?? '';
      startsAtController.text = offer.startsAt == null ? '' : DateTime.parse(offer.startsAt!).toUtc().toIso8601String();
      endsAtController.text = offer.endsAt == null ? '' : DateTime.parse(offer.endsAt!).toUtc().toIso8601String();
      offerType = offer.discountType ?? 'fixed_amount';
      isImmediate = offer.isActive ?? false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    offerValueController.dispose();
    startsAtController.dispose();
    endsAtController.dispose();
    super.dispose();
  }

  bool _validate(BuildContext context) {
    if (nameController.text.trim().isEmpty) {
      AppToast.showToast(context: context, message: 'أدخل اسم العرض', type: ToastificationType.error);
      return false;
    }
    final discountValue = double.tryParse(offerValueController.text.trim());
    if (discountValue == null || discountValue < 0) {
      AppToast.showToast(context: context, message: 'أدخل قيمة خصم صحيحة', type: ToastificationType.error);
      return false;
    }
    if (offerType == 'percentage' && discountValue > 100) {
      AppToast.showToast(context: context, message: 'نسبة الخصم يجب أن تكون بين 0 و 100%', type: ToastificationType.error);
      return false;
    }
    if (!isImmediate && startsAtController.text.trim().isEmpty) {
      AppToast.showToast(context: context, message: 'اختر تاريخ ووقت بداية العرض', type: ToastificationType.error);
      return false;
    }
    if (endsAtController.text.trim().isEmpty) {
      AppToast.showToast(context: context, message: 'اختر تاريخ ووقت نهاية العرض', type: ToastificationType.error);
      return false;
    }

    final start = DateTime.tryParse(startsAtController.text.trim());
    final end = DateTime.tryParse(endsAtController.text.trim());
    if (start == null || end == null) {
      AppToast.showToast(context: context, message: 'تاريخ أو وقت العرض غير صالح', type: ToastificationType.error);
      return false;
    }
    if (!end.isAfter(start)) {
      AppToast.showToast(context: context, message: 'يجب أن يكون انتهاء العرض بعد بدايته', type: ToastificationType.error);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CreateOfferAppBar(),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CreateOfferStepCard(number: 1, title: 'المعلومات الأساسية', child: CreateOfferBasicInfoCard(nameController: nameController)),
                    const SizedBox(height: 16),
                    CreateOfferStepCard(
                      number: 2,
                      title: 'نوع الخصم',
                      child: CreateOfferDiscountCard(
                        offerType: offerType,
                        offerTypeChanges: (value) => setState(() => offerType = value),
                        offerValueController: offerValueController,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CreateOfferStepCard(
                      number: 3,
                      title: 'مدة العرض',
                      child: CreateOfferDurationCard(
                        changeIsImmediate: (val) => setState(() {
                          isImmediate = val;
                          if (val) startsAtController.text = DateTime.now().toUtc().toIso8601String();
                        }),
                        endsAtController: endsAtController,
                        isImmediate: isImmediate,
                        startsAtController: startsAtController,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CreateOfferStepCard(
                      number: 4,
                      title: 'ربط المنتجات',
                      trailing: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xFFECFDF5)),
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 4),
                        child: AppText.labelLarge('منتج', color: const Color(0xFF065F46), fontWeight: FontWeight.w700),
                      ),
                      child: const CreateOfferProductsSection(),
                    ),
                    const SizedBox(height: 16),
                    const CreateOfferSelectedProductsCard(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state.createOfferStatus == BlocStatus.success) {
                    context.pop();
                  }
                },
                listenWhen: (pre, cur) => pre.createOfferStatus != cur.createOfferStatus,
                builder: (context, state) {
                  final isLoading = state.createOfferStatus == BlocStatus.loading;
                  final productIds = state.selectedProducts.where((p) => p.id != null).map((p) => p.id!).toList();
                  return Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          onTap: isLoading
                              ? null
                              : () {
                                  if (!_validate(context)) return;
                                  final editingOffer = widget.params?.offer;
                                  final startDate = isImmediate ? DateTime.now().toUtc().toIso8601String() : startsAtController.text.trim();
                                  context.read<ProfileBloc>().add(
                                        CreateOfferSubmitEvent(
                                          context: context,
                                          params: CreateOfferParams(
                                            name: nameController.text.trim(),
                                            discountType: offerType,
                                            discountValue: double.parse(offerValueController.text.trim()),
                                            startsAt: startDate,
                                            endsAt: endsAtController.text.trim(),
                                            isActive: true,
                                            productIds: productIds,
                                            isAddNew: editingOffer == null,
                                            id: editingOffer?.id,
                                          ),
                                        ),
                                      );
                                },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.primary),
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 16),
                            child: AppText.labelLarge('حفظ وتفعيل', color: context.onPrimary, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: InkWell(
                          onTap: isLoading ? null : () => context.pop(),
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
