part of 'profile_bloc.dart';

class ProfileState {
  BlocStatus? updateResturantDataStatus;
  BlocStatus? resturantDataStatus;
  FetchResturantDataModel? resturantData;
  BlocStatus? addEmployeeStatus;
  AddEmployeeModel? addEmployee;
  BlocStatus? employeesPermissionsStatus;
  FetchEmployeesPermissionsModel? employeesPermissions;
  BlocStatus? employeesStatus;
  FetchEmployeesModel? employees;
  BlocStatus? workingTimeStatus;
  FetchWorkingTimeModel? workingTime;
  BlocStatus? updateWorkingTimeStatus;
  FetchWorkingTimeDay? updateWorkingTime;
  BlocStatus? couponsSummaryStatus;
  FetchCouponsSummaryModel? couponsSummary;
  PaginationStateModel<FetchCouponsModelDataItem>? coupons;
  BlocStatus? offersSummaryStatus;
  FetchOffersSummaryModel? offersSummary;
  PaginationStateModel<FetchOffersModelDataItem>? offers;
  PaginationStateModel<FetchProductsModelDataItem>? products;
  List<FetchProductsModelDataItem> selectedProducts;
  String? errorMessage;
  CreateOfferModel? createOfferDraft;
  BlocStatus? createOfferStatus;
  CreateCouponModel? createCouponDraft;
  BlocStatus? createCouponStatus;

  ProfileState({
    this.errorMessage,
    this.offers = const PaginationStateModel(perPage: 10),
    this.offersSummary,
    this.offersSummaryStatus,
    this.coupons = const PaginationStateModel(perPage: 10),
    this.couponsSummary,
    this.couponsSummaryStatus,
    this.workingTime,
    this.workingTimeStatus,
    this.updateWorkingTime,
    this.updateWorkingTimeStatus,
    this.createOfferDraft,
    this.createOfferStatus,
    this.createCouponDraft,
    this.createCouponStatus,
    this.products = const PaginationStateModel(perPage: 10),
    this.selectedProducts = const [],
    this.employees,
    this.employeesStatus,
    this.employeesPermissions,
    this.employeesPermissionsStatus,
    this.addEmployee,
    this.addEmployeeStatus,
    this.resturantData,
    this.resturantDataStatus,
    this.updateResturantDataStatus,
  });

  ProfileState copyWith({
    String? errorMessage,
    PaginationStateModel<FetchOffersModelDataItem>? offers,
    FetchOffersSummaryModel? offersSummary,
    BlocStatus? offersSummaryStatus,
    PaginationStateModel<FetchCouponsModelDataItem>? coupons,
    FetchCouponsSummaryModel? couponsSummary,
    BlocStatus? couponsSummaryStatus,
    FetchWorkingTimeModel? workingTime,
    BlocStatus? workingTimeStatus,
    BlocStatus? updateWorkingTimeStatus,
    FetchWorkingTimeDay? updateWorkingTime,
    CreateOfferModel? createOfferDraft,
    BlocStatus? createOfferStatus,
    CreateCouponModel? createCouponDraft,
    BlocStatus? createCouponStatus,
    PaginationStateModel<FetchProductsModelDataItem>? products,
    List<FetchProductsModelDataItem>? selectedProducts,
    FetchEmployeesModel? employees,
    BlocStatus? employeesStatus,
    FetchEmployeesPermissionsModel? employeesPermissions,
    BlocStatus? employeesPermissionsStatus,
    AddEmployeeModel? addEmployee,
    BlocStatus? addEmployeeStatus,
    FetchResturantDataModel? resturantData,
    BlocStatus? resturantDataStatus,
    BlocStatus? updateResturantDataStatus,
  }) => ProfileState(
    errorMessage: errorMessage ?? this.errorMessage,
    offers: offers ?? this.offers,
    offersSummary: offersSummary ?? this.offersSummary,
    offersSummaryStatus: offersSummaryStatus ?? this.offersSummaryStatus,
    coupons: coupons ?? this.coupons,
    couponsSummary: couponsSummary ?? this.couponsSummary,
    couponsSummaryStatus: couponsSummaryStatus ?? this.couponsSummaryStatus,
    workingTime: workingTime ?? this.workingTime,
    workingTimeStatus: workingTimeStatus ?? this.workingTimeStatus,
    updateWorkingTime: updateWorkingTime ?? this.updateWorkingTime,
    updateWorkingTimeStatus: updateWorkingTimeStatus ?? this.updateWorkingTimeStatus,
    createOfferDraft: createOfferDraft ?? this.createOfferDraft,
    createOfferStatus: createOfferStatus ?? this.createOfferStatus,
    createCouponDraft: createCouponDraft ?? this.createCouponDraft,
    createCouponStatus: createCouponStatus ?? this.createCouponStatus,
    products: products ?? this.products,
    selectedProducts: selectedProducts ?? this.selectedProducts,
    employees: employees ?? this.employees,
    employeesStatus: employeesStatus ?? this.employeesStatus,
    employeesPermissions: employeesPermissions ?? this.employeesPermissions,
    employeesPermissionsStatus: employeesPermissionsStatus ?? this.employeesPermissionsStatus,
    addEmployee: addEmployee ?? this.addEmployee,
    addEmployeeStatus: addEmployeeStatus ?? this.addEmployeeStatus,
    resturantData: resturantData ?? this.resturantData,
    resturantDataStatus: resturantDataStatus ?? this.resturantDataStatus,
    updateResturantDataStatus: updateResturantDataStatus ?? this.updateResturantDataStatus,
  );
}
