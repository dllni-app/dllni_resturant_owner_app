import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/data/models/fetch_activity_logs_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityLogCard extends StatelessWidget {
  const ActivityLogCard({super.key, required this.item});

  final ActivityLogItem item;

  String _logNameLabel(String? logName) {
    switch (logName) {
      case 'orders':
        return 'الطلبات';
      case 'products':
        return 'المنتجات / المخزون';
      case 'offers':
        return 'العروض والكوبونات';
      case 'system':
        return 'النظام';
      default:
        return 'نشاط';
    }
  }

  String _eventLabel(String? event) {
    switch (event) {
      case 'created':
        return 'إنشاء';
      case 'updated':
        return 'تعديل';
      case 'deleted':
        return 'حذف';
      default:
        return event?.trim().isNotEmpty == true ? event! : 'نشاط';
    }
  }

  IconData _icon(String? logName) {
    switch (logName) {
      case 'orders':
        return Icons.receipt_long_rounded;
      case 'products':
        return Icons.inventory_2_rounded;
      case 'offers':
        return Icons.local_offer_rounded;
      case 'system':
        return Icons.settings_rounded;
      default:
        return Icons.history_rounded;
    }
  }

  String _formatDate(String? value) {
    if (value == null || value.trim().isEmpty) return 'غير محدد';
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    return DateFormat('yyyy-MM-dd HH:mm').format(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final causerName = item.causer?.name?.trim().isNotEmpty == true ? item.causer!.name!.trim() : 'النظام';
    final causerInitial = causerName.isNotEmpty ? causerName.substring(0, 1) : '-';
    final description = item.description?.trim().isNotEmpty == true ? item.description!.trim() : 'تم تسجيل نشاط جديد';
    final subjectId = item.subjectId?.toString();

    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(
        color: context.onPrimary,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xffF3F4F6)),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: const Offset(0, 1), blurRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: context.primary.withAlpha(25), borderRadius: BorderRadius.circular(14)),
                child: Icon(_icon(item.logName), color: context.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodyLarge(description, fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: const Color(0xffF3F4F6),
                          child: AppText.labelSmall(causerInitial, color: const Color(0xff374151), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        Expanded(child: AppText.labelLarge(causerName, color: const Color(0xff6B7280), textAlign: TextAlign.start, scrollText: true)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Pill(label: _logNameLabel(item.logName), icon: Icons.category_outlined),
              _Pill(label: _eventLabel(item.event), icon: Icons.edit_note_rounded),
              _Pill(label: _formatDate(item.createdAt), icon: Icons.schedule_rounded),
              if (subjectId != null && subjectId.isNotEmpty) _Pill(label: '#$subjectId', icon: Icons.tag_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: const Color(0xffF9FAFB), borderRadius: BorderRadius.circular(50), border: Border.all(color: const Color(0xffE5E7EB))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xff6B7280)),
          const SizedBox(width: 4),
          AppText.labelMedium(label, color: const Color(0xff374151)),
        ],
      ),
    );
  }
}
