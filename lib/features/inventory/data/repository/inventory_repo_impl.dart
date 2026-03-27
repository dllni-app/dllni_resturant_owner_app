import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/error_handler.dart';

import '../../domain/repository/inventory_repo.dart';
import 'package:common_package/helpers/typedef.dart';
import '../source/inventory_remote_data_source.dart';
import '../../domain/usecases/fetch_inventory_summary_use_case.dart';
import '../models/fetch_inventory_summary_model.dart';
import '../../domain/usecases/fetch_inventory_items_use_case.dart';
import '../models/fetch_inventory_items_model.dart';
import '../../domain/usecases/create_inventory_item_use_case.dart';
import '../models/create_inventory_item_model.dart';
import '../../domain/usecases/update_inventory_item_use_case.dart';
import '../../domain/usecases/delete_inventory_item_use_case.dart';

@LazySingleton(as: InventoryRepo)
class InventoryRepoImpl with HandlingException implements InventoryRepo {
  final InventoryRemoteDataSource inventoryRemoteDataSource;

  InventoryRepoImpl({required this.inventoryRemoteDataSource});

  @override
  DataResponse<FetchInventorySummaryModel> fetchInventorySummary(FetchInventorySummaryParams params) {
    return wrapHandlingException(
      tryCall: () => inventoryRemoteDataSource.fetchInventorySummary(params),
    );
  }

  @override
  DataResponse<FetchInventoryItemsModel> fetchInventoryItems(FetchInventoryItemsParams params) {
    return wrapHandlingException(
      tryCall: () => inventoryRemoteDataSource.fetchInventoryItems(params),
    );
  }

  @override
  DataResponse<CreateInventoryItemModel> createInventoryItem(CreateInventoryItemParams params) {
    return wrapHandlingException(
      tryCall: () => inventoryRemoteDataSource.createInventoryItem(params),
    );
  }

  @override
  DataResponse<CreateInventoryItemModel> updateInventoryItem(UpdateInventoryItemParams params) {
    return wrapHandlingException(
      tryCall: () => inventoryRemoteDataSource.updateInventoryItem(params),
    );
  }

  @override
  DataResponse<CreateInventoryItemModel> deleteInventoryItem(DeleteInventoryItemParams params) {
    return wrapHandlingException(
      tryCall: () => inventoryRemoteDataSource.deleteInventoryItem(params),
    );
  }
}

