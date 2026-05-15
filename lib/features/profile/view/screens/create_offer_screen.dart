import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/data/models/fetch_offers_model.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/create_offer_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      startsAtController.text = offer.startsAt == null ? '' : DateFormat('yyyy-MM-dd').format(DateTime.parse(offer.startsAt!));
      endsAtController.text = offer.endsAt == null ? '' : DateFormat('yyyy-MM-dd').format(DateTime.parse(offer.endsAt!));
      offerType = offer.discountType ?? 'fixed_amount';
      isImmediate = offer.isActive ?? false;
    }
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
                      CreateOfferStepCard(
                        number: 1,
                        title: 'المعلومات الأساسية',
                        child: CreateOfferBasicInfoCard(nameController: nameController),
                      ),
                      SizedBox(height: 16),
                      CreateOfferStepCard(
                        number: 2,
                        title: 'نوع الخصم',
                        child: CreateOfferDiscountCard(
                          offerType: offerType,
                          offerTypeChanges: (value) => setState(() {
                            offerType = value;
                          }),
                          offerValueController: offerValueController,
                        ),
                      ),
                      SizedBox(height: 16),
                      CreateOfferStepCard(
                        number: 3,
                        title: 'مدة العرض',
                        child: CreateOfferDurationCard(
                          changeIsImmediate: (val) => setState(() {
                            isImmediate = val;
                          }),
                          endsAtController: endsAtController,
                          isImmediate: isImmediate,
                          startsAtController: startsAtController,
                        ),
                      ),
                      SizedBox(height: 16),
                      CreateOfferStepCard(
                        number: 4,
                        title: 'ربط المنتجات',
                        trailing: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Color(0xFFECFDF5)),
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 4),
                          child: AppText.labelLarge('منتج', color: Color(0xFF065F46), fontWeight: FontWeight.w700),
                        ),
                        child: CreateOfferProductsSection(),
                      ),
                      SizedBox(height: 16),
                      CreateOfferSelectedProductsCard(),
                      SizedBox(height: 20),
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
                                      final editingOffer = widget.params?.offer;
                                      context.read<ProfileBloc>().add(
                                        CreateOfferSubmitEvent(
                                          context: context,
                                          params: CreateOfferParams(
                                            name: nameController.text,
                                            discountType: offerType,
                                            discountValue: double.parse(offerValueController.text),
                                            startsAt: isImmediate ? DateFormat('yyyy-MM-dd').format(DateTime.now()) : startsAtController.text,
                                            endsAt: endsAtController.text,
                                            isActive: isImmediate,
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
