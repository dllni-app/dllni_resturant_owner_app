import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class ActivityEmptyState extends StatelessWidget {
  const ActivityEmptyState({super.key, required this.title, required this.message, this.onRefresh});

  final String title;
  final String message;
  final VoidCallback? onRefresh;

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
            Icon(Icons.history_toggle_off_rounded, size: 44, color: context.primary),
            const SizedBox(height: 12),
            AppText.titleMedium(title, fontWeight: FontWeight.bold),
            const SizedBox(height: 6),
            AppText.bodyMedium(message, color: const Color(0xff6B7280), textAlign: TextAlign.center),
            if (onRefresh != null) ...[
              const SizedBox(height: 16),
              InkWell(
                onTap: onRefresh,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(12)),
                  child: AppText.labelLarge('تحديث', color: context.onPrimary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
