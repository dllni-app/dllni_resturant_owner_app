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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _reloadCoupons();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  FetchCouponsParams _params({int page = 1}) {
    return FetchCouponsParams(
      status: profileNotifier.couponStatus.value,
      search: profileNotifier.couponSearch.value.trim().isEmpty ? null : profileNotifier.couponSearch.value.trim(),
      sort: profileNotifier.couponSort.value,
      dateFrom: profileNotifier.couponDateFrom.value,
      dateTo: profileNotifier.couponDateTo.value,
      page: page,
      perPage: 10,
    );
  }

  void _reloadCoupons() {
    final bloc = getIt<ProfileBloc>();
    bloc.add(FetchCouponsEvent(params: _params(), isReload: true));
    bloc.add(FetchCouponsSummaryEvent(params: FetchCouponsSummaryParams()));
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels < _scrollController.position.maxScrollExtent - 220) return;

    final bloc = context.read<ProfileBloc>();
    final couponsState = bloc.state.coupons;
    if (couponsState == null || couponsState.status == BlocStatus.loading || couponsState.isEndPage) return;

    bloc.add(FetchCouponsEvent(params: _params(page: couponsState.pageNumber)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => _reloadCoupons(),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const CouponManagementAppBar(),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      context.pushRoute('/couponsmanagement/new');
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: context.primaryContainer),
                      width: context.width,
                      padding: const EdgeInsetsDirectional.symmetric(vertical: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle, color: context.onPrimaryContainer, size: 22),
                          const SizedBox(width: 8),
                          AppText.labelLarge('إنشاء كوبون جديد', color: context.onPrimaryContainer, fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const CouponsStatisticsGrid(),
                const SizedBox(height: 16),
                CouponsFilterCard(profileNotifier: profileNotifier, onFiltersChanged: _reloadCoupons),
                const SizedBox(height: 16),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    final couponsState = state.coupons!;
                    return couponsState.builder(
                      loadingWidget: const Padding(
                        padding: EdgeInsetsDirectional.symmetric(vertical: 24),
                        child: SizedBox(width: 28, height: 28, child: FittedBox(child: CircularProgressIndicator.adaptive())),
                      ),
                      emptyWidget: _CouponsEmptyState(onCreate: () => context.pushRoute('/couponsmanagement/new')),
                      failedWidget: _CouponsErrorState(message: couponsState.errorMessage.isNotEmpty ? couponsState.errorMessage : 'حدث خطأ أثناء تحميل الكوبونات', onRetry: _reloadCoupons),
                      successWidget: () {
                        final showBottomLoader = couponsState.status == BlocStatus.loading && couponsState.list.isNotEmpty;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 20),
                          itemBuilder: (context, index) {
                            if (index >= couponsState.list.length) {
                              return const Padding(
                                padding: EdgeInsetsDirectional.symmetric(vertical: 12),
                                child: Center(child: SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator.adaptive()))),
                              );
                            }
                            return CouponCard(coupon: couponsState.list[index]);
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 16),
                          itemCount: couponsState.list.length + (showBottomLoader ? 1 : 0),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CouponsEmptyState extends StatelessWidget {
  const _CouponsEmptyState({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Icon(Icons.local_offer_outlined, size: 42, color: context.primary),
            const SizedBox(height: 12),
            AppText.titleMedium('لا توجد كوبونات حالياً', fontWeight: FontWeight.bold),
            const SizedBox(height: 6),
            const AppText.bodyMedium('يمكنك إنشاء كوبون جديد لجذب العملاء وزيادة الطلبات.', color: Color(0xff6B7280), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            InkWell(
              onTap: onCreate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(12)),
                child: AppText.labelLarge('إنشاء كوبون جديد', color: context.onPrimary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CouponsErrorState extends StatelessWidget {
  const _CouponsErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(color: context.error.withAlpha(12), borderRadius: BorderRadius.circular(20), border: Border.all(color: context.error.withAlpha(40))),
        child: Column(
          children: [
            Icon(Icons.error_outline_rounded, size: 40, color: context.error),
            const SizedBox(height: 12),
            AppText.titleMedium('تعذر تحميل الكوبونات', color: context.error, fontWeight: FontWeight.bold),
            const SizedBox(height: 6),
            AppText.bodyMedium(message, color: context.error, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            InkWell(
              onTap: onRetry,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(color: context.error, borderRadius: BorderRadius.circular(12)),
                child: AppText.labelLarge('إعادة المحاولة', color: context.onPrimary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
