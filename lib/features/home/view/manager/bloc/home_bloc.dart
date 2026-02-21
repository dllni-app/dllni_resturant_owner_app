import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:common_package/helpers/pagination_helper.dart';
import 'package:common_package/helpers/droppable_helper.dart';
import '../../../domain/usecases/get_dashboard_overview_usecase_use_case.dart';
import '../../../data/models/get_dashboard_overview_usecase_model.dart';
import '../../../domain/usecases/get_orders_usecase_use_case.dart';
import '../../../data/models/get_orders_usecase_model.dart';
import '../../../domain/usecases/get_low_stock_products_usecase_use_case.dart';
import '../../../data/models/get_low_stock_products_usecase_model.dart';
import '../../../domain/usecases/accept_order_usecase_use_case.dart';
import '../../../data/models/accept_order_usecase_model.dart';
import '../../../domain/usecases/reject_order_usecase_use_case.dart';
import '../../../data/models/reject_order_usecase_model.dart';
import '../../../domain/usecases/get_daily_analytics_usecase_use_case.dart';
import '../../../data/models/get_daily_analytics_usecase_model.dart';
import '../../../domain/usecases/get_monthly_analytics_usecase_use_case.dart';
import '../../../data/models/get_monthly_analytics_usecase_model.dart';
import '../../../domain/usecases/create_product_usecase_use_case.dart';
import '../../../data/models/create_product_usecase_model.dart';
import '../../../domain/usecases/create_offer_usecase_use_case.dart';
import '../../../data/models/create_offer_usecase_model.dart';
import '../../../domain/usecases/create_order_usecase_use_case.dart';
import '../../../data/models/create_order_usecase_model.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CreateOrderUsecaseUseCase createOrderUsecaseUseCase;
  final CreateOfferUsecaseUseCase createOfferUsecaseUseCase;
  final CreateProductUsecaseUseCase createProductUsecaseUseCase;
  final GetMonthlyAnalyticsUsecaseUseCase getMonthlyAnalyticsUsecaseUseCase;
  final GetDailyAnalyticsUsecaseUseCase getDailyAnalyticsUsecaseUseCase;
  final RejectOrderUsecaseUseCase rejectOrderUsecaseUseCase;
  final AcceptOrderUsecaseUseCase acceptOrderUsecaseUseCase;
  final GetLowStockProductsUsecaseUseCase getLowStockProductsUsecaseUseCase;
  final GetOrdersUsecaseUseCase getOrdersUsecaseUseCase;
  final GetDashboardOverviewUsecaseUseCase getDashboardOverviewUsecaseUseCase;
  HomeBloc(
    this.getDashboardOverviewUsecaseUseCase,
    this.getOrdersUsecaseUseCase,
    this.getLowStockProductsUsecaseUseCase,
    this.acceptOrderUsecaseUseCase,
    this.rejectOrderUsecaseUseCase,
    this.getDailyAnalyticsUsecaseUseCase,
    this.getMonthlyAnalyticsUsecaseUseCase,
    this.createProductUsecaseUseCase,
    this.createOfferUsecaseUseCase,
    this.createOrderUsecaseUseCase,) : super(HomeState()) {
    
  
    on<GetDashboardOverviewUsecaseEvent>(_getDashboardOverviewUsecase);
    on<GetOrdersUsecaseEvent>(_getOrdersUsecase, transformer: droppableProMax());
    on<GetLowStockProductsUsecaseEvent>(_getLowStockProductsUsecase, transformer: droppableProMax());
    on<AcceptOrderUsecaseEvent>(_acceptOrderUsecase);
    on<RejectOrderUsecaseEvent>(_rejectOrderUsecase);
    on<GetDailyAnalyticsUsecaseEvent>(_getDailyAnalyticsUsecase);
    on<GetMonthlyAnalyticsUsecaseEvent>(_getMonthlyAnalyticsUsecase);
    on<CreateProductUsecaseEvent>(_createProductUsecase);
    on<CreateOfferUsecaseEvent>(_createOfferUsecase);
    on<CreateOrderUsecaseEvent>(_createOrderUsecase);}


  EventTransformer<T> droppableProMax<T extends EventWithReload>() {
    return (events, mapper) {
      return events.transform(ExhaustMapStreamTransformer(mapper));
    };
  }

  FutureOr<void> _getDashboardOverviewUsecase(GetDashboardOverviewUsecaseEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(dashboardOverviewUsecaseStatus: BlocStatus.loading));
    final res = await getDashboardOverviewUsecaseUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        dashboardOverviewUsecaseStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        dashboardOverviewUsecaseStatus: BlocStatus.success,
        dashboardOverviewUsecase: r,
      ));
    });
  }

  FutureOr<void> _getOrdersUsecase(GetOrdersUsecaseEvent event, Emitter<HomeState> emit) async {
    if (!state.ordersUsecase!.isEndPage || event.isReload) {
      emit(state.copyWith(
        ordersUsecase: state.ordersUsecase!.setLoading(isReload: event.isReload),
      ));
      final res = await getOrdersUsecaseUseCase(event.params);
      res.fold((l) {
        emit(state.copyWith(
          ordersUsecase: state.ordersUsecase!.setFaild(errorMessage: l.message),
          errorMessage: l.message,
        ));
      }, (r) {
        emit(state.copyWith(
          ordersUsecase: state.ordersUsecase!.setSuccess(data: r.data!),
        ));
      });
    }
  }

  FutureOr<void> _getLowStockProductsUsecase(GetLowStockProductsUsecaseEvent event, Emitter<HomeState> emit) async {
    if (!state.lowStockProductsUsecase!.isEndPage || event.isReload) {
      emit(state.copyWith(
        lowStockProductsUsecase: state.lowStockProductsUsecase!.setLoading(isReload: event.isReload),
      ));
      final res = await getLowStockProductsUsecaseUseCase(event.params);
      res.fold((l) {
        emit(state.copyWith(
          lowStockProductsUsecase: state.lowStockProductsUsecase!.setFaild(errorMessage: l.message),
          errorMessage: l.message,
        ));
      }, (r) {
        emit(state.copyWith(
          lowStockProductsUsecase: state.lowStockProductsUsecase!.setSuccess(data: r.data!),
        ));
      });
    }
  }

  FutureOr<void> _acceptOrderUsecase(AcceptOrderUsecaseEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(acceptOrderUsecaseStatus: BlocStatus.loading));
    final res = await acceptOrderUsecaseUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        acceptOrderUsecaseStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        acceptOrderUsecaseStatus: BlocStatus.success,
        acceptOrderUsecase: r,
      ));
    });
  }

  FutureOr<void> _rejectOrderUsecase(RejectOrderUsecaseEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(rejectOrderUsecaseStatus: BlocStatus.loading));
    final res = await rejectOrderUsecaseUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        rejectOrderUsecaseStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        rejectOrderUsecaseStatus: BlocStatus.success,
        rejectOrderUsecase: r,
      ));
    });
  }

  FutureOr<void> _getDailyAnalyticsUsecase(GetDailyAnalyticsUsecaseEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(dailyAnalyticsUsecaseStatus: BlocStatus.loading));
    final res = await getDailyAnalyticsUsecaseUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        dailyAnalyticsUsecaseStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        dailyAnalyticsUsecaseStatus: BlocStatus.success,
        dailyAnalyticsUsecase: r,
      ));
    });
  }

  FutureOr<void> _getMonthlyAnalyticsUsecase(GetMonthlyAnalyticsUsecaseEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(monthlyAnalyticsUsecaseStatus: BlocStatus.loading));
    final res = await getMonthlyAnalyticsUsecaseUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        monthlyAnalyticsUsecaseStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        monthlyAnalyticsUsecaseStatus: BlocStatus.success,
        monthlyAnalyticsUsecase: r,
      ));
    });
  }

  FutureOr<void> _createProductUsecase(CreateProductUsecaseEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(productUsecaseStatus: BlocStatus.loading));
    final res = await createProductUsecaseUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        productUsecaseStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        productUsecaseStatus: BlocStatus.success,
        productUsecase: r,
      ));
    });
  }

  FutureOr<void> _createOfferUsecase(CreateOfferUsecaseEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(offerUsecaseStatus: BlocStatus.loading));
    final res = await createOfferUsecaseUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        offerUsecaseStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        offerUsecaseStatus: BlocStatus.success,
        offerUsecase: r,
      ));
    });
  }

  FutureOr<void> _createOrderUsecase(CreateOrderUsecaseEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(orderUsecaseStatus: BlocStatus.loading));
    final res = await createOrderUsecaseUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        orderUsecaseStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        orderUsecaseStatus: BlocStatus.success,
        orderUsecase: r,
      ));
    });
  }}
