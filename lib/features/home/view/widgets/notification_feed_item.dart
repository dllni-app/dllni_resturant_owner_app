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

  Color notificationStatusColor() {
    if (widget.notification.type == 'order') {
      return Color(0xff10B981);
    }
    else if (widget.notification.type == 'inventory') {
      return Color(0xffF59E0B);
    }
    else if (widget.notification.type == 'offers') {
      return Color(0xffD97706);
    }
    else if (widget.notification.type == 'system') {
      return Color(0xff6B7280);
    }
    else {
      return Color(0xffEF4444);
    }
  }

  String notificationStatusIcon() {
    if (widget.notification.type == 'order') {
      return Assets.images.notificationsOrdersIcon.path;
    }
    else if (widget.notification.type == 'inventory') {
      return Assets.images.notificationsInventoryIcon.path;
    }
    else if (widget.notification.type == 'offers') {
      return Assets.images.notificationsOffersIcon.path;
    }
    else {
      return Assets.images.notificationsSettingsIcon.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding: EdgeInsetsDirectional.all(16),
                decoration: BoxDecoration(color: notificationStatusColor().withAlpha(25), borderRadius: BorderRadius.circular(14)),
                child: AppImage.asset(notificationStatusIcon(), color: notificationStatusColor(),),
              ),
              if (widget.notification.isRead != true)
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
                      child: AppText.bodyMedium(widget.notification.title!, fontWeight: FontWeight.w700, color: const Color(0xFF111827), textAlign: TextAlign.start),
                    ),
                    SizedBox(width: 12),
                    AppText.labelLarge(widget.notification.createdAt == null ? '' : DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.notification.createdAt!)), color: const Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
                  ],
                ),
                const SizedBox(height: 4),
                AppText.bodyMedium(widget.notification.body!, color: const Color(0xFF6B7280), textAlign: TextAlign.start),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(color: notificationStatusColor().withAlpha(25), borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 2),
                  child: AppText.labelLarge(widget.notification.category!, color: notificationStatusColor(), fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
