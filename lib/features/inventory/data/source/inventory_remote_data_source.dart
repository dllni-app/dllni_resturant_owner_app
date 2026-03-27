import 'package:common_package/common_package.dart';
import 'package:injectable/injectable.dart';
import '../models/fetch_inventory_summary_model.dart';
import '../../domain/usecases/fetch_inventory_summary_use_case.dart';
import '../models/fetch_inventory_items_model.dart';
import '../../domain/usecases/fetch_inventory_items_use_case.dart';
import '../models/create_inventory_item_model.dart';
import '../../domain/usecases/create_inventory_item_use_case.dart';
import '../../domain/usecases/update_inventory_item_use_case.dart';
import '../../domain/usecases/delete_inventory_item_use_case.dart';

@lazySingleton
class InventoryRemoteDataSource with HandlingApiManager {
  final DioNetwork dioNetwork;

  InventoryRemoteDataSource({required this.dioNetwork});

  Future<FetchInventorySummaryModel> fetchInventorySummary(FetchInventorySummaryParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant/inventory-summary', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchInventorySummaryModelFromJson,
    );
  }

  Future<FetchInventoryItemsModel> fetchInventoryItems(FetchInventoryItemsParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/inventory-items', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchInventoryItemsModelFromJson,
    );
  }

  Future<CreateInventoryItemModel> createInventoryItem(CreateInventoryItemParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(endPoint: '/api/v1/inventory-items', data: params.getBody()),
      jsonConvert: createInventoryItemModelFromJson,
    );
  }

  Future<CreateInventoryItemModel> updateInventoryItem(UpdateInventoryItemParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.putData(endPoint: '/api/v1/inventory-items/${params.id}', data: params.getBody(), params: params.getParams()),
      jsonConvert: createInventoryItemModelFromJson,
    );
  }

  Future<CreateInventoryItemModel> deleteInventoryItem(DeleteInventoryItemParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.deleteData(endPoint: '/api/v1/inventory-items/${params.id}', data: params.getBody(), params: params.getParams()),
      jsonConvert: createInventoryItemModelFromJson,
    );
  }
}