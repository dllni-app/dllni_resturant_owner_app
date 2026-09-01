import 'package:common_package/common_package.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../../data/models/fetch_notifications_model.dart';

class NotificationFeedItem extends StatefulWidget {
  const NotificationFeedItem({
    super.key,
    required this.notification,
    this.onRead,
  });

  final FetchNotificationsModelDataItem notification;
  final VoidCallback? onRead;

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

  @override
  void didUpdateWidget(covariant NotificationFeedItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isRead = widget.notification.isRead == true;
  }

  String get _classification {
    final values = <String>[
      widget.notification.type ?? '',
      widget.notification.category ?? '',
      widget.notification.title ?? '',
    ].join(' ').toLowerCase();

    if (values.contains('order') || values.contains('طلب') || values.contains('استلام')) return 'orders';
    if (values.contains('inventory') || values.contains('stock') || values.contains('مخزون')) return 'inventory';
    if (values.contains('offer') || values.contains('coupon') || values.contains('عرض') || values.contains('كوبون')) return 'offers';
    if (values.contains('system') || values.contains('نظام')) return 'system';
    return 'system';
  }

  Color notificationStatusColor() {
    switch (_classification) {
      case 'orders':
        return const Color(0xff10B981);
      case 'inventory':
        return const Color(0xffF59E0B);
      case 'offers':
        return const Color(0xffD97706);
      case 'system':
      default:
        return const Color(0xff6B7280);
    }
  }

  String notificationStatusIcon() {
    switch (_classification) {
      case 'orders':
        return Assets.images.notificationsOrdersIcon.path;
      case 'inventory':
        return Assets.images.notificationsInventoryIcon.path;
      case 'offers':
        return Assets.images.notificationsOffersIcon.path;
      default:
        return Assets.images.notificationsSettingsIcon.path;
    }
  }

  void _handleTap() {
    if (!_isRead) {
      widget.onRead?.call();
      setState(() => _isRead = true);
    }

    switch (_classification) {
      case 'orders':
        context.pushRouteAndRemoveUntil('/main', arguments: 1);
        break;
      case 'inventory':
        context.pushRouteAndRemoveUntil('/main', arguments: 3);
        break;
      case 'offers':
        final raw = '${widget.notification.type ?? ''} ${widget.notification.category ?? ''}'.toLowerCase();
        if (raw.contains('coupon')) {
          context.pushRoute('/couponsmanagement');
        } else {
          context.pushRoute('/offersmanagement');
        }
        break;
      default:
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
                    child: AppText.labelLarge(
                      _classification == 'orders' ? 'الطلبات' : _classification == 'inventory' ? 'المخزون' : _classification == 'offers' ? 'العروض والكوبونات' : 'النظام',
                      color: notificationStatusColor(),
                      fontWeight: FontWeight.w700,
                    ),
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
