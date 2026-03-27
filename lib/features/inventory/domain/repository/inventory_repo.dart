import 'package:common_package/helpers/typedef.dart';
import '../usecases/fetch_inventory_summary_use_case.dart';
import '../../data/models/fetch_inventory_summary_model.dart';
import '../usecases/fetch_inventory_items_use_case.dart';
import '../../data/models/fetch_inventory_items_model.dart';
import '../usecases/create_inventory_item_use_case.dart';
import '../../data/models/create_inventory_item_model.dart';
import '../usecases/update_inventory_item_use_case.dart';
import '../usecases/delete_inventory_item_use_case.dart';

abstract class InventoryRepo {
  DataResponse<FetchInventorySummaryModel> fetchInventorySummary(FetchInventorySummaryParams params);

  DataResponse<FetchInventoryItemsModel> fetchInventoryItems(FetchInventoryItemsParams params);

  DataResponse<CreateInventoryItemModel> createInventoryItem(CreateInventoryItemParams params);

  DataResponse<CreateInventoryItemModel> updateInventoryItem(UpdateInventoryItemParams params);

  DataResponse<CreateInventoryItemModel> deleteInventoryItem(DeleteInventoryItemParams params);
}
