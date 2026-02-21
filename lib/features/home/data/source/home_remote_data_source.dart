import 'package:common_package/helpers/dio_network.dart';
import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/api_handler.dart';
import '../models/get_dashboard_overview_usecase_model.dart';
import '../../domain/usecases/get_dashboard_overview_usecase_use_case.dart';
import '../models/get_orders_usecase_model.dart';
import '../../domain/usecases/get_orders_usecase_use_case.dart';
import '../models/get_low_stock_products_usecase_model.dart';
import '../../domain/usecases/get_low_stock_products_usecase_use_case.dart';
import '../models/accept_order_usecase_model.dart';
import '../../domain/usecases/accept_order_usecase_use_case.dart';
import '../models/reject_order_usecase_model.dart';
import '../../domain/usecases/reject_order_usecase_use_case.dart';
import '../models/get_daily_analytics_usecase_model.dart';
import '../../domain/usecases/get_daily_analytics_usecase_use_case.dart';
import '../models/get_monthly_analytics_usecase_model.dart';
import '../../domain/usecases/get_monthly_analytics_usecase_use_case.dart';
import '../models/create_product_usecase_model.dart';
import '../../domain/usecases/create_product_usecase_use_case.dart';
import '../models/create_offer_usecase_model.dart';
import '../../domain/usecases/create_offer_usecase_use_case.dart';
import '../models/create_order_usecase_model.dart';
import '../../domain/usecases/create_order_usecase_use_case.dart';

@lazySingleton
class HomeRemoteDataSource with HandlingApiManager {
  final DioNetwork dioNetwork;

  HomeRemoteDataSource({required this.dioNetwork});

  Future<GetDashboardOverviewUsecaseModel> getDashboardOverviewUsecase(GetDashboardOverviewUsecaseParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(
        endPoint: '/restaurant/dashboard/overview',
        params: params.getParams(),
        data: params.getBody().isEmpty ? null : params.getBody(),
      ),
      jsonConvert: getDashboardOverviewUsecaseModelFromJson,
    );
  }

  Future<GetOrdersUsecaseModel> getOrdersUsecase(GetOrdersUsecaseParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/orders', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: getOrdersUsecaseModelFromJson,
    );
  }

  Future<GetLowStockProductsUsecaseModel> getLowStockProductsUsecase(GetLowStockProductsUsecaseParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/products', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: getLowStockProductsUsecaseModelFromJson,
    );
  }

  Future<AcceptOrderUsecaseModel> acceptOrderUsecase(AcceptOrderUsecaseParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(endPoint: '/orders/${params.orderId}/accept', data: params.getBody(), params: params.getParams()),
      jsonConvert: acceptOrderUsecaseModelFromJson,
    );
  }

  Future<RejectOrderUsecaseModel> rejectOrderUsecase(RejectOrderUsecaseParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(endPoint: '/orders/${params.orderId}/reject', data: params.getBody(), params: params.getParams()),
      jsonConvert: rejectOrderUsecaseModelFromJson,
    );
  }

  Future<GetDailyAnalyticsUsecaseModel> getDailyAnalyticsUsecase(GetDailyAnalyticsUsecaseParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(
        endPoint: '/restaurant/analytics/daily-stats',
        params: params.getParams(),
        data: params.getBody().isEmpty ? null : params.getBody(),
      ),
      jsonConvert: getDailyAnalyticsUsecaseModelFromJson,
    );
  }

  Future<GetMonthlyAnalyticsUsecaseModel> getMonthlyAnalyticsUsecase(GetMonthlyAnalyticsUsecaseParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(
        endPoint: '/restaurant/analytics/monthly-stats',
        params: params.getParams(),
        data: params.getBody().isEmpty ? null : params.getBody(),
      ),
      jsonConvert: getMonthlyAnalyticsUsecaseModelFromJson,
    );
  }

  Future<CreateProductUsecaseModel> createProductUsecase(CreateProductUsecaseParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(endPoint: '/products', data: params.getBody(), params: params.getParams()),
      jsonConvert: createProductUsecaseModelFromJson,
    );
  }

  Future<CreateOfferUsecaseModel> createOfferUsecase(CreateOfferUsecaseParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(endPoint: '/offers', data: params.getBody(), params: params.getParams()),
      jsonConvert: createOfferUsecaseModelFromJson,
    );
  }

  Future<CreateOrderUsecaseModel> createOrderUsecase(CreateOrderUsecaseParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(endPoint: '/orders', data: params.getBody(), params: params.getParams()),
      jsonConvert: createOrderUsecaseModelFromJson,
    );
  }
}
