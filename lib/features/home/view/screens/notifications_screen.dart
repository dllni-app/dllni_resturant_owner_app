import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/home/domain/usecases/fetch_notifications_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/assets.dart';
import '../manager/bloc/home_bloc.dart';
import '../widgets/notification_feed_item.dart';
import '../widgets/notifications_app_bar.dart';
import '../widgets/notifications_filter_bar.dart';

@AutoRoutePage(path: '/notifications')
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

enum NotificationCategory { all, orders, inventory, offers, system }

class _NotificationsScreenState extends State<NotificationsScreen> {
  String selectedKey = 'all';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => getIt<HomeBloc>()..add(FetchNotificationsEvent(params: FetchNotificationsParams(status: selectedKey))),
      child: Scaffold(
        backgroundColor: context.onPrimary,
        body: SafeArea(
          child: Column(
            children: [
              NotificationsAppBar(
                onBackTap: () {
                  context.pop();
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return NotificationsFilterBar(
                    items: [
                      NotificationFilterItem(title: 'الكل', key: 'all', icon: null),
                      NotificationFilterItem(title: 'طلبات', key: 'orders', icon: Assets.imagesNotificationsOrdersIcon),
                      NotificationFilterItem(title: 'مخزون', key: 'inventory', icon: Assets.imagesNotificationsInventoryIcon),
                      NotificationFilterItem(title: 'عروض', key: 'offers', icon: Assets.imagesNotificationsOffersIcon),
                      NotificationFilterItem(title: 'نظام', key: 'system', icon: Assets.imagesNotificationsSettingsIcon),
                    ],
                    selectedKey: selectedKey,
                    onChanged: (val) {
                      setState(() {
                        selectedKey = val;
                      });
                      context.read<HomeBloc>().add(FetchNotificationsEvent(params: FetchNotificationsParams(status: val)));
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    switch (state.notificationsStatus) {
                      case null:
                        return SizedBox.shrink();
                      case BlocStatus.failed:
                        return Center(
                          child: AppText.labelLarge(state.errorMessage ?? 'حدث خطا ما', color: context.error, fontWeight: FontWeight.bold),
                        );
                      case BlocStatus.success:
                        return ListView.separated(
                          padding: EdgeInsetsDirectional.only(bottom: 16),
                          itemBuilder: (context, index) {
                            return NotificationFeedItem(notification: state.notifications!.data![index]);
                          },
                          separatorBuilder: (context, index) => const Divider(color: Color(0xFFE5E7EB), height: 1),
                          itemCount: state.notifications!.data!.length,
                        );
                      case BlocStatus.loading:
                        return Center(child: CircularProgressIndicator.adaptive());
                      case BlocStatus.init:
                        return Center(child: CircularProgressIndicator.adaptive());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: _canLoadMore ? _onLoadMore : null,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: context.width,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh_rounded, color: _canLoadMore ? const Color(0xFF4B5563) : const Color(0xFF9CA3AF), size: 18),
                        const SizedBox(width: 8),
                        AppText.bodyMedium(
                          'تحميل المزيد',
                          color: _canLoadMore ? const Color(0xFF4B5563) : const Color(0xFF9CA3AF),
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
