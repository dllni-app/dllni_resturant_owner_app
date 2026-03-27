import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:common_package/helpers/pagination_helper.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/usecases/fetch_inventory_summary_use_case.dart';
import '../../../data/models/fetch_inventory_summary_model.dart';
import 'package:common_package/helpers/droppable_helper.dart';
import '../../../domain/usecases/fetch_inventory_items_use_case.dart';
import '../../../data/models/fetch_inventory_items_model.dart';
import '../../../domain/usecases/create_inventory_item_use_case.dart';
import '../../../data/models/create_inventory_item_model.dart';
import '../../../domain/usecases/update_inventory_item_use_case.dart';
import '../../../domain/usecases/delete_inventory_item_use_case.dart';

part 'inventory_event.dart';

part 'inventory_state.dart';

@injectable
class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final FetchInventoryItemsUseCase fetchInventoryItemsUseCase;
  final FetchInventorySummaryUseCase fetchInventorySummaryUseCase;
  final CreateInventoryItemUseCase createInventoryItemUseCase;
  final UpdateInventoryItemUseCase updateInventoryItemUseCase;
  final DeleteInventoryItemUseCase deleteInventoryItemUseCase;

  InventoryBloc(
    this.fetchInventorySummaryUseCase,
    this.fetchInventoryItemsUseCase,
    this.createInventoryItemUseCase,
    this.updateInventoryItemUseCase,
    this.deleteInventoryItemUseCase,
  ) : super(InventoryState()) {
    on<FetchInventorySummaryEvent>(_fetchInventorySummary);
    on<FetchInventoryItemsEvent>(_fetchInventoryItems, transformer: droppableProMax());
    on<CreateInventoryItemEvent>(_createInventoryItem);
    on<UpdateInventoryItemEvent>(_updateInventoryItem);
    on<DeleteInventoryItemEvent>(_deleteInventoryItem);
  }

  FutureOr<void> _fetchInventorySummary(FetchInventorySummaryEvent event, Emitter<InventoryState> emit) async {
    emit(state.copyWith(inventorySummaryStatus: BlocStatus.loading));
    final res = await fetchInventorySummaryUseCase(event.params);
    res.fold(
      (l) {
        emit(state.copyWith(inventorySummaryStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(inventorySummaryStatus: BlocStatus.success, inventorySummary: r));
      },
    );
  }

  EventTransformer<T> droppableProMax<T extends EventWithReload>() {
    return (events, mapper) {
      return events.transform(ExhaustMapStreamTransformer(mapper));
    };
  }

  FutureOr<void> _fetchInventoryItems(FetchInventoryItemsEvent event, Emitter<InventoryState> emit) async {
    if (!state.inventoryItems!.isEndPage || event.isReload) {
      emit(state.copyWith(inventoryItems: state.inventoryItems!.setLoading(isReload: event.isReload)));
      final res = await fetchInventoryItemsUseCase(event.params);
      res.fold(
        (l) {
          emit(
            state.copyWith(
              inventoryItems: state.inventoryItems!.setFaild(errorMessage: l.message),
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          emit(state.copyWith(inventoryItems: state.inventoryItems!.setSuccess(data: r.data!)));
        },
      );
    }
  }

  FutureOr<void> _createInventoryItem(CreateInventoryItemEvent event, Emitter<InventoryState> emit) async {
    emit(state.copyWith(createInventoryItemStatus: BlocStatus.loading));
    final res = await createInventoryItemUseCase(event.params);
    res.fold(
      (l) {
        emit(state.copyWith(createInventoryItemStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        add(FetchInventoryItemsEvent(params: FetchInventoryItemsParams(), isReload: true));
        emit(state.copyWith(createInventoryItemStatus: BlocStatus.success, createInventoryItemModel: r));
      },
    );
  }

  FutureOr<void> _updateInventoryItem(UpdateInventoryItemEvent event, Emitter<InventoryState> emit) async {
    emit(state.copyWith(updateInventoryItemStatus: BlocStatus.loading));
    final res = await updateInventoryItemUseCase(event.params);
    res.fold(
      (l) {
        emit(state.copyWith(updateInventoryItemStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        add(FetchInventoryItemsEvent(params: FetchInventoryItemsParams(), isReload: true));
        emit(state.copyWith(updateInventoryItemStatus: BlocStatus.success, createInventoryItemModel: r));
      },
    );
  }

  FutureOr<void> _deleteInventoryItem(DeleteInventoryItemEvent event, Emitter<InventoryState> emit) async {
    Loading.show(event.context);
    emit(state.copyWith(deleteInventoryItemStatus: BlocStatus.loading));
    final res = await deleteInventoryItemUseCase(event.params);
    res.fold(
      (l) {
        Loading.close();
        AppToast.showToast(context: event.context, message: l.message, type: ToastificationType.error);
        emit(state.copyWith(deleteInventoryItemStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        Loading.close();
        add(FetchInventoryItemsEvent(params: FetchInventoryItemsParams(), isReload: true));
        emit(state.copyWith(deleteInventoryItemStatus: BlocStatus.success, createInventoryItemModel: r));
      },
    );
  }
}
