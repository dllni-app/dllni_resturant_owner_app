import 'package:common_package/common_package.dart';
import 'package:injectable/injectable.dart';
import '../models/fetch_offers_model.dart';
import '../../domain/usecases/fetch_offers_use_case.dart';
import '../models/fetch_offers_summary_model.dart';
import '../../domain/usecases/fetch_offers_summary_use_case.dart';
import '../models/fetch_coupons_model.dart';
import '../../domain/usecases/fetch_coupons_use_case.dart';
import '../models/fetch_coupons_summary_model.dart';
import '../../domain/usecases/fetch_coupons_summary_use_case.dart';
import '../models/fetch_activity_logs_model.dart';
import '../../domain/usecases/fetch_activity_logs_use_case.dart';
import '../models/fetch_working_time_model.dart';
import '../../domain/usecases/fetch_working_time_use_case.dart';
import 'package:common_package/helpers/api_handler.dart';
import '../../domain/usecases/update_working_time_use_case.dart';
import '../../domain/usecases/create_offer_use_case.dart';
import '../models/create_offer_model.dart';
import '../../domain/usecases/create_coupon_use_case.dart';
import '../models/create_coupon_model.dart';
import '../models/fetch_employees_model.dart';
import '../../domain/usecases/fetch_employees_use_case.dart';
import '../models/fetch_employees_permissions_model.dart';
import '../../domain/usecases/fetch_employees_permissions_use_case.dart';
import '../models/add_employee_model.dart';
import '../../domain/usecases/add_employee_use_case.dart';
import '../models/fetch_resturant_data_model.dart';
import '../../domain/usecases/fetch_resturant_data_use_case.dart';
import '../../domain/usecases/update_resturant_data_use_case.dart';

@lazySingleton
class ProfileRemoteDataSource with HandlingApiManager {
  final DioNetwork dioNetwork;

  ProfileRemoteDataSource({required this.dioNetwork});

  Future<FetchOffersModel> fetchOffers(FetchOffersParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/offers', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchOffersModelFromJson,
    );
  }

  Future<FetchOffersSummaryModel> fetchOffersSummary(FetchOffersSummaryParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/offers/summary', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchOffersSummaryModelFromJson,
    );
  }

  Future<FetchCouponsModel> fetchCoupons(FetchCouponsParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/coupons', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchCouponsModelFromJson,
    );
  }

  Future<FetchCouponsSummaryModel> fetchCouponsSummary(FetchCouponsSummaryParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/coupons/summary', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchCouponsSummaryModelFromJson,
    );
  }

  Future<FetchActivityLogsModel> fetchActivityLogs(FetchActivityLogsParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/activity-logs', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchActivityLogsModelFromJson,
    );
  }

  Future<FetchWorkingTimeModel> fetchWorkingTime(FetchWorkingTimeParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/restaurant/operating-hours', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchWorkingTimeModelFromJson,
    );
  }

  Future<FetchWorkingTimeDay> updateWorkingTime(UpdateWorkingTimeParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.putData(endPoint: '/api/v1/restaurant-owner/restaurant/operating-hours', data: params.getBody(), params: params.getParams()),
      jsonConvert: fetchWorkingTimeDayFromJson,
    );
  }

  Future<CreateOfferModel> createOffer(CreateOfferParams params) {
    return wrapHandlingApi(
      tryCall: () => params.isDelete
          ? dioNetwork.deleteData(endPoint: '/api/v1/restaurant-owner/offers/${params.id}', data: params.getBody(), params: params.getParams())
          : params.isAddNew
              ? dioNetwork.postData(endPoint: '/api/v1/restaurant-owner/offers', data: params.getBody(), params: params.getParams())
              : dioNetwork.putData(endPoint: '/api/v1/restaurant-owner/offers/${params.id}', data: params.getBody(), params: params.getParams()),
      jsonConvert: createOfferModelFromJson,
    );
  }

  Future<CreateCouponModel> createCoupon(CreateCouponParams params) {
    return wrapHandlingApi(
      tryCall: () => params.isDelete
          ? dioNetwork.deleteData(endPoint: '/api/v1/restaurant-owner/promo-codes/${params.id}', data: params.getBody(), params: params.getParams())
          : params.isAddNew
              ? dioNetwork.postData(endPoint: '/api/v1/restaurant-owner/promo-codes', data: params.getBody(), params: params.getParams())
              : dioNetwork.putData(endPoint: '/api/v1/restaurant-owner/promo-codes/${params.id}', data: params.getBody(), params: params.getParams()),
      jsonConvert: createCouponModelFromJson,
    );
  }

  Future<FetchEmployeesModel> fetchEmployees(FetchEmployeesParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/employees', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchEmployeesModelFromJson,
    );
  }

  Future<FetchEmployeesPermissionsModel> fetchEmployeesPermissions(FetchEmployeesPermissionsParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/permissions', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchEmployeesPermissionsModelFromJson,
    );
  }

  Future<AddEmployeeModel> addEmployee(AddEmployeeParams params) {
    return wrapHandlingApi(
      tryCall: () => params.isDelete
          ? dioNetwork.deleteData(endPoint: '/api/v1/restaurant-owner/employees/${params.id}', data: params.getBody(), params: params.getParams())
          : params.isAddNew
              ? dioNetwork.postData(endPoint: '/api/v1/restaurant-owner/employees', data: params.getBody(), params: params.getParams())
              : dioNetwork.patchData(endPoint: '/api/v1/restaurant-owner/employees/${params.id}', data: params.getBody(), params: params.getParams()),
      jsonConvert: addEmployeeModelFromJson,
    );
  }

  Future<FetchResturantDataModel> fetchResturantData(FetchResturantDataParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/restaurant-owner/restaurant', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: fetchResturantDataModelFromJson,
    );
  }

  Future<FetchResturantDataModel> updateResturantData(UpdateResturantDataParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.putData(endPoint: '/api/v1/restaurant-owner/restaurant', data: params.getBody(), params: params.getParams()),
      jsonConvert: fetchResturantDataModelFromJson,
    );
  }
}
