import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class InventoryStepCard extends StatelessWidget {
  const InventoryStepCard({
    super.key,
    required this.number,
    required this.title,
    required this.child,
    this.padding,
    this.trailing,
  });

  final int number;
  final String title;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsetsDirectional.all(24),
      decoration: BoxDecoration(
        color: context.onPrimary,
        border: Border.all(color: const Color(0xFFF3F4F6)),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 20,
            spreadRadius: -2,
            color: Colors.black.withAlpha(13),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: context.primaryContainer,
                child: AppText(
                  number.toString(),
                  style: TextStyle(
                    color: context.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.42,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppText(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: context.primaryContainer,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.555,
                  ),
                ),
              ),
              trailing == null
                  ? const SizedBox.shrink()
                  : const SizedBox(width: 12),
              trailing ?? const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

