part of 'home_bloc.dart';

class HomeState {
  BlocStatus? orderUsecaseStatus;
  CreateOrderUsecaseModel? orderUsecase;
  BlocStatus? offerUsecaseStatus;
  CreateOfferUsecaseModel? offerUsecase;
  BlocStatus? productUsecaseStatus;
  CreateProductUsecaseModel? productUsecase;
  BlocStatus? monthlyAnalyticsUsecaseStatus;
  GetMonthlyAnalyticsUsecaseModel? monthlyAnalyticsUsecase;
  BlocStatus? dailyAnalyticsUsecaseStatus;
  GetDailyAnalyticsUsecaseModel? dailyAnalyticsUsecase;
  BlocStatus? rejectOrderUsecaseStatus;
  RejectOrderUsecaseModel? rejectOrderUsecase;
  BlocStatus? acceptOrderUsecaseStatus;
  AcceptOrderUsecaseModel? acceptOrderUsecase;
  PaginationStateModel<GetLowStockProductsUsecaseModelDataItem>? lowStockProductsUsecase;
  PaginationStateModel<GetOrdersUsecaseModelDataItem>? ordersUsecase;
  BlocStatus? dashboardOverviewUsecaseStatus;
  GetDashboardOverviewUsecaseModel? dashboardOverviewUsecase;
  String? errorMessage;

  HomeState({
    this.errorMessage,
    this.dashboardOverviewUsecase,
    this.dashboardOverviewUsecaseStatus,
    this.ordersUsecase = const PaginationStateModel(perPage: 10),
    this.lowStockProductsUsecase = const PaginationStateModel(perPage: 10),
    this.acceptOrderUsecase,
    this.acceptOrderUsecaseStatus,
    this.rejectOrderUsecase,
    this.rejectOrderUsecaseStatus,
    this.dailyAnalyticsUsecase,
    this.dailyAnalyticsUsecaseStatus,
    this.monthlyAnalyticsUsecase,
    this.monthlyAnalyticsUsecaseStatus,
    this.productUsecase,
    this.productUsecaseStatus,
    this.offerUsecase,
    this.offerUsecaseStatus,
    this.orderUsecase,
    this.orderUsecaseStatus,
  });

  HomeState copyWith({
    String? errorMessage,
    GetDashboardOverviewUsecaseModel? dashboardOverviewUsecase,
    BlocStatus? dashboardOverviewUsecaseStatus,
    PaginationStateModel<GetOrdersUsecaseModelDataItem>? ordersUsecase,
    PaginationStateModel<GetLowStockProductsUsecaseModelDataItem>? lowStockProductsUsecase,
    AcceptOrderUsecaseModel? acceptOrderUsecase,
    BlocStatus? acceptOrderUsecaseStatus,
    RejectOrderUsecaseModel? rejectOrderUsecase,
    BlocStatus? rejectOrderUsecaseStatus,
    GetDailyAnalyticsUsecaseModel? dailyAnalyticsUsecase,
    BlocStatus? dailyAnalyticsUsecaseStatus,
    GetMonthlyAnalyticsUsecaseModel? monthlyAnalyticsUsecase,
    BlocStatus? monthlyAnalyticsUsecaseStatus,
    CreateProductUsecaseModel? productUsecase,
    BlocStatus? productUsecaseStatus,
    CreateOfferUsecaseModel? offerUsecase,
    BlocStatus? offerUsecaseStatus,
    CreateOrderUsecaseModel? orderUsecase,
    BlocStatus? orderUsecaseStatus,
  }) =>
      HomeState(
        errorMessage: errorMessage ?? this.errorMessage,
        dashboardOverviewUsecase: dashboardOverviewUsecase ?? this.dashboardOverviewUsecase,
        dashboardOverviewUsecaseStatus: dashboardOverviewUsecaseStatus ?? this.dashboardOverviewUsecaseStatus,
        ordersUsecase: ordersUsecase ?? this.ordersUsecase,
        lowStockProductsUsecase: lowStockProductsUsecase ?? this.lowStockProductsUsecase,
        acceptOrderUsecase: acceptOrderUsecase ?? this.acceptOrderUsecase,
        acceptOrderUsecaseStatus: acceptOrderUsecaseStatus ?? this.acceptOrderUsecaseStatus,
        rejectOrderUsecase: rejectOrderUsecase ?? this.rejectOrderUsecase,
        rejectOrderUsecaseStatus: rejectOrderUsecaseStatus ?? this.rejectOrderUsecaseStatus,
        dailyAnalyticsUsecase: dailyAnalyticsUsecase ?? this.dailyAnalyticsUsecase,
        dailyAnalyticsUsecaseStatus: dailyAnalyticsUsecaseStatus ?? this.dailyAnalyticsUsecaseStatus,
        monthlyAnalyticsUsecase: monthlyAnalyticsUsecase ?? this.monthlyAnalyticsUsecase,
        monthlyAnalyticsUsecaseStatus: monthlyAnalyticsUsecaseStatus ?? this.monthlyAnalyticsUsecaseStatus,
        productUsecase: productUsecase ?? this.productUsecase,
        productUsecaseStatus: productUsecaseStatus ?? this.productUsecaseStatus,
        offerUsecase: offerUsecase ?? this.offerUsecase,
        offerUsecaseStatus: offerUsecaseStatus ?? this.offerUsecaseStatus,
        orderUsecase: orderUsecase ?? this.orderUsecase,
        orderUsecaseStatus: orderUsecaseStatus ?? this.orderUsecaseStatus,
      );}
