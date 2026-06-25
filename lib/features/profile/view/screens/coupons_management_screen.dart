import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/fetch_coupons_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/fetch_coupons_summary_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/widgets/coupon_statistics_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/profile_bloc.dart';
import '../manager/profile_notifier.dart';
import '../widgets/coupon_card.dart';
import '../widgets/coupon_management_app_bar.dart';
import '../widgets/coupons_filter_card.dart';

@AutoRoutePage()
class CouponsManagementScreen extends StatefulWidget {
  const CouponsManagementScreen({super.key});

  @override
  State<CouponsManagementScreen> createState() => _CouponsManagementScreenState();
}

class _CouponsManagementScreenState extends State<CouponsManagementScreen> {
  final ProfileNotifier profileNotifier = ProfileNotifier();

  @override
  void initState() {
    super.initState();
    final bloc = getIt<ProfileBloc>();
    bloc.add(FetchCouponsEvent(params: FetchCouponsParams(status: 'all'), isReload: true));
    bloc.add(FetchCouponsSummaryEvent(params: FetchCouponsSummaryParams()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CouponManagementAppBar(),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      context.pushRoute('/couponsmanagement/new');
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: context.primaryContainer),
                      width: context.width,
                      padding: EdgeInsetsDirectional.symmetric(vertical: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle, color: context.onPrimaryContainer, size: 22),
                          SizedBox(width: 8),
                          AppText.labelLarge('إنشاء كوبون جديد', color: context.onPrimaryContainer, fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                CouponsStatisticsGrid(),
                SizedBox(height: 16),
                CouponsFilterCard(profileNotifier: profileNotifier),
                SizedBox(height: 16),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return state.coupons!.builder(
                      loadingWidget: SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator.adaptive())),
                      emptyWidget: Center(child: AppText.labelLarge('لا يوجد كوبونات', fontWeight: FontWeight.bold)),
                      failedWidget: Center(
                        child: AppText.labelLarge(state.coupons?.errorMessage ?? 'حدث خطا ما', fontWeight: FontWeight.bold, color: context.error),
                      ),
                      successWidget: () {
                        return ValueListenableBuilder(
                          valueListenable: profileNotifier.couponStatus,
                          builder: (context, status, _) => ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 20),
                            itemBuilder: (context, index) {
                              if (state.coupons!.list.length == index) {
                                if (state.coupons!.list.length <= index) {
                                  context.read<ProfileBloc>().add(FetchCouponsEvent(params: FetchCouponsParams(status: status)));
                                }
                                return SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator.adaptive()));
                              }
                              return CouponCard(coupon: state.coupons!.list[index]);
                            },
                            separatorBuilder: (context, index) => SizedBox(height: 16),
                            itemCount: state.coupons!.listLength(1),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
