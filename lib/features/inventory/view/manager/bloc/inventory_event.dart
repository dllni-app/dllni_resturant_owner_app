part of 'inventory_bloc.dart';

abstract class InventoryEvent {}

class FetchInventorySummaryEvent extends InventoryEvent {
  final FetchInventorySummaryParams params;

  FetchInventorySummaryEvent({required this.params});
}

class FetchInventoryItemsEvent extends InventoryEvent with EventWithReload {
  final FetchInventoryItemsParams params;

  @override
  final bool isReload;

  FetchInventoryItemsEvent({required this.params, this.isReload = false});
}

class CreateInventoryItemEvent extends InventoryEvent {
  final CreateInventoryItemParams params;

  CreateInventoryItemEvent({required this.params});
}

class UpdateInventoryItemEvent extends InventoryEvent {
  final UpdateInventoryItemParams params;

  UpdateInventoryItemEvent({required this.params});
}

class DeleteInventoryItemEvent extends InventoryEvent {
  final DeleteInventoryItemParams params;
  final BuildContext context;

  DeleteInventoryItemEvent({required this.params, required this.context});
}
