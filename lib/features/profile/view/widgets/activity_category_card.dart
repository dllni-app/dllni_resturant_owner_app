import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class ActivityCategoryCard extends StatelessWidget {
  const ActivityCategoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(18)),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: context.primary.withAlpha(25), borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: context.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodyLarge(title, fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                  const SizedBox(height: 4),
                  AppText.bodyMedium(description, color: const Color(0xff6B7280), textAlign: TextAlign.start),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xff9CA3AF)),
          ],
        ),
      ),
    );
  }
}
