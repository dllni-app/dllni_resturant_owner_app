import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/debug_agent_log.dart';
import 'package:dllni_resturant_owner_app/features/profile/data/models/create_offer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:common_package/helpers/pagination_helper.dart';
import 'package:common_package/helpers/droppable_helper.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/usecases/fetch_offers_use_case.dart';
import '../../../data/models/fetch_offers_model.dart';
import '../../../domain/usecases/fetch_offers_summary_use_case.dart';
import '../../../data/models/fetch_offers_summary_model.dart';
import '../../../domain/usecases/fetch_coupons_use_case.dart';
import '../../../data/models/fetch_coupons_model.dart';
import '../../../domain/usecases/fetch_coupons_summary_use_case.dart';
import '../../../data/models/fetch_coupons_summary_model.dart';
import '../../../domain/usecases/fetch_working_time_use_case.dart';
import '../../../data/models/fetch_working_time_model.dart';
import '../../../domain/usecases/update_working_time_use_case.dart';
import '../../../domain/usecases/create_offer_use_case.dart';
import '../../../domain/usecases/create_coupon_use_case.dart';
import '../../../data/models/create_coupon_model.dart';
import '../../../../products/domain/usecases/fetch_products_use_case.dart';
import '../../../../products/data/models/fetch_products_model.dart';
import '../../../domain/usecases/fetch_employees_use_case.dart';
import '../../../data/models/fetch_employees_model.dart';
import '../../../domain/usecases/fetch_employees_permissions_use_case.dart';
import '../../../data/models/fetch_employees_permissions_model.dart';
import '../../../domain/usecases/add_employee_use_case.dart';
import '../../../data/models/add_employee_model.dart';
import '../../../domain/usecases/fetch_resturant_data_use_case.dart';
import '../../../data/models/fetch_resturant_data_model.dart';
import '../../../domain/usecases/update_resturant_data_use_case.dart';

part 'profile_event.dart';

part 'profile_state.dart';

@lazySingleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateResturantDataUseCase updateResturantDataUseCase;
  final FetchResturantDataUseCase fetchResturantDataUseCase;
  final AddEmployeeUseCase addEmployeeUseCase;
  final FetchEmployeesPermissionsUseCase fetchEmployeesPermissionsUseCase;
  final FetchEmployeesUseCase fetchEmployeesUseCase;
  final UpdateWorkingTimeUseCase updateWorkingTimeUseCase;
  final FetchWorkingTimeUseCase fetchWorkingTimeUseCase;
  final FetchCouponsSummaryUseCase fetchCouponsSummaryUseCase;
  final FetchCouponsUseCase fetchCouponsUseCase;
  final FetchOffersSummaryUseCase fetchOffersSummaryUseCase;
  final FetchOffersUseCase fetchOffersUseCase;
  final CreateOfferUseCase createOfferUseCase;
  final CreateCouponUseCase createCouponUseCase;
  final FetchProductsUseCase fetchProductsUseCase;

  ProfileBloc(
    this.fetchOffersUseCase,
    this.fetchOffersSummaryUseCase,
    this.fetchCouponsUseCase,
    this.fetchCouponsSummaryUseCase,
    this.fetchWorkingTimeUseCase,
    this.updateWorkingTimeUseCase,
    this.createOfferUseCase,
    this.createCouponUseCase,
    this.fetchProductsUseCase,
    this.fetchEmployeesUseCase,
    this.fetchEmployeesPermissionsUseCase,
    this.addEmployeeUseCase,
    this.fetchResturantDataUseCase,
    this.updateResturantDataUseCase,
  ) : super(ProfileState()) {
    on<FetchOffersEvent>(_fetchOffers, transformer: droppableProMax());
    on<FetchOffersSummaryEvent>(_fetchOffersSummary);
    on<FetchCouponsEvent>(_fetchCoupons, transformer: droppableProMax());
    on<FetchCouponsSummaryEvent>(_fetchCouponsSummary);
    on<FetchWorkingTimeEvent>(_fetchWorkingTime);
    on<UpdateWorkingTimeEvent>(_updateWorkingTime);
    on<CreateOfferSubmitEvent>(_createOfferSubmit);
    on<CreateCouponSubmitEvent>(_createCouponSubmit);
    on<FetchProductsEvent>(_fetchProducts, transformer: droppableProMax());
    on<SelectProductEvent>(_selectProduct);
    on<DeselectProductEvent>(_deselectProduct);

    on<FetchEmployeesEvent>(_fetchEmployees);
    on<FetchEmployeesPermissionsEvent>(_fetchEmployeesPermissions);
    on<AddEmployeeEvent>(_addEmployee);
    on<FetchResturantDataEvent>(_fetchResturantData);
    on<UpdateResturantDataEvent>(_updateResturantData);
  }

  EventTransformer<T> droppableProMax<T extends EventWithReload>() {
    return (events, mapper) {
      return events.transform(ExhaustMapStreamTransformer(mapper));
    };
  }

  FutureOr<void> _fetchOffers(FetchOffersEvent event, Emitter<ProfileState> emit) async {
    if (!state.offers!.isEndPage || event.isReload) {
      emit(state.copyWith(offers: state.offers!.setLoading(isReload: event.isReload)));
      final res = await fetchOffersUseCase(event.params);
      res.fold(
        (l) {
          if (isClosed) return;
          emit(
            state.copyWith(
              offers: state.offers!.setFaild(errorMessage: l.message),
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          if (isClosed) return;
          emit(state.copyWith(offers: state.offers!.setSuccess(data: r.data!)));
        },
      );
    }
  }

  FutureOr<void> _fetchOffersSummary(FetchOffersSummaryEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(offersSummaryStatus: BlocStatus.loading));
    final res = await fetchOffersSummaryUseCase(event.params);
    res.fold(
      (l) {
        if (isClosed) return;
        emit(state.copyWith(offersSummaryStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        if (isClosed) return;
        emit(state.copyWith(offersSummaryStatus: BlocStatus.success, offersSummary: r));
      },
    );
  }

  FutureOr<void> _fetchCoupons(FetchCouponsEvent event, Emitter<ProfileState> emit) async {
    if (!state.coupons!.isEndPage || event.isReload) {
      emit(state.copyWith(coupons: state.coupons!.setLoading(isReload: event.isReload)));
      final res = await fetchCouponsUseCase(event.params);
      res.fold(
        (l) {
          if (isClosed) return;
          emit(
            state.copyWith(
              coupons: state.coupons!.setFaild(errorMessage: l.message),
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          if (isClosed) return;
          emit(state.copyWith(coupons: state.coupons!.setSuccess(data: r.data!)));
        },
      );
    }
  }

  FutureOr<void> _fetchCouponsSummary(FetchCouponsSummaryEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(couponsSummaryStatus: BlocStatus.loading));
    final res = await fetchCouponsSummaryUseCase(event.params);
    res.fold(
      (l) {
        if (isClosed) return;
        emit(state.copyWith(couponsSummaryStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        if (isClosed) return;
        emit(state.copyWith(couponsSummaryStatus: BlocStatus.success, couponsSummary: r));
      },
    );
  }

  FutureOr<void> _fetchWorkingTime(FetchWorkingTimeEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(workingTimeStatus: BlocStatus.loading));
    final res = await fetchWorkingTimeUseCase(event.params);
    res.fold(
      (l) {
        if (isClosed) return;
        emit(state.copyWith(workingTimeStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        if (isClosed) return;
        emit(state.copyWith(workingTimeStatus: BlocStatus.success, workingTime: r));
      },
    );
  }

  FutureOr<void> _updateWorkingTime(UpdateWorkingTimeEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(updateWorkingTimeStatus: BlocStatus.loading));
    final res = await updateWorkingTimeUseCase(event.params);
    res.fold(
      (l) {
        if (isClosed) return;
        emit(state.copyWith(updateWorkingTimeStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        if (isClosed) return;
        emit(state.copyWith(updateWorkingTimeStatus: BlocStatus.success, updateWorkingTime: r));
      },
    );
  }

  FutureOr<void> _createOfferSubmit(CreateOfferSubmitEvent event, Emitter emit) async {
    Loading.show(event.context);
    emit(state.copyWith(createOfferStatus: BlocStatus.loading));
    final res = await createOfferUseCase(event.params);
    res.fold(
      (l) {
        Loading.close();
        if (isClosed) return;
        AppToast.showToast(context: event.context, message: l.message, type: ToastificationType.error);
        emit(state.copyWith(createOfferStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        Loading.close();
        if (isClosed) return;
        add(FetchOffersEvent(params: FetchOffersParams(page: 1, status: null), isReload: true));
        emit(state.copyWith(createOfferStatus: BlocStatus.success, createOfferDraft: r));
      },
    );
  }

  FutureOr<void> _createCouponSubmit(CreateCouponSubmitEvent event, Emitter emit) async {
    if (event.params.isDelete) {
      Loading.show(event.context);
    }
    emit(state.copyWith(createCouponStatus: BlocStatus.loading));
    final res = await createCouponUseCase(event.params);
    res.fold(
      (l) {
        if (event.params.isDelete) Loading.close();
        if (isClosed) return;
        AppToast.showToast(context: event.context, message: l.message, type: ToastificationType.error);
        emit(state.copyWith(createCouponStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        if (isClosed) return;
        emit(state.copyWith(createCouponStatus: BlocStatus.success, createCouponDraft: r));
        if (event.params.isDelete) {
          Loading.close();
          add(FetchCouponsEvent(params: FetchCouponsParams(status: 'all'), isReload: true));
        } else {
          AppToast.showToast(
            context: event.context,
            message: event.params.isAddNew ? 'تم انشاء الكوبون بنجاح' : 'تم تعديل الكوبون بنجاح',
            type: ToastificationType.success,
          );
          event.context.pushRouteAndRemoveUntil('main', arguments: 4);
        }
      },
    );
  }

  FutureOr<void> _fetchProducts(FetchProductsEvent event, Emitter<ProfileState> emit) async {
    if (!state.products!.isEndPage || event.isReload) {
      emit(state.copyWith(products: state.products!.setLoading(isReload: event.isReload)));
      final res = await fetchProductsUseCase(event.params);
      res.fold(
        (l) {
          if (isClosed) return;
          emit(
            state.copyWith(
              products: state.products!.setFaild(errorMessage: l.message),
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          if (isClosed) return;
          emit(state.copyWith(products: state.products!.setSuccess(data: r.data!)));
        },
      );
    }
  }

  FutureOr<void> _selectProduct(SelectProductEvent event, Emitter<ProfileState> emit) async {
    final selectedProducts = List<FetchProductsModelDataItem>.from(state.selectedProducts);
    if (!selectedProducts.any((p) => p.id == event.product.id)) {
      selectedProducts.add(event.product);
      emit(state.copyWith(selectedProducts: selectedProducts));
    }
  }

  FutureOr<void> _deselectProduct(DeselectProductEvent event, Emitter<ProfileState> emit) async {
    final selectedProducts = List<FetchProductsModelDataItem>.from(state.selectedProducts);
    selectedProducts.removeWhere((p) => p.id == event.productId);
    emit(state.copyWith(selectedProducts: selectedProducts));
  }

  FutureOr<void> _fetchEmployees(FetchEmployeesEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(employeesStatus: BlocStatus.loading));
    final res = await fetchEmployeesUseCase(event.params);
    res.fold(
      (l) {
        if (isClosed) return;
        emit(state.copyWith(employeesStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        if (isClosed) return;
        emit(state.copyWith(employeesStatus: BlocStatus.success, employees: r));
      },
    );
  }

  FutureOr<void> _fetchEmployeesPermissions(FetchEmployeesPermissionsEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(employeesPermissionsStatus: BlocStatus.loading));
    final res = await fetchEmployeesPermissionsUseCase(event.params);
    res.fold(
      (l) {
        if (isClosed) return;
        emit(state.copyWith(employeesPermissionsStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        if (isClosed) return;
        emit(state.copyWith(employeesPermissionsStatus: BlocStatus.success, employeesPermissions: r));
      },
    );
  }

  FutureOr<void> _addEmployee(AddEmployeeEvent event, Emitter<ProfileState> emit) async {
    if (event.params.isDelete == true) {
      Loading.show(event.context);
    }
    emit(state.copyWith(addEmployeeStatus: BlocStatus.loading));
    final res = await addEmployeeUseCase(event.params);
    res.fold(
      (l) {
        if (event.params.isDelete == true) {
          Loading.close();
        }
        if (isClosed) return;
        if (event.params.isDelete == true) {
          AppToast.showToast(context: event.context, message: l.message, type: ToastificationType.error);
        }
        emit(state.copyWith(addEmployeeStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        if (event.params.isDelete == true) {
          Loading.close();
        }
        if (isClosed) return;
        if (event.params.isDelete == true) {
          add(FetchEmployeesEvent(params: FetchEmployeesParams()));
        }
        emit(state.copyWith(addEmployeeStatus: BlocStatus.success, addEmployee: r));
      },
    );
  }

  FutureOr<void> _fetchResturantData(FetchResturantDataEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(resturantDataStatus: BlocStatus.loading));
    final res = await fetchResturantDataUseCase(event.params);
    res.fold(
      (l) {
        if (isClosed) return;
        emit(state.copyWith(resturantDataStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        if (isClosed) return;
        emit(state.copyWith(resturantDataStatus: BlocStatus.success, resturantData: r));
      },
    );
  }

  FutureOr<void> _updateResturantData(UpdateResturantDataEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(updateResturantDataStatus: BlocStatus.loading));
    final res = await updateResturantDataUseCase(event.params);
    res.fold(
      (l) {
        if (isClosed) return;
        AppToast.showToast(context: event.context, message: l.message, type: ToastificationType.error);
        emit(state.copyWith(updateResturantDataStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        if (isClosed) return;
        AppToast.showToast(context: event.context, message: 'تم تحديث معلومات المتجر بنجاح', type: ToastificationType.success);
        emit(state.copyWith(updateResturantDataStatus: BlocStatus.success, resturantDataStatus: BlocStatus.success, resturantData: r));
      },
    );
  }

  // #region agent log
  @override
  void add(ProfileEvent event) {
    debugAgentLog(
      hypothesisId: 'H1_H2_H3_H4',
      location: 'profile_bloc.dart:add',
      message: 'ProfileBloc.add',
      data: {'isClosed': isClosed, 'eventType': event.runtimeType.toString()},
      runId: 'post-fix',
    );
    if (isClosed) {
      debugAgentLog(
        hypothesisId: 'H5',
        location: 'profile_bloc.dart:add',
        message: 'ProfileBloc.add skipped (bloc closed)',
        data: {'eventType': event.runtimeType.toString()},
        runId: 'post-fix',
      );
      return;
    }
    super.add(event);
  }

  @override
  Future<void> close() {
    debugAgentLog(
      hypothesisId: 'H1',
      location: 'profile_bloc.dart:close',
      message: 'ProfileBloc.close',
      data: const {},
      runId: 'post-fix',
    );
    return super.close();
  }
  // #endregion
}
