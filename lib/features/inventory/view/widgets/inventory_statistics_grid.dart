import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../manager/bloc/inventory_bloc.dart';

class InventoryStatisticsGrid extends StatelessWidget {
  const InventoryStatisticsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> titles = ['إجمالي المواد', 'منخفض المخزون', 'قيمة المخزون', 'مواد نافدة'];

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            spacing: 12,
            children: List.generate(
              2,
              (i) => Expanded(
                child: StatePointer(
                  title: titles[i],
                  mainWidget: BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                      switch (state.inventorySummaryStatus) {
                        case null:
                          return SizedBox.shrink();
                        case BlocStatus.failed:
                          return Text(
                            state.errorMessage ?? 'حدف خطا ما',
                            style: TextStyle(fontSize: 10, color: Color(0xB22F2B3D), fontWeight: FontWeight.w500),
                          );
                        case BlocStatus.success:
                          return Text(
                            i == 0
                                ? state.inventorySummary?.data?.totalItems == null
                                      ? '-'
                                      : state.inventorySummary!.data!.totalItems.toString()
                                : state.inventorySummary?.data?.lowStockCount == null
                                ? '-'
                                : state.inventorySummary!.data!.lowStockCount.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              color: i == 0 ? context.primary : Color(0xffFF4C51),
                              fontWeight: FontWeight.bold,
                              height: 1.333,
                            ),
                          );
                        case BlocStatus.loading:
                          return Shimmer.fromColors(
                            baseColor: context.onPrimary,
                            highlightColor: context.primary,
                            child: Container(width: 30, height: 10, color: context.surface),
                          );
                        case BlocStatus.init:
                          return Shimmer.fromColors(
                            baseColor: context.onPrimary,
                            highlightColor: context.primary,
                            child: Container(width: 30, height: 10, color: context.surface),
                          );
                      }
                    },
                  ),
                  trailingWidget: i == 1
                      ? Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xffFF4C51).withAlpha(20)),
                          padding: EdgeInsetsDirectional.all(6),
                          child: Icon(Icons.warning, color: Color(0xffFF4C51), size: 16),
                        )
                      : SizedBox.shrink(),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            spacing: 12,
            children: List.generate(
              2,
              (i) => Expanded(
                child: StatePointer(
                  title: titles[i + 2],
                  mainWidget: BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                      switch (state.inventorySummaryStatus) {
                        case null:
                          return SizedBox.shrink();
                        case BlocStatus.failed:
                          return Text(
                            state.errorMessage ?? 'حدف خطا ما',
                            style: TextStyle(fontSize: 10, color: Color(0xB22F2B3D), fontWeight: FontWeight.w500),
                          );
                        case BlocStatus.success:
                          return Text(
                            i == 0
                                ? state.inventorySummary?.data?.totalValue == null
                                      ? '-'
                                      : state.inventorySummary!.data!.totalValue.toString()
                                : state.inventorySummary?.data?.expiringItemsCount == null
                                ? '-'
                                : state.inventorySummary!.data!.expiringItemsCount.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              color: i == 0 ? context.primaryContainer : context.primary,
                              fontWeight: FontWeight.bold,
                              height: 1.333,
                            ),
                          );
                        case BlocStatus.loading:
                          return Shimmer.fromColors(
                            baseColor: context.onPrimary,
                            highlightColor: context.primary,
                            child: Container(width: 30, height: 10, color: context.surface),
                          );
                        case BlocStatus.init:
                          return Shimmer.fromColors(
                            baseColor: context.onPrimary,
                            highlightColor: context.primary,
                            child: Container(width: 30, height: 10, color: context.surface),
                          );
                      }
                    },
                  ),
                  trailingWidget: i == 0
                      ? AppText.bodyMedium('ل.س', color: context.primaryContainer, fontWeight: FontWeight.w400)
                      : SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatePointer extends StatelessWidget {
  const StatePointer({super.key, required this.title, required this.trailingWidget, required this.mainWidget});

  final String title;
  final Widget trailingWidget;
  final Widget mainWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: context.onPrimary,
        borderRadius: BorderRadius.all(Radius.circular(32)),
        border: Border.all(color: Color(0xFFF9FAFB)),
        boxShadow: [BoxShadow(offset: Offset(0, 0), blurRadius: 15, color: Color(0x07000000))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Color(0xB22F2B3D), fontWeight: FontWeight.w500, height: 1.333),
          ),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: mainWidget),
              SizedBox(width: 8),
              trailingWidget,
            ],
          ),
        ],
      ),
    );
  }
}
