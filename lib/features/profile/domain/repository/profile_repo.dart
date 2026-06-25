import 'package:common_package/helpers/typedef.dart';
import '../usecases/fetch_offers_use_case.dart';
import '../../data/models/fetch_offers_model.dart';
import '../usecases/fetch_offers_summary_use_case.dart';
import '../../data/models/fetch_offers_summary_model.dart';
import '../usecases/fetch_coupons_use_case.dart';
import '../../data/models/fetch_coupons_model.dart';
import '../usecases/fetch_coupons_summary_use_case.dart';
import '../../data/models/fetch_coupons_summary_model.dart';
import '../usecases/fetch_activity_logs_use_case.dart';
import '../../data/models/fetch_activity_logs_model.dart';
import '../usecases/fetch_working_time_use_case.dart';
import '../../data/models/fetch_working_time_model.dart';
import '../usecases/update_working_time_use_case.dart';
import '../usecases/create_offer_use_case.dart';
import '../../data/models/create_offer_model.dart';
import '../usecases/create_coupon_use_case.dart';
import '../../data/models/create_coupon_model.dart';
import '../usecases/fetch_employees_use_case.dart';
import '../../data/models/fetch_employees_model.dart';
import '../usecases/fetch_employees_permissions_use_case.dart';
import '../../data/models/fetch_employees_permissions_model.dart';
import '../usecases/add_employee_use_case.dart';
import '../../data/models/add_employee_model.dart';
import '../usecases/fetch_resturant_data_use_case.dart';
import '../../data/models/fetch_resturant_data_model.dart';
import '../usecases/update_resturant_data_use_case.dart';
abstract class ProfileRepo {
  DataResponse<FetchOffersModel> fetchOffers(FetchOffersParams params);

  DataResponse<FetchOffersSummaryModel> fetchOffersSummary(FetchOffersSummaryParams params);

  DataResponse<FetchCouponsModel> fetchCoupons(FetchCouponsParams params);

  DataResponse<FetchCouponsSummaryModel> fetchCouponsSummary(FetchCouponsSummaryParams params);

  DataResponse<FetchActivityLogsModel> fetchActivityLogs(FetchActivityLogsParams params);

  DataResponse<FetchWorkingTimeModel> fetchWorkingTime(FetchWorkingTimeParams params);

  DataResponse<FetchWorkingTimeDay> updateWorkingTime(UpdateWorkingTimeParams params);

  DataResponse<CreateOfferModel> createOffer(CreateOfferParams params);

  DataResponse<CreateCouponModel> createCoupon(CreateCouponParams params);

  DataResponse<FetchEmployeesModel> fetchEmployees(FetchEmployeesParams params);

  DataResponse<FetchEmployeesPermissionsModel> fetchEmployeesPermissions(FetchEmployeesPermissionsParams params);

  DataResponse<AddEmployeeModel> addEmployee(AddEmployeeParams params);

  DataResponse<FetchResturantDataModel> fetchResturantData(FetchResturantDataParams params);

  DataResponse<FetchResturantDataModel> updateResturantData(UpdateResturantDataParams params);
}
