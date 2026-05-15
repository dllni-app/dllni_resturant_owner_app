import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/fetch_offers_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/fetch_offers_summary_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/profile_bloc.dart';
import '../manager/profile_notifier.dart';
import '../widgets/offer_card.dart';
import '../widgets/offers_filter_card.dart';
import '../widgets/offers_management_app_bar.dart';
import '../widgets/offers_statistics_grid.dart';

@AutoRoutePage()
class OffersManagementScreen extends StatefulWidget {
  const OffersManagementScreen({super.key});

  @override
  State<OffersManagementScreen> createState() => _OffersManagementScreenState();
}

class _OffersManagementScreenState extends State<OffersManagementScreen> {
  final ProfileNotifier profileNotifier = ProfileNotifier();

  @override
  void initState() {
    super.initState();
    final bloc = getIt<ProfileBloc>();
    bloc.add(FetchOffersEvent(params: FetchOffersParams(page: 1, status: null), isReload: true));
    bloc.add(FetchOffersSummaryEvent(params: FetchOffersSummaryParams()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              OffersManagementAppBar(),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    context.pushRoute('/offersmanagement/new');
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: context.primaryContainer),
                    width: context.width,
                    padding: EdgeInsetsDirectional.symmetric(vertical: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle, color: context.onPrimaryContainer, size: 22),
                        SizedBox(width: 8),
                        AppText.labelLarge('إنشاء عرض جديد', color: context.onPrimaryContainer, fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              OffersStatisticsGrid(),
              SizedBox(height: 16),
              OffersFilterCard(profileNotifier: profileNotifier),
              SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return state.offers!.builder(
                      loadingWidget: SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator.adaptive())),
                      emptyWidget: Center(child: AppText.labelLarge('لا يوجد عروض', fontWeight: FontWeight.bold)),
                      failedWidget: Center(
                        child: AppText.labelLarge(state.offers?.errorMessage ?? 'حدث خطا ما', fontWeight: FontWeight.bold, color: context.error),
                      ),
                      successWidget: () {
                        return ValueListenableBuilder(
                          valueListenable: profileNotifier.offerStatus,
                          builder: (context, status, _) {
                            return ListView.separated(
                              padding: EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 20),
                              itemBuilder: (context, index) {
                                if (state.offers!.list.length == index) {
                                  if (!state.offers!.isEndPage) {
                                    context.read<ProfileBloc>().add(
                                      FetchOffersEvent(
                                        params: FetchOffersParams(page: state.offers!.pageNumber, status: status),
                                      ),
                                    );
                                  }
                                  return SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator.adaptive()));
                                }
                                return OfferCard(offer: state.offers!.list[index]);
                              },
                              separatorBuilder: (context, index) => SizedBox(height: 16),
                              itemCount: state.offers!.list.length + (state.offers!.isEndPage ? 0 : 1),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}
