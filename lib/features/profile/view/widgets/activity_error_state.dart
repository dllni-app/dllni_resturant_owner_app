import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class ActivityErrorState extends StatelessWidget {
  const ActivityErrorState({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(
          color: context.error.withAlpha(12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.error.withAlpha(40)),
        ),
        child: Column(
          children: [
            Icon(Icons.error_outline_rounded, size: 42, color: context.error),
            const SizedBox(height: 12),
            AppText.titleMedium('تعذر تحميل السجل', color: context.error, fontWeight: FontWeight.bold),
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
