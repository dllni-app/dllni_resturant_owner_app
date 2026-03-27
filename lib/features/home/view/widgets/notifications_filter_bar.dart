import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class NotificationFilterItem {
  const NotificationFilterItem({required this.key, required this.title, required this.icon});

  final String key;
  final String title;
  final String? icon;
}

class NotificationsFilterBar extends StatelessWidget {
  const NotificationsFilterBar({super.key, required this.items, required this.selectedKey, required this.onChanged});

  final List<NotificationFilterItem> items;
  final String selectedKey;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final NotificationFilterItem item = items[index];
          final bool isSelected = item.key == selectedKey;

          return InkWell(
            onTap: () {
              onChanged(item.key);
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: isSelected ? const Color(0xFF065F46) : context.onPrimary,
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  if (item.icon != null) ...[
                    AppImage.asset(item.icon!, color: isSelected ? context.onPrimary : const Color(0xFF4B5563), size: 16),
                    const SizedBox(width: 8),
                  ],
                  AppText.labelLarge(item.title, color: isSelected ? context.onPrimary : const Color(0xFF374151), fontWeight: FontWeight.w700),
                  /*const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: isSelected ? context.onPrimary.withAlpha(40) : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
                    child: AppText.labelLarge(
                      item.count.toString(),
                      color: isSelected ? context.onPrimary : const Color(0xFF4B5563),
                      fontWeight: FontWeight.w700,
                    ),
                  ),*/
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: items.length,
      ),
    );
  }
}
