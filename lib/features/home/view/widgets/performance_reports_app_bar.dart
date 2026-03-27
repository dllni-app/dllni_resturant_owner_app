import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class PerformanceReportsAppBar extends StatelessWidget {
  const PerformanceReportsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.onPrimary,
        border: Border(bottom: BorderSide(color: context.primaryContainer, width: 2)),
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(24), bottomLeft: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(27), offset: const Offset(0, -2), blurRadius: 12, spreadRadius: 0)],
      ),
      width: context.width,
      height: 70,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: context.primary.withAlpha(32)),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsetsDirectional.all(8),
              child: Icon(Icons.arrow_back_rounded, color: context.primary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppText.headlineLarge('تقارير الأداء', color: context.primary, fontWeight: FontWeight.bold, textAlign: TextAlign.start),
            ),
          ),
        ],
      ),
    );
  }
}
