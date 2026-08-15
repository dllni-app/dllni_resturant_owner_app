import 'package:common_package/common_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
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

  HomeBloc(
    this.fetchNotificationsUseCase,
    this.readAllNotificationsUseCase,
    this.homeOverviewUseCase,
    this.homeOverviewPerformanceUseCase,
  ) : super(HomeState()) {
    on<FetchNotificationsEvent>(_fetchNotifications);
    on<HomeOverviewEvent>(_homeOverview);
    on<HomeOverviewPerformanceEvent>(_homeOverviewPerformance);
    on<ReadAllNotificationsEvent>(_readAllNotifications);
    on<ReadNotificationEvent>(_readNotification);
    on<DeleteNotificationEvent>(_deleteNotification);
    on<DeleteAllNotificationsEvent>(_deleteAllNotifications);
  }

  FutureOr<void> _fetchNotifications(
    FetchNotificationsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(notificationsStatus: BlocStatus.loading));
    final res = await fetchNotificationsUseCase(event.params);
    await res.fold(
      (l) async {
        emit(
          state.copyWith(
            notificationsStatus: BlocStatus.failed,
            errorMessage: l.message,
          ),
        );
      },
      (r) async {
        emit(
          state.copyWith(
            notificationsStatus: BlocStatus.success,
            notifications: r,
            unreadNumber: r.meta?.unreadTotal,
          ),
        );
      },
    );
  }

  FutureOr<void> _readAllNotifications(
    ReadAllNotificationsEvent event,
    Emitter<HomeState> emit,
  ) async {
    final unreadLocal = state.unreadNumber;
    emit(
      state.copyWith(
        readNotificationsStatus: BlocStatus.loading,
        unreadNumber: 0,
      ),
    );
    final res = await readAllNotificationsUseCase(NoParams());
    res.fold(
      (l) {
        emit(
          state.copyWith(
            readNotificationsStatus: BlocStatus.failed,
            errorMessage: l.message,
            unreadNumber: unreadLocal,
          ),
        );
      },
      (_) {
        final updatedNotifications = (state.notifications?.data ?? [])
            .map((e) => e.copyWith(isRead: true))
            .toList();
        emit(
          state.copyWith(
            unreadNumber: 0,
            readNotificationsStatus: BlocStatus.success,
            notifications: FetchNotificationsModel(
              data: updatedNotifications,
              meta: state.notifications?.meta,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _readNotification(
    ReadNotificationEvent event,
    Emitter<HomeState> emit,
  ) async {
    final id = event.id.trim();
    if (id.isEmpty) return;

    final notifications = state.notifications?.data ?? const <FetchNotificationsModelDataItem>[];
    final wasUnread = notifications.any((item) => item.id == id && item.isRead != true);
    final res = await readAllNotificationsUseCase.readOne(id);
    res.fold(
      (l) => emit(state.copyWith(errorMessage: l.message)),
      (_) {
        final updated = notifications
            .map((item) => item.id == id ? item.copyWith(isRead: true) : item)
            .toList();
        final currentUnread = state.unreadNumber ?? 0;
        emit(
          state.copyWith(
            notifications: FetchNotificationsModel(
              data: updated,
              meta: state.notifications?.meta,
            ),
            unreadNumber: wasUnread && currentUnread > 0
                ? currentUnread - 1
                : currentUnread,
          ),
        );
      },
    );
  }

  FutureOr<void> _deleteNotification(
    DeleteNotificationEvent event,
    Emitter<HomeState> emit,
  ) async {
    final id = event.id.trim();
    if (id.isEmpty) return;

    final notifications = state.notifications?.data ?? const <FetchNotificationsModelDataItem>[];
    FetchNotificationsModelDataItem? target;
    for (final item in notifications) {
      if (item.id == id) {
        target = item;
        break;
      }
    }
    final wasUnread = target != null && target.isRead != true;
    final res = await readAllNotificationsUseCase.deleteOne(id);
    res.fold(
      (l) {
        emit(state.copyWith(errorMessage: l.message));
        add(FetchNotificationsEvent(params: FetchNotificationsParams(status: 'all')));
      },
      (_) {
        final updated = notifications.where((item) => item.id != id).toList();
        final currentUnread = state.unreadNumber ?? 0;
        emit(
          state.copyWith(
            notifications: FetchNotificationsModel(
              data: updated,
              meta: state.notifications?.meta,
            ),
            unreadNumber: wasUnread && currentUnread > 0
                ? currentUnread - 1
                : currentUnread,
          ),
        );
      },
    );
  }

  FutureOr<void> _deleteAllNotifications(
    DeleteAllNotificationsEvent event,
    Emitter<HomeState> emit,
  ) async {
    final res = await readAllNotificationsUseCase.deleteAll();
    res.fold(
      (l) => emit(state.copyWith(errorMessage: l.message)),
      (_) => emit(
        state.copyWith(
          notifications: FetchNotificationsModel(
            data: const <FetchNotificationsModelDataItem>[],
            meta: state.notifications?.meta,
          ),
          unreadNumber: 0,
        ),
      ),
    );
  }

  FutureOr<void> _homeOverview(
    HomeOverviewEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(homeOverviewStatus: BlocStatus.loading));
    final res = await homeOverviewUseCase(event.params);
    res.fold(
      (l) {
        emit(
          state.copyWith(
            homeOverviewStatus: BlocStatus.failed,
            errorMessage: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            homeOverviewStatus: BlocStatus.success,
            homeOverview: r,
          ),
        );
      },
    );
  }

  FutureOr<void> _homeOverviewPerformance(
    HomeOverviewPerformanceEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(homeOverviewPerformanceStatus: BlocStatus.loading));
    final res = await homeOverviewPerformanceUseCase(event.params);
    res.fold(
      (l) {
        emit(
          state.copyWith(
            homeOverviewPerformanceStatus: BlocStatus.failed,
            errorMessage: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            homeOverviewPerformanceStatus: BlocStatus.success,
            homeOverviewPerformance: r,
          ),
        );
      },
    );
  }
}
