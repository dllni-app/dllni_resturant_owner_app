import 'dart:async';

import 'package:common_package/helpers/droppable_helper.dart';
import 'package:common_package/helpers/pagination_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/accept_order_model.dart';
import '../../../data/models/get_orders_model.dart';
import '../../../data/models/owner_order_details_model.dart';
import '../../../data/models/reject_order_model.dart';
import '../../../domain/usecases/accept_order_use_case.dart';
import '../../../domain/usecases/add_order_item_use_case.dart';
import '../../../domain/usecases/change_order_status_use_case.dart';
import '../../../domain/usecases/delete_order_item_use_case.dart';
import '../../../domain/usecases/get_order_details_use_case.dart';
import '../../../domain/usecases/get_orders_use_case.dart';
import '../../../domain/usecases/reject_order_use_case.dart';
import '../../../domain/usecases/update_order_item_use_case.dart';

part 'orders_event.dart';
part 'orders_state.dart';

@injectable
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final RejectOrderUseCase rejectOrderUseCase;
  final AcceptOrderUseCase acceptOrderUseCase;
  final GetOrdersUseCase getOrdersUseCase;

  OrdersBloc(this.getOrdersUseCase, this.acceptOrderUseCase, this.rejectOrderUseCase) : super(OrdersState()) {
    on<GetOrdersEvent>(_getOrders, transformer: droppableProMax());
    on<GetHomePreparingOrdersEvent>(_getHomePreparingOrders);
    on<GetOrderDetailsEvent>(_getOrderDetails);
    on<AcceptOrderEvent>(_acceptOrder);
    on<RejectOrderEvent>(_rejectOrder);
    on<ChangeOrderStatusEvent>(_changeOrderStatus);
    on<AddOrderItemEvent>(_addOrderItem);
    on<UpdateOrderItemEvent>(_updateOrderItem);
    on<DeleteOrderItemEvent>(_deleteOrderItem);
  }

  EventTransformer<T> droppableProMax<T extends EventWithReload>() => (events, mapper) => events.transform(ExhaustMapStreamTransformer(mapper));

  FutureOr<void> _getOrders(GetOrdersEvent event, Emitter<OrdersState> emit) async {
    if (state.orders!.isEndPage && !event.isReload) return;
    if (state.orders!.status == BlocStatus.loading && !event.isReload) return;
    emit(state.copyWith(orders: state.orders!.setLoading(isReload: event.isReload), currentStatus: event.params.status, setCurrentStatus: true));
    final res = await getOrdersUseCase(event.params);
    res.fold(
      (l) => emit(state.copyWith(orders: state.orders!.setFaild(errorMessage: l.message), errorMessage: l.message)),
      (r) => emit(state.copyWith(orders: state.orders!.setSuccess(data: r.data ?? []))),
    );
  }

  FutureOr<void> _getHomePreparingOrders(GetHomePreparingOrdersEvent event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(homePreparingOrdersStatus: BlocStatus.loading));
    final res = await getOrdersUseCase(event.params);
    res.fold(
      (l) => emit(state.copyWith(homePreparingOrdersStatus: BlocStatus.failed, errorMessage: l.message)),
      (r) => emit(state.copyWith(homePreparingOrdersStatus: BlocStatus.success, homePreparingOrders: r)),
    );
  }

  FutureOr<void> _getOrderDetails(GetOrderDetailsEvent event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(orderDetailsStatus: BlocStatus.loading));
    final res = await getOrdersUseCase.orders.getOrderDetails(event.params);
    res.fold(
      (l) => emit(state.copyWith(orderDetailsStatus: BlocStatus.failed, errorMessage: l.message)),
      (r) => emit(state.copyWith(orderDetailsStatus: BlocStatus.success, orderDetails: r)),
    );
  }

  FutureOr<void> _acceptOrder(AcceptOrderEvent event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(acceptOrderStatus: BlocStatus.loading));
    final res = await acceptOrderUseCase(event.params);
    res.fold(
      (l) => emit(state.copyWith(acceptOrderStatus: BlocStatus.failed, errorMessage: l.message)),
      (r) {
        add(GetOrdersEvent(params: GetOrdersParams(page: 1, status: state.currentStatus), isReload: true));
        add(GetHomePreparingOrdersEvent(params: GetOrdersParams(page: 1, status: 'preparing')));
        emit(state.copyWith(acceptOrderStatus: BlocStatus.success, acceptOrder: r));
      },
    );
  }

  FutureOr<void> _rejectOrder(RejectOrderEvent event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(rejectOrderStatus: BlocStatus.loading));
    final res = await rejectOrderUseCase(event.params);
    res.fold(
      (l) => emit(state.copyWith(rejectOrderStatus: BlocStatus.failed, errorMessage: l.message)),
      (r) {
        add(GetOrdersEvent(params: GetOrdersParams(page: 1, status: state.currentStatus), isReload: true));
        add(GetHomePreparingOrdersEvent(params: GetOrdersParams(page: 1, status: 'preparing')));
        emit(state.copyWith(rejectOrderStatus: BlocStatus.success, rejectOrder: r));
      },
    );
  }

  FutureOr<void> _changeOrderStatus(ChangeOrderStatusEvent event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(changeOrderStatusStatus: BlocStatus.loading));
    final res = await getOrdersUseCase.orders.changeOrderStatus(event.params);
    res.fold(
      (l) => emit(state.copyWith(changeOrderStatusStatus: BlocStatus.failed, errorMessage: l.message)),
      (r) {
        emit(state.copyWith(changeOrderStatusStatus: BlocStatus.success, statusChangedOrder: r, orderDetails: r));
        add(GetOrdersEvent(params: GetOrdersParams(page: 1, status: state.currentStatus), isReload: true));
        add(GetHomePreparingOrdersEvent(params: GetOrdersParams(page: 1, status: 'preparing')));
        add(GetOrderDetailsEvent(params: GetOrderDetailsParams(orderId: event.params.orderId)));
      },
    );
  }

  FutureOr<void> _addOrderItem(AddOrderItemEvent event, Emitter<OrdersState> emit) => _mutateOrderItem(emit, () => getOrdersUseCase.orders.addOrderItem(event.params), event.params.orderId);
  FutureOr<void> _updateOrderItem(UpdateOrderItemEvent event, Emitter<OrdersState> emit) => _mutateOrderItem(emit, () => getOrdersUseCase.orders.updateOrderItem(event.params), event.params.orderId);
  FutureOr<void> _deleteOrderItem(DeleteOrderItemEvent event, Emitter<OrdersState> emit) => _mutateOrderItem(emit, () => getOrdersUseCase.orders.deleteOrderItem(event.params), event.params.orderId);

  Future<void> _mutateOrderItem(Emitter<OrdersState> emit, Future<dynamic> Function() call, int orderId) async {
    emit(state.copyWith(orderItemMutationStatus: BlocStatus.loading));
    final res = await call();
    res.fold(
      (l) => emit(state.copyWith(orderItemMutationStatus: BlocStatus.failed, errorMessage: l.message)),
      (r) {
        emit(state.copyWith(orderItemMutationStatus: BlocStatus.success, orderDetails: r));
        add(GetOrderDetailsEvent(params: GetOrderDetailsParams(orderId: orderId)));
      },
    );
  }
}
