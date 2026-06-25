import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../widgets/activity_category_card.dart';
import 'activity_logs_screen.dart';

@AutoRoutePage(path: '/employees/activity')
class EmployeeActivityScreen extends StatelessWidget {
  const EmployeeActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      _ActivityCategory(
        title: 'قبول الطلبات',
        description: 'تابع الموظف المسؤول عن قبول وتجهيز الطلبات.',
        logName: 'orders',
        icon: Icons.receipt_long_rounded,
      ),
      _ActivityCategory(
        title: 'تحديث المخزون',
        description: 'راقب تعديلات الكميات والمواد المرتبطة بالمنتجات.',
        logName: 'products',
        icon: Icons.inventory_2_rounded,
      ),
      _ActivityCategory(
        title: 'العروض والكوبونات',
        description: 'راجع نشاط إنشاء وتعديل العروض الترويجية.',
        logName: 'offers',
        icon: Icons.local_offer_rounded,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            const _Header(title: 'سجل نشاط الموظفين'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 8),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ActivityCategoryCard(
                    title: item.title,
                    description: item.description,
                    icon: item.icon,
                    onTap: () => context.pushRoute(
                      '/employees/activity/logs',
                      arguments: ActivityLogsScreenParams(
                        title: item.title,
                        description: item.description,
                        logName: item.logName,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: items.length,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 20),
              child: InkWell(
                onTap: () => context.pushRoute('/employeesmanagement'),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
                  decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(12)),
                  child: AppText.labelLarge('إدارة الموظفين', color: context.onPrimary, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityCategory {
  const _ActivityCategory({required this.title, required this.description, required this.logName, required this.icon});

  final String title;
  final String description;
  final String logName;
  final IconData icon;
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.fromSTEB(24, 16 + MediaQuery.paddingOf(context).top, 24, 18),
      decoration: BoxDecoration(
        color: context.onPrimary,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: context.primaryContainer, width: 4)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.pop(),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(border: Border.all(color: const Color(0xffE5E7EB)), borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: AppText.headlineLarge(title, fontWeight: FontWeight.bold, textAlign: TextAlign.start)),
        ],
      ),
    );
  }
}
