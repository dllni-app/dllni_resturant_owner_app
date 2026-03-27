import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class CreateCouponAppBar extends StatelessWidget {
  const CreateCouponAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.onPrimary,
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(24), bottomLeft: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: context.primaryContainer, width: 5)),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(27), offset: const Offset(0, -2), blurRadius: 12, spreadRadius: 0)],
      ),
      width: context.width,
      height: 80,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              context.pop();
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: context.primary.withAlpha(32)),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsetsDirectional.all(8),
              child: Icon(Icons.arrow_back_rounded, color: context.primary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppText.headlineLarge('إنشاء كوبون جديد', fontWeight: FontWeight.w700, textAlign: TextAlign.start, color: context.primary),
          ),
        ],
      ),
    );
  }
}


