import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:dllni_resturant_owner_app/features/orders/view/manager/bloc/orders_bloc.dart';
import 'package:dllni_resturant_owner_app/features/orders/view/manager/orders_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersAppBar extends StatefulWidget {
  const OrdersAppBar({super.key, required this.ordersNotifier});

  final OrdersNotifier ordersNotifier;

  @override
  State<OrdersAppBar> createState() => _OrdersAppBarState();
}

class _OrdersAppBarState extends State<OrdersAppBar> {
  int selectedIndex = 0;
  final titles = const ['الكل', 'قيد الانتظار', 'مقبول', 'قيد التحضير', 'جاهز للاستلام', 'مكتمل', 'ملغي'];
  final statuses = const <String?>[null, 'pending', 'accepted', 'preparing', 'ready_for_pickup', 'completed', 'cancelled'];
  final colors = const [Color(0xff1E2A78), Color(0xff3B82F6), Color(0xffFF7A00), Color(0xff24B364), Colors.grey, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: const BorderRadius.only(bottomRight: Radius.circular(24), bottomLeft: Radius.circular(24)), border: Border(bottom: BorderSide(color: context.primaryContainer, width: 5)), boxShadow: [BoxShadow(color: Colors.black.withAlpha(27), offset: const Offset(0, -2), blurRadius: 12)]),
      width: context.width,
      height: 130,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.headlineLarge('الطلبات', fontWeight: FontWeight.w700, textAlign: TextAlign.start),
          const SizedBox(height: 10),
          SizedBox(
            height: 45,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  setState(() => selectedIndex = index);
                  widget.ordersNotifier.changeStatus(statuses[index]);
                  context.read<OrdersBloc>().add(GetOrdersEvent(params: GetOrdersParams(page: 1, status: statuses[index]), isReload: true));
                },
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: const Color(0xffE5E7EB)), borderRadius: BorderRadius.circular(24), color: context.onPrimary, gradient: selectedIndex == index ? LinearGradient(colors: [context.primary.withAlpha(127), context.primary], begin: Alignment.centerRight, end: Alignment.centerLeft) : null),
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 9),
                  child: Row(children: [if (index != 0) CircleAvatar(radius: 4, backgroundColor: colors[index - 1]), if (index != 0) const SizedBox(width: 8), AppText.labelLarge(titles[index], color: selectedIndex == index ? context.onPrimary : const Color(0xff4B5563))]),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemCount: titles.length,
            ),
          ),
        ],
      ),
    );
  }
}
