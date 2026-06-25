part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class FetchOffersEvent extends ProfileEvent with EventWithReload {
  final FetchOffersParams params;

  @override
  final bool isReload;

  FetchOffersEvent({required this.params, this.isReload = false});
}

class FetchOffersSummaryEvent extends ProfileEvent {
  final FetchOffersSummaryParams params;

  FetchOffersSummaryEvent({required this.params});
}

class FetchCouponsEvent extends ProfileEvent with EventWithReload {
  final FetchCouponsParams params;

  @override
  final bool isReload;

  FetchCouponsEvent({required this.params, this.isReload = false});
}

class FetchCouponsSummaryEvent extends ProfileEvent {
  final FetchCouponsSummaryParams params;

  FetchCouponsSummaryEvent({required this.params});
}

class FetchActivityLogsEvent extends ProfileEvent with EventWithReload {
  final FetchActivityLogsParams params;

  @override
  final bool isReload;

  FetchActivityLogsEvent({required this.params, this.isReload = false});
}

class FetchWorkingTimeEvent extends ProfileEvent {
  final FetchWorkingTimeParams params;

  FetchWorkingTimeEvent({required this.params});
}

class UpdateWorkingTimeEvent extends ProfileEvent {
  final UpdateWorkingTimeParams params;

  UpdateWorkingTimeEvent({required this.params});
}

class CreateOfferSubmitEvent extends ProfileEvent {
  final CreateOfferParams params;

  final BuildContext context;

  CreateOfferSubmitEvent({required this.params, required this.context});
}

class FetchProductsEvent extends ProfileEvent with EventWithReload {
  final FetchProductsParams params;

  @override
  final bool isReload;

  FetchProductsEvent({required this.params, this.isReload = false});
}

class SelectProductEvent extends ProfileEvent {
  final FetchProductsModelDataItem product;

  SelectProductEvent({required this.product});
}

class DeselectProductEvent extends ProfileEvent {
  final int productId;

  DeselectProductEvent({required this.productId});
}

class CreateCouponSubmitEvent extends ProfileEvent {
  final CreateCouponParams params;
  final BuildContext context;

  CreateCouponSubmitEvent({required this.params, required this.context});
}

class FetchEmployeesEvent extends ProfileEvent {
  final FetchEmployeesParams params;

  FetchEmployeesEvent({required this.params});
}

class FetchEmployeesPermissionsEvent extends ProfileEvent {
  final FetchEmployeesPermissionsParams params;

  FetchEmployeesPermissionsEvent({required this.params});
}

class AddEmployeeEvent extends ProfileEvent {
  final AddEmployeeParams params;
  final BuildContext context;

  AddEmployeeEvent({required this.params, required this.context});
}

class FetchResturantDataEvent extends ProfileEvent {
  final FetchResturantDataParams params;

  FetchResturantDataEvent({required this.params});
}

class UpdateResturantDataEvent extends ProfileEvent {
  final UpdateResturantDataParams params;
  final BuildContext context;

  UpdateResturantDataEvent({required this.params, required this.context});
}
