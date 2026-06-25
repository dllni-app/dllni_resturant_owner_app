import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/error_handler.dart';

import '../../domain/repository/profile_repo.dart';
import 'package:common_package/helpers/typedef.dart';
import '../source/profile_remote_data_source.dart';
import '../../domain/usecases/fetch_offers_use_case.dart';
import '../models/fetch_offers_model.dart';
import '../../domain/usecases/fetch_offers_summary_use_case.dart';
import '../models/fetch_offers_summary_model.dart';
import '../../domain/usecases/fetch_coupons_use_case.dart';
import '../models/fetch_coupons_model.dart';
import '../../domain/usecases/fetch_coupons_summary_use_case.dart';
import '../models/fetch_coupons_summary_model.dart';
import '../../domain/usecases/fetch_activity_logs_use_case.dart';
import '../models/fetch_activity_logs_model.dart';
import '../../domain/usecases/fetch_working_time_use_case.dart';
import '../models/fetch_working_time_model.dart';
import '../../domain/usecases/update_working_time_use_case.dart';
import '../../domain/usecases/create_offer_use_case.dart';
import '../models/create_offer_model.dart';
import '../../domain/usecases/create_coupon_use_case.dart';
import '../models/create_coupon_model.dart';
import '../../domain/usecases/fetch_employees_use_case.dart';
import '../models/fetch_employees_model.dart';
import '../../domain/usecases/fetch_employees_permissions_use_case.dart';
import '../models/fetch_employees_permissions_model.dart';
import '../../domain/usecases/add_employee_use_case.dart';
import '../models/add_employee_model.dart';
import '../../domain/usecases/fetch_resturant_data_use_case.dart';
import '../models/fetch_resturant_data_model.dart';
import '../../domain/usecases/update_resturant_data_use_case.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl with HandlingException implements ProfileRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl({required this.profileRemoteDataSource});

  @override
  DataResponse<FetchOffersModel> fetchOffers(FetchOffersParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.fetchOffers(params),
    );
  }

  @override
  DataResponse<FetchOffersSummaryModel> fetchOffersSummary(FetchOffersSummaryParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.fetchOffersSummary(params),
    );
  }

  @override
  DataResponse<FetchCouponsModel> fetchCoupons(FetchCouponsParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.fetchCoupons(params),
    );
  }

  @override
  DataResponse<FetchCouponsSummaryModel> fetchCouponsSummary(FetchCouponsSummaryParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.fetchCouponsSummary(params),
    );
  }

  @override
  DataResponse<FetchActivityLogsModel> fetchActivityLogs(FetchActivityLogsParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.fetchActivityLogs(params),
    );
  }

  @override
  DataResponse<FetchWorkingTimeModel> fetchWorkingTime(FetchWorkingTimeParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.fetchWorkingTime(params),
    );
  }

  @override
  DataResponse<FetchWorkingTimeDay> updateWorkingTime(UpdateWorkingTimeParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.updateWorkingTime(params),
    );
  }

  @override
  DataResponse<CreateOfferModel> createOffer(CreateOfferParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.createOffer(params),
    );
  }

  @override
  DataResponse<CreateCouponModel> createCoupon(CreateCouponParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.createCoupon(params),
    );
  }


  @override
  DataResponse<FetchEmployeesModel> fetchEmployees(FetchEmployeesParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.fetchEmployees(params),
    );
  }

  @override
  DataResponse<FetchEmployeesPermissionsModel> fetchEmployeesPermissions(FetchEmployeesPermissionsParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.fetchEmployeesPermissions(params),
    );
  }

  @override
  DataResponse<AddEmployeeModel> addEmployee(AddEmployeeParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.addEmployee(params),
    );
  }

  @override
  DataResponse<FetchResturantDataModel> fetchResturantData(FetchResturantDataParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.fetchResturantData(params),
    );
  }

  @override
  DataResponse<FetchResturantDataModel> updateResturantData(UpdateResturantDataParams params) {
    return wrapHandlingException(
      tryCall: () => profileRemoteDataSource.updateResturantData(params),
    );
  }
}
