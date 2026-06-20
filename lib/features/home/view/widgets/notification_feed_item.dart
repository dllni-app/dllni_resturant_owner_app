import 'package:common_package/common_package.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../../data/models/fetch_notifications_model.dart';

class NotificationFeedItem extends StatefulWidget {
  const NotificationFeedItem({super.key, required this.notification});

  final FetchNotificationsModelDataItem notification;

  @override
  State<NotificationFeedItem> createState() => _NotificationFeedItemState();
}

class _NotificationFeedItemState extends State<NotificationFeedItem> {
  late bool _isRead;

  @override
  void initState() {
    super.initState();
    _isRead = widget.notification.isRead == true;
  }

  Color notificationStatusColor() {
    if (widget.notification.type == 'order' || widget.notification.category == 'orders') return const Color(0xff10B981);
    if (widget.notification.type == 'inventory' || widget.notification.category == 'inventory') return const Color(0xffF59E0B);
    if (widget.notification.type == 'offers' || widget.notification.category == 'offers') return const Color(0xffD97706);
    if (widget.notification.type == 'system' || widget.notification.category == 'system') return const Color(0xff6B7280);
    return const Color(0xffEF4444);
  }

  String notificationStatusIcon() {
    if (widget.notification.type == 'order' || widget.notification.category == 'orders') return Assets.images.notificationsOrdersIcon.path;
    if (widget.notification.type == 'inventory' || widget.notification.category == 'inventory') return Assets.images.notificationsInventoryIcon.path;
    if (widget.notification.type == 'offers' || widget.notification.category == 'offers') return Assets.images.notificationsOffersIcon.path;
    return Assets.images.notificationsSettingsIcon.path;
  }

  void _handleTap() {
    setState(() {
      _isRead = true;
      widget.notification.isRead = true;
    });

    final type = (widget.notification.type ?? widget.notification.category ?? '').toLowerCase();
    if (type.contains('order')) {
      context.pushRouteAndRemoveUntil('/main', arguments: 1);
    } else if (type.contains('inventory')) {
      context.pushRouteAndRemoveUntil('/main', arguments: 3);
    } else if (type.contains('offer')) {
      context.pushRoute('/offersmanagement');
    } else if (type.contains('coupon')) {
      context.pushRoute('/couponsmanagement');
    } else {
      context.pushRouteAndRemoveUntil('/main', arguments: 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      child: Container(
        color: context.onPrimary,
        padding: const EdgeInsetsDirectional.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  padding: const EdgeInsetsDirectional.all(16),
                  decoration: BoxDecoration(color: notificationStatusColor().withAlpha(25), borderRadius: BorderRadius.circular(14)),
                  child: AppImage.asset(notificationStatusIcon(), color: notificationStatusColor()),
                ),
                if (!_isRead)
                  PositionedDirectional(
                    top: -2,
                    start: -2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: context.onPrimary, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppText.bodyMedium(widget.notification.title ?? '-', fontWeight: FontWeight.w700, color: const Color(0xFF111827), textAlign: TextAlign.start),
                      ),
                      const SizedBox(width: 12),
                      AppText.labelLarge(
                        widget.notification.createdAt == null ? '' : DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.notification.createdAt!)),
                        color: const Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  AppText.bodyMedium(widget.notification.body ?? '-', color: const Color(0xFF6B7280), textAlign: TextAlign.start),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(color: notificationStatusColor().withAlpha(25), borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 2),
                    child: AppText.labelLarge(widget.notification.category ?? widget.notification.type ?? '-', color: notificationStatusColor(), fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
