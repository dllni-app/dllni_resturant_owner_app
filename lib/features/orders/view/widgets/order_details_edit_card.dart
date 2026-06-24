import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/owner_order_details_model.dart';
import '../../domain/usecases/add_order_item_use_case.dart';
import '../manager/bloc/orders_bloc.dart';

class OrderDetailsEditCard extends StatelessWidget {
  const OrderDetailsEditCard({super.key, required this.order, required this.bloc});

  final OwnerOrderDetailsData order;
  final OrdersBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: const Color(0xffEFF6FF), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const CircleAvatar(backgroundColor: Color(0xffDBEAFE), child: Icon(Icons.edit, size: 20, color: Color(0xff2563EB))), const SizedBox(width: 8), Expanded(child: AppText.headlineMedium('تعديل الطلب', fontWeight: FontWeight.bold, color: const Color(0xff1E3A8A)))]),
          const SizedBox(height: 8),
          AppText.bodySmall('يمكنك إضافة منتج من مطعمك فقط. بعد الحفظ سيتم تحديث تفاصيل الطلب.', color: const Color(0xff2563EB), textAlign: TextAlign.start),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => _showAddItemSheet(context),
            child: Container(
              width: context.width,
              padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
              decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xff2563EB))),
              child: Center(child: AppText.labelMedium('إضافة منتج', color: const Color(0xff2563EB), fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddItemSheet(BuildContext context) {
    final productId = TextEditingController();
    final quantity = TextEditingController(text: '1');
    final unitPrice = TextEditingController();
    final notes = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: productId, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'معرف المنتج')),
          TextField(controller: quantity, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'الكمية')),
          TextField(controller: unitPrice, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'سعر الوحدة')),
          TextField(controller: notes, decoration: const InputDecoration(labelText: 'ملاحظات')),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final p = int.tryParse(productId.text.trim());
              final q = int.tryParse(quantity.text.trim());
              final price = num.tryParse(unitPrice.text.trim());
              if (p == null || q == null || price == null) return;
              bloc.add(AddOrderItemEvent(params: AddOrderItemParams(orderId: order.id, productId: p, quantity: q, unitPrice: price, specialInstructions: notes.text.trim())));
              Navigator.of(context).pop();
            },
            child: const Text('حفظ'),
          ),
        ]),
      ),
    );
  }
}
