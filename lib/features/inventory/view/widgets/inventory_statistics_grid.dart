import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

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
                  value: 100,
                  valueColor: i == 0 ? context.primary : Color(0xffFF4C51),
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
                  value: 100,
                  valueColor: i == 0 ? context.primaryContainer : context.primary,
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
  const StatePointer({super.key, required this.title, required this.value, required this.valueColor, required this.trailingWidget});

  final String title;
  final int value;
  final Color valueColor;
  final Widget trailingWidget;

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
              AppText.displaySmall(value.toString(), color: valueColor, fontWeight: FontWeight.bold),
              trailingWidget,
            ],
          ),
        ],
      ),
    );
  }
}
