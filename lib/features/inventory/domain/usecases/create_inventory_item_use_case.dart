import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/inventory_repo.dart';
import '../../data/models/create_inventory_item_model.dart';

@lazySingleton
class CreateInventoryItemUseCase
    implements UseCase<CreateInventoryItemModel, CreateInventoryItemParams> {
  final InventoryRepo inventory;

  CreateInventoryItemUseCase({required this.inventory});

  @override
  DataResponse<CreateInventoryItemModel> call(
      CreateInventoryItemParams params) {
    return inventory.createInventoryItem(params);
  }
}

class CreateInventoryItemParams with Params {
  final String name;
  final String unit;
  final int quantity;
  final int minimumLimit;
  final double unitCost;
  final List<int> productIds;

  CreateInventoryItemParams({
    required this.name,
    required this.unit,
    required this.quantity,
    required this.minimumLimit,
    required this.unitCost,
    required this.productIds,
  });

  @override
  QueryParams getParams() => {};

  @override
  Map<String, dynamic> getBody() => {
        'name': name,
        'unit': unit,
        'quantity': quantity,
        'minimumLimit': minimumLimit,
        'unitCost': unitCost,
        'productIds': productIds,
      };
}
