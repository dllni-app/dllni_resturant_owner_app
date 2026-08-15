import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/home/domain/usecases/fetch_notifications_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/assets.dart';
import '../manager/bloc/home_bloc.dart';
import '../widgets/notification_feed_item.dart';
import '../widgets/notifications_app_bar.dart';
import '../widgets/notifications_filter_bar.dart';

class NotificationsScreenParams {
  final HomeBloc homeBloc;
  final String selectedKey;

  NotificationsScreenParams({required this.homeBloc, required this.selectedKey});
}

@AutoRoutePage(path: '/notifications')
class NotificationsScreen extends StatefulWidget {
  final NotificationsScreenParams args;

  const NotificationsScreen({super.key, required this.args});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late String selectedKey;

  @override
  void initState() {
    selectedKey = widget.args.selectedKey;
    super.initState();
  }

  Future<void> _confirmDeleteAll(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف الكل'),
        content: const Text('هل أنت متأكد من حذف جميع الإشعارات؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      widget.args.homeBloc.add(DeleteAllNotificationsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.onPrimary,
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              bloc: widget.args.homeBloc,
              builder: (context, state) {
                final hasNotifications = state.notifications?.data?.isNotEmpty == true;
                return NotificationsAppBar(
                  onBackTap: context.pop,
                  homeBloc: widget.args.homeBloc,
                  onDeleteAll: hasNotifications ? () => _confirmDeleteAll(context) : null,
                );
              },
            ),
            const SizedBox(height: 16),
            NotificationsFilterBar(
              items: [
                NotificationFilterItem(title: 'الكل', key: 'all', icon: null),
                NotificationFilterItem(title: 'طلبات', key: 'orders', icon: Assets.images.notificationsOrdersIcon.path),
                NotificationFilterItem(title: 'مخزون', key: 'inventory', icon: Assets.images.notificationsInventoryIcon.path),
                NotificationFilterItem(title: 'عروض', key: 'offers', icon: Assets.images.notificationsOffersIcon.path),
                NotificationFilterItem(title: 'نظام', key: 'system', icon: Assets.images.notificationsSettingsIcon.path),
              ],
              selectedKey: selectedKey,
              onChanged: (val) {
                setState(() => selectedKey = val);
                widget.args.homeBloc.add(
                  FetchNotificationsEvent(params: FetchNotificationsParams(status: val)),
                );
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                bloc: widget.args.homeBloc,
                builder: (context, state) {
                  switch (state.notificationsStatus) {
                    case null:
                      return const SizedBox.shrink();
                    case BlocStatus.failed:
                      return Center(
                        child: AppText.labelLarge(
                          state.errorMessage ?? 'حدث خطا ما',
                          color: context.error,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    case BlocStatus.success:
                      final notifications = state.notifications?.data ?? const [];
                      if (notifications.isEmpty) {
                        return Center(
                          child: AppText.labelLarge(
                            'لا توجد إشعارات حاليا',
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsetsDirectional.only(bottom: 16),
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return Dismissible(
                            key: ValueKey(notification.id ?? '${notification.createdAt}-$index'),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: const Color(0xffEF4444),
                              alignment: AlignmentDirectional.centerEnd,
                              padding: const EdgeInsetsDirectional.only(end: 20),
                              child: const Icon(Icons.delete_outline, color: Colors.white),
                            ),
                            onDismissed: (_) {
                              final id = notification.id;
                              if (id != null && id.isNotEmpty) {
                                widget.args.homeBloc.add(DeleteNotificationEvent(id: id));
                              }
                            },
                            child: NotificationFeedItem(
                              notification: notification,
                              onRead: () {
                                final id = notification.id;
                                if (id != null && id.isNotEmpty && notification.isRead != true) {
                                  widget.args.homeBloc.add(ReadNotificationEvent(id: id));
                                }
                              },
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const Divider(
                          color: Color(0xFFE5E7EB),
                          height: 1,
                        ),
                        itemCount: notifications.length,
                      );
                    case BlocStatus.loading:
                    case BlocStatus.init:
                      return const Center(child: CircularProgressIndicator.adaptive());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
