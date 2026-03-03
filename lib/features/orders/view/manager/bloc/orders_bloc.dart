import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:common_package/helpers/pagination_helper.dart';
import 'package:common_package/helpers/droppable_helper.dart';
import '../../../domain/usecases/get_orders_use_case.dart';
import '../../../data/models/get_orders_model.dart';

part 'orders_event.dart';

part 'orders_state.dart';

@injectable
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;

  OrdersBloc(this.getOrdersUseCase) : super(OrdersState()) {
    on<GetOrdersEvent>(_getOrders, transformer: droppableProMax());
  }

  EventTransformer<T> droppableProMax<T extends EventWithReload>() {
    return (events, mapper) {
      return events.transform(ExhaustMapStreamTransformer(mapper));
    };
  }

  FutureOr<void> _getOrders(GetOrdersEvent event, Emitter<OrdersState> emit) async {
    if (!state.orders!.isEndPage || event.isReload) {
      emit(state.copyWith(orders: state.orders!.setLoading(isReload: event.isReload)));
      final res = await getOrdersUseCase(event.params);
      res.fold(
        (l) {
          emit(
            state.copyWith(
              orders: state.orders!.setFaild(errorMessage: l.message),
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          emit(state.copyWith(orders: state.orders!.setSuccess(data: r.data!)));
        },
      );
    }
  }
}
