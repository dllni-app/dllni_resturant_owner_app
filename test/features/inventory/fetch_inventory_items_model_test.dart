import 'package:dllni_resturant_owner_app/features/inventory/data/models/fetch_inventory_items_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FetchInventoryItemsModel parses linked products and decimal quantities', () {
    final model = FetchInventoryItemsModel.fromJson({
      'data': [
        {
          'id': 10,
          'name': 'جبنة',
          'unit': 'كغ',
          'quantity': 3.5,
          'minimumLimit': 1.0,
          'unitCost': 12000.75,
          'products': [
            {'id': 5, 'name': 'بيتزا', 'quantityUsed': 0.25},
          ],
        },
      ],
    });

    final item = model.data!.first;
    expect(item.quantity, 3.5);
    expect(item.minimumLimit, 1.0);
    expect(item.unitCost, 12000.75);
    expect(item.products!.first.id, 5);
    expect(item.products!.first.name, 'بيتزا');
    expect(item.products!.first.quantityUsed, 0.25);
  });
}
