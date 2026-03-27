import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class AddEmployeeAppBar extends StatelessWidget {
  const AddEmployeeAppBar({super.key});

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
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
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
            child: AppText.headlineLarge('إضافة موظف جديد', fontWeight: FontWeight.w700, textAlign: TextAlign.start, color: context.primary),
          ),
          // const SizedBox(width: 12),
          // InkWell(
          //   onTap: onSaveTap,
          //   borderRadius: BorderRadius.circular(24),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(colors: [context.primary, const Color(0xFF4F46E5)]),
          //       borderRadius: BorderRadius.circular(24),
          //     ),
          //     padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
          //     child: AppText.bodyMedium('حفظ', color: context.onPrimary, fontWeight: FontWeight.w700),
          //   ),
          // ),
        ],
      ),
    );
  }
}
