import 'package:flutter_test/flutter_test.dart';
import 'package:dllni_resturant_owner_app/features/orders/view/widgets/order_status_action_bottom_sheet.dart';

void main() {
  test('self pickup ready action mentions customer, not courier', () {
    final actions = restaurantOrderNextStatusActions(
      'preparing', orderType: 'pickup',
    );
    final ready = actions.firstWhere((action) => action.status == 'ready_for_pickup');
    expect(ready.description, contains('العميل'));
    expect(ready.description, isNot(contains('المندوب')));
  });

  test('delivery ready action remains courier handoff', () {
    final actions = restaurantOrderNextStatusActions(
      'preparing', orderType: 'delivery',
    );
    final ready = actions.firstWhere((action) => action.status == 'ready_for_pickup');
    expect(ready.description, isNot(contains('إعلام العميل')));
  });
}
