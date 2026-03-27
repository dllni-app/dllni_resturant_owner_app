import 'package:common_package/annotations/auto_route_page.dart';
import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/home/domain/usecases/home_overview_performance_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view/manager/bloc/home_bloc.dart';
import '../widgets/delivery_statistics_section.dart';
import '../widgets/offer_analysis_section.dart';
import '../widgets/performance_kpi_cards.dart';
import '../widgets/performance_reports_app_bar.dart';
import '../widgets/period_selection_tabs.dart';
import '../widgets/top_selling_products_section.dart';

@AutoRoutePage(path: '/performance-reports')
class PerformanceReportsScreen extends StatefulWidget {
  const PerformanceReportsScreen({super.key});

  @override
  State<PerformanceReportsScreen> createState() => _PerformanceReportsScreenState();
}

class _PerformanceReportsScreenState extends State<PerformanceReportsScreen> {
  String _selectedPeriodKey = 'today';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      lazy: false,
      create: (context) => getIt<HomeBloc>()..add(HomeOverviewPerformanceEvent(params: HomeOverviewPerformanceParams())),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const PerformanceReportsAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      PeriodSelectionTabs(
                        selectedKey: _selectedPeriodKey,
                        onChanged: (value) {
                          setState(() {
                            _selectedPeriodKey = value;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return PerformanceKpiCards(
                            status: state.homeOverviewPerformanceStatus,
                            summary: state.homeOverviewPerformance?.summary,
                            errorMessage: state.errorMessage,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return TopSellingProductsSection(
                            status: state.homeOverviewPerformanceStatus,
                            products: state.homeOverviewPerformance?.topProducts ?? const [],
                            errorMessage: state.errorMessage,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return DeliveryStatisticsSection(
                            status: state.homeOverviewPerformanceStatus,
                            fulfillment: state.homeOverviewPerformance?.fulfillment,
                            errorMessage: state.errorMessage,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return OfferAnalysisSection(
                            status: state.homeOverviewPerformanceStatus,
                            offersImpact: state.homeOverviewPerformance?.offersImpact,
                            errorMessage: state.errorMessage,
                            bestOffer: state.homeOverviewPerformance?.bestOfferPerformance,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


