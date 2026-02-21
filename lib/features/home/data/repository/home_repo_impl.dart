import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/error_handler.dart';

import '../../domain/repository/home_repo.dart';
import 'package:common_package/helpers/typedef.dart';
import '../source/home_remote_data_source.dart';
import '../../domain/usecases/get_dashboard_overview_usecase_use_case.dart';
import '../models/get_dashboard_overview_usecase_model.dart';
import '../../domain/usecases/get_orders_usecase_use_case.dart';
import '../models/get_orders_usecase_model.dart';
import '../../domain/usecases/get_low_stock_products_usecase_use_case.dart';
import '../models/get_low_stock_products_usecase_model.dart';
import '../../domain/usecases/accept_order_usecase_use_case.dart';
import '../models/accept_order_usecase_model.dart';
import '../../domain/usecases/reject_order_usecase_use_case.dart';
import '../models/reject_order_usecase_model.dart';
import '../../domain/usecases/get_daily_analytics_usecase_use_case.dart';
import '../models/get_daily_analytics_usecase_model.dart';
import '../../domain/usecases/get_monthly_analytics_usecase_use_case.dart';
import '../models/get_monthly_analytics_usecase_model.dart';
import '../../domain/usecases/create_product_usecase_use_case.dart';
import '../models/create_product_usecase_model.dart';
import '../../domain/usecases/create_offer_usecase_use_case.dart';
import '../models/create_offer_usecase_model.dart';
import '../../domain/usecases/create_order_usecase_use_case.dart';
import '../models/create_order_usecase_model.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl with HandlingException implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});

  @override
  DataResponse<GetDashboardOverviewUsecaseModel> getDashboardOverviewUsecase(GetDashboardOverviewUsecaseParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.getDashboardOverviewUsecase(params),
    );
  }

  @override
  DataResponse<GetOrdersUsecaseModel> getOrdersUsecase(GetOrdersUsecaseParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.getOrdersUsecase(params),
    );
  }

  @override
  DataResponse<GetLowStockProductsUsecaseModel> getLowStockProductsUsecase(GetLowStockProductsUsecaseParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.getLowStockProductsUsecase(params),
    );
  }

  @override
  DataResponse<AcceptOrderUsecaseModel> acceptOrderUsecase(AcceptOrderUsecaseParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.acceptOrderUsecase(params),
    );
  }

  @override
  DataResponse<RejectOrderUsecaseModel> rejectOrderUsecase(RejectOrderUsecaseParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.rejectOrderUsecase(params),
    );
  }

  @override
  DataResponse<GetDailyAnalyticsUsecaseModel> getDailyAnalyticsUsecase(GetDailyAnalyticsUsecaseParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.getDailyAnalyticsUsecase(params),
    );
  }

  @override
  DataResponse<GetMonthlyAnalyticsUsecaseModel> getMonthlyAnalyticsUsecase(GetMonthlyAnalyticsUsecaseParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.getMonthlyAnalyticsUsecase(params),
    );
  }

  @override
  DataResponse<CreateProductUsecaseModel> createProductUsecase(CreateProductUsecaseParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.createProductUsecase(params),
    );
  }

  @override
  DataResponse<CreateOfferUsecaseModel> createOfferUsecase(CreateOfferUsecaseParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.createOfferUsecase(params),
    );
  }

  @override
  DataResponse<CreateOrderUsecaseModel> createOrderUsecase(CreateOrderUsecaseParams params) {
    return wrapHandlingException(
      tryCall: () => homeRemoteDataSource.createOrderUsecase(params),
    );
  }}

