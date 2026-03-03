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

  List<String> titles = ['الكل', 'طلب جديد', 'قيد التحضير', 'جاهز للتسليم', 'مكتمل'];
  List<Color> colors = [Color(0xff1E2A78), Color(0xffFF7A00), Color(0xff24B364), Color(0xff24B364)];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.onPrimary,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(24), bottomLeft: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: context.primaryContainer, width: 5)),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(27), offset: Offset(0, -2), blurRadius: 12, spreadRadius: 0)],
      ),
      width: context.width,
      height: 130,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.headlineLarge('الطلبات', fontWeight: FontWeight.w700, textAlign: TextAlign.start),
          SizedBox(height: 10),
          SizedBox(
            height: 45,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  widget.ordersNotifier.changeStatus(
                    index == 0
                        ? null
                        : index == 1
                        ? 'pending'
                        : index == 1
                        ? 'preparing'
                        : index == 2
                        ? 'ready_for_pickup'
                        : 'completed',
                  );
                  context.read<OrdersBloc>().add(
                    GetOrdersEvent(
                      params: GetOrdersParams(
                        page: 1,
                        status: index == 0
                            ? null
                            : index == 1
                            ? 'pending'
                            : index == 1
                            ? 'preparing'
                            : index == 2
                            ? 'ready_for_pickup'
                            : 'completed',
                      ),
                      isReload: true,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE5E7EB), width: 1),
                    borderRadius: BorderRadius.circular(24),
                    color: context.onPrimary,
                    gradient: selectedIndex == index
                        ? LinearGradient(
                            colors: [context.primary.withAlpha(127), context.primary],
                            begin: AlignmentGeometry.centerRight,
                            end: AlignmentGeometry.centerLeft,
                          )
                        : null,
                  ),
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 9),
                  child: Row(
                    children: [
                      index == 0 ? SizedBox.shrink() : CircleAvatar(radius: 4, backgroundColor: colors[index - 1]),
                      index == 0 ? SizedBox.shrink() : SizedBox(width: 8),
                      AppText.labelLarge(titles[index], color: selectedIndex == index ? context.onPrimary : Color(0xff4B5563)),
                      SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: selectedIndex == index ? context.primaryContainer : Color(0xffF3F4F6),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 2),
                        child: AppText.labelLarge('1244', color: selectedIndex == index ? context.onPrimaryContainer : Color(0xff4B5563)),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
