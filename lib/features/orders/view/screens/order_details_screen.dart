import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/get_orders_model.dart';
import '../widgets/customer_info_card.dart';
import '../widgets/delivery_info_card.dart';
import '../widgets/order_details_app_bar.dart';
import '../widgets/order_details_edit_card.dart';
import '../widgets/order_details_item_card.dart';
import '../widgets/order_details_notes_card.dart';
import '../widgets/order_details_summary_card.dart';
import '../widgets/order_status_card.dart';

@AutoRoutePage(path: '/orders/details')
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.params});

  final OrderDetailsParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            OrderDetailsAppBar(id: params.order.orderNumber!),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderStatusCard(order: params.order,),
                    SizedBox(height: 16),
                    CustomerInfoCard(order: params.order,),
                    SizedBox(height: 16),
                    DeliveryInfoCard(),
                    SizedBox(height: 16),
                    OrderDetailsItemCard(order: params.order,),
                    SizedBox(height: 16),
                    OrderDetailsEditCard(),
                    SizedBox(height: 16),
                    OrderDetailsSummaryCard(order: params.order,),
                    SizedBox(height: 16),
                    OrderDetailsNotesCard(order: params.order,),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDetailsParams{

  final GetOrdersModelDataItem order;

  OrderDetailsParams({required this.order});

}