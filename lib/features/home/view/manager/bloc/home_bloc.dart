import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:common_package/helpers/pagination_helper.dart';
import '../../../domain/usecases/fetch_notifications_use_case.dart';
import '../../../domain/usecases/read_all_notifications_use_case.dart';
import '../../../data/models/fetch_notifications_model.dart';
import '../../../domain/usecases/home_overview_use_case.dart';
import '../../../data/models/home_overview_model.dart';
import '../../../domain/usecases/home_overview_performance_use_case.dart';
import '../../../data/models/home_overview_performance_model.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeOverviewPerformanceUseCase homeOverviewPerformanceUseCase;
  final HomeOverviewUseCase homeOverviewUseCase;
  final FetchNotificationsUseCase fetchNotificationsUseCase;
  final ReadAllNotificationsUseCase readAllNotificationsUseCase;

  HomeBloc(this.fetchNotificationsUseCase, this.readAllNotificationsUseCase, this.homeOverviewUseCase, this.homeOverviewPerformanceUseCase)
      : super(HomeState()) {
    on<FetchNotificationsEvent>(_fetchNotifications);
    on<HomeOverviewEvent>(_homeOverview);

    on<HomeOverviewPerformanceEvent>(_homeOverviewPerformance);
  }

  FutureOr<void> _fetchNotifications(FetchNotificationsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(notificationsStatus: BlocStatus.loading));
    final res = await fetchNotificationsUseCase(event.params);
    await res.fold(
      (l) async {
        emit(state.copyWith(notificationsStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) async {
        emit(state.copyWith(notificationsStatus: BlocStatus.success, notifications: r));
        final readRes = await readAllNotificationsUseCase(ReadAllNotificationsParams(tab: event.params.status));
        readRes.fold((_) {}, (_) {});
      },
    );
  }

  FutureOr<void> _homeOverview(HomeOverviewEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(homeOverviewStatus: BlocStatus.loading));
    final res = await homeOverviewUseCase(event.params);
    res.fold(
      (l) {
        emit(state.copyWith(homeOverviewStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(homeOverviewStatus: BlocStatus.success, homeOverview: r));
      },
    );
  }

  FutureOr<void> _homeOverviewPerformance(HomeOverviewPerformanceEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(homeOverviewPerformanceStatus: BlocStatus.loading));
    final res = await homeOverviewPerformanceUseCase(event.params);
    res.fold(
      (l) {
        emit(state.copyWith(homeOverviewPerformanceStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(homeOverviewPerformanceStatus: BlocStatus.success, homeOverviewPerformance: r));
      },
    );
  }
}
