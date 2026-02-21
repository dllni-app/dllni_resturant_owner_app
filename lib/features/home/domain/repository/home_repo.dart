import 'package:common_package/helpers/typedef.dart';
import '../usecases/get_dashboard_overview_usecase_use_case.dart';
import '../../data/models/get_dashboard_overview_usecase_model.dart';
import '../usecases/get_orders_usecase_use_case.dart';
import '../../data/models/get_orders_usecase_model.dart';
import '../usecases/get_low_stock_products_usecase_use_case.dart';
import '../../data/models/get_low_stock_products_usecase_model.dart';
import '../usecases/accept_order_usecase_use_case.dart';
import '../../data/models/accept_order_usecase_model.dart';
import '../usecases/reject_order_usecase_use_case.dart';
import '../../data/models/reject_order_usecase_model.dart';
import '../usecases/get_daily_analytics_usecase_use_case.dart';
import '../../data/models/get_daily_analytics_usecase_model.dart';
import '../usecases/get_monthly_analytics_usecase_use_case.dart';
import '../../data/models/get_monthly_analytics_usecase_model.dart';
import '../usecases/create_product_usecase_use_case.dart';
import '../../data/models/create_product_usecase_model.dart';
import '../usecases/create_offer_usecase_use_case.dart';
import '../../data/models/create_offer_usecase_model.dart';
import '../usecases/create_order_usecase_use_case.dart';
import '../../data/models/create_order_usecase_model.dart';
abstract class HomeRepo {
  DataResponse<GetDashboardOverviewUsecaseModel> getDashboardOverviewUsecase(GetDashboardOverviewUsecaseParams params);

  DataResponse<GetOrdersUsecaseModel> getOrdersUsecase(GetOrdersUsecaseParams params);

  DataResponse<GetLowStockProductsUsecaseModel> getLowStockProductsUsecase(GetLowStockProductsUsecaseParams params);

  DataResponse<AcceptOrderUsecaseModel> acceptOrderUsecase(AcceptOrderUsecaseParams params);

  DataResponse<RejectOrderUsecaseModel> rejectOrderUsecase(RejectOrderUsecaseParams params);

  DataResponse<GetDailyAnalyticsUsecaseModel> getDailyAnalyticsUsecase(GetDailyAnalyticsUsecaseParams params);

  DataResponse<GetMonthlyAnalyticsUsecaseModel> getMonthlyAnalyticsUsecase(GetMonthlyAnalyticsUsecaseParams params);

  DataResponse<CreateProductUsecaseModel> createProductUsecase(CreateProductUsecaseParams params);

  DataResponse<CreateOfferUsecaseModel> createOfferUsecase(CreateOfferUsecaseParams params);

  DataResponse<CreateOrderUsecaseModel> createOrderUsecase(CreateOrderUsecaseParams params);
}
