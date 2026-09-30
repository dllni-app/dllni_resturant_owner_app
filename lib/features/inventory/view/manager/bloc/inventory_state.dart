part of 'inventory_bloc.dart';

class InventoryState {
  PaginationStateModel<FetchInventoryItemsModelDataItem>? inventoryItems;
  BlocStatus? inventorySummaryStatus;
  FetchInventorySummaryModel? inventorySummary;
  BlocStatus? createInventoryItemStatus;
  BlocStatus? updateInventoryItemStatus;
  BlocStatus? deleteInventoryItemStatus;
  CreateInventoryItemModel? createInventoryItemModel;
  String? currentStatus;
  String? errorMessage;

  InventoryState({
    this.errorMessage,
    this.inventorySummary,
    this.inventorySummaryStatus,
    this.createInventoryItemStatus,
    this.updateInventoryItemStatus,
    this.deleteInventoryItemStatus,
    this.createInventoryItemModel,
    this.currentStatus,
    this.inventoryItems = const PaginationStateModel(perPage: 10),
  });

  InventoryState copyWith({
    String? errorMessage,
    FetchInventorySummaryModel? inventorySummary,
    BlocStatus? inventorySummaryStatus,
    BlocStatus? createInventoryItemStatus,
    BlocStatus? updateInventoryItemStatus,
    BlocStatus? deleteInventoryItemStatus,
    CreateInventoryItemModel? createInventoryItemModel,
    String? currentStatus,
    bool setCurrentStatus = false,
    PaginationStateModel<FetchInventoryItemsModelDataItem>? inventoryItems,
  }) => InventoryState(
    errorMessage: errorMessage ?? this.errorMessage,
    inventorySummary: inventorySummary ?? this.inventorySummary,
    inventorySummaryStatus: inventorySummaryStatus ?? this.inventorySummaryStatus,
    createInventoryItemStatus: createInventoryItemStatus ?? this.createInventoryItemStatus,
    updateInventoryItemStatus: updateInventoryItemStatus ?? this.updateInventoryItemStatus,
    deleteInventoryItemStatus: deleteInventoryItemStatus ?? this.deleteInventoryItemStatus,
    createInventoryItemModel: createInventoryItemModel ?? this.createInventoryItemModel,
    currentStatus: setCurrentStatus ? currentStatus : this.currentStatus,
    inventoryItems: inventoryItems ?? this.inventoryItems,
  );
}
