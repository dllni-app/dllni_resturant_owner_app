import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/inventory_repo.dart';
import '../../data/models/create_inventory_item_model.dart';

@lazySingleton
class DeleteInventoryItemUseCase
    implements UseCase<CreateInventoryItemModel, DeleteInventoryItemParams> {
  final InventoryRepo inventory;

  DeleteInventoryItemUseCase({required this.inventory});

  @override
  DataResponse<CreateInventoryItemModel> call(DeleteInventoryItemParams params) {
    return inventory.deleteInventoryItem(params);
  }
}

class DeleteInventoryItemParams with Params {
  final int id;

  DeleteInventoryItemParams({required this.id});

  @override
  QueryParams getParams() => {};

  @override
  Map<String, dynamic> getBody() => {};
}
