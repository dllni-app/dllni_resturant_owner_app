import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/home/domain/usecases/home_overview_performance_use_case.dart';
import 'package:dllni_resturant_owner_app/features/home/view/manager/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeriodSelectionTabs extends StatelessWidget {
  const PeriodSelectionTabs({super.key, required this.selectedKey, required this.onChanged});

  final String selectedKey;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final items = <_PeriodItem>[
      const _PeriodItem(key: 'today', title: 'اليوم'),
      const _PeriodItem(key: 'week', title: 'هذا الأسبوع'),
      const _PeriodItem(key: 'month', title: 'هذا الشهر'),
      const _PeriodItem(key: 'year', title: 'هذا العام'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...items.map((item) {
            final isSelected = item.key == selectedKey;
            final isCustom = item.key == 'custom';
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(9999),
                onTap: () {
                  onChanged(item.key);
                  context.read<HomeBloc>().add(HomeOverviewPerformanceEvent(params: HomeOverviewPerformanceParams(range: item.key)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: isSelected ? const Color(0xff064E3B) : context.onPrimary,
                    border: Border.all(color: isSelected ? const Color(0xff064E3B) : const Color(0xffE5E7EB), width: 1),
                  ),
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      if (isCustom) ...[const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xff6B7280)), const SizedBox(width: 6)],
                      AppText.labelMedium(item.title, fontWeight: FontWeight.w500, color: isSelected ? context.onPrimary : const Color(0xff4B5563)),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _PeriodItem {
  final String key;
  final String title;

  const _PeriodItem({required this.key, required this.title});
}
