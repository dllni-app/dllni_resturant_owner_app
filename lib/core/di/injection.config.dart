// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:common_package/common_package.dart' as _i960;
import 'package:common_package/helpers/dio_network.dart' as _i497;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/repository/auth_repo_impl.dart' as _i751;
import '../../features/auth/data/source/auth_remote_data_source.dart' as _i777;
import '../../features/auth/domain/repository/auth_repo.dart' as _i976;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/view/manager/bloc/auth_bloc.dart' as _i958;
import '../../features/home/data/repository/home_repo_impl.dart' as _i1013;
import '../../features/home/data/source/home_remote_data_source.dart' as _i557;
import '../../features/home/domain/repository/home_repo.dart' as _i396;
import '../../features/home/domain/usecases/fetch_notifications_use_case.dart'
    as _i204;
import '../../features/home/domain/usecases/home_overview_performance_use_case.dart'
    as _i937;
import '../../features/home/domain/usecases/home_overview_use_case.dart'
    as _i418;
import '../../features/home/domain/usecases/read_all_notifications_use_case.dart'
    as _i546;
import '../../features/home/view/manager/bloc/home_bloc.dart' as _i648;
import '../../features/inventory/data/repository/inventory_repo_impl.dart'
    as _i821;
import '../../features/inventory/data/source/inventory_remote_data_source.dart'
    as _i543;
import '../../features/inventory/domain/repository/inventory_repo.dart'
    as _i1071;
import '../../features/inventory/domain/usecases/create_inventory_item_use_case.dart'
    as _i398;
import '../../features/inventory/domain/usecases/delete_inventory_item_use_case.dart'
    as _i835;
import '../../features/inventory/domain/usecases/fetch_inventory_items_use_case.dart'
    as _i396;
import '../../features/inventory/domain/usecases/fetch_inventory_summary_use_case.dart'
    as _i385;
import '../../features/inventory/domain/usecases/update_inventory_item_use_case.dart'
    as _i330;
import '../../features/inventory/view/manager/bloc/inventory_bloc.dart'
    as _i784;
import '../../features/main/data/repository/main_repo_impl.dart' as _i959;
import '../../features/main/data/source/main_remote_data_source.dart' as _i931;
import '../../features/main/domain/repository/main_repo.dart' as _i540;
import '../../features/main/view/manager/bloc/main_bloc.dart' as _i98;
import '../../features/orders/data/repository/orders_repo_impl.dart' as _i849;
import '../../features/orders/data/source/orders_remote_data_source.dart'
    as _i702;
import '../../features/orders/domain/repository/orders_repo.dart' as _i132;
import '../../features/orders/domain/usecases/accept_order_use_case.dart'
    as _i420;
import '../../features/orders/domain/usecases/get_orders_use_case.dart'
    as _i1013;
import '../../features/orders/domain/usecases/reject_order_use_case.dart'
    as _i194;
import '../../features/orders/view/manager/bloc/orders_bloc.dart' as _i305;
import '../../features/products/data/repository/products_repo_impl.dart'
    as _i99;
import '../../features/products/data/source/products_remote_data_source.dart'
    as _i811;
import '../../features/products/domain/repository/products_repo.dart' as _i466;
import '../../features/products/domain/usecases/fetch_categories_use_case.dart'
    as _i230;
import '../../features/products/domain/usecases/fetch_products_use_case.dart'
    as _i73;
import '../../features/products/domain/usecases/generate_ai_product_data_from_image_use_case.dart'
    as _i425;
import '../../features/products/domain/usecases/generate_ai_product_data_from_menu_use_case.dart'
    as _i663;
import '../../features/products/domain/usecases/generate_ai_product_image_use_case.dart'
    as _i990;
import '../../features/products/domain/usecases/post_new_product_use_case.dart'
    as _i456;
import '../../features/products/view/manager/bloc/products_bloc.dart' as _i113;
import '../../features/profile/data/repository/profile_repo_impl.dart' as _i265;
import '../../features/profile/data/source/profile_remote_data_source.dart'
    as _i502;
import '../../features/profile/domain/repository/profile_repo.dart' as _i275;
import '../../features/profile/domain/usecases/add_employee_use_case.dart'
    as _i829;
import '../../features/profile/domain/usecases/create_coupon_use_case.dart'
    as _i158;
import '../../features/profile/domain/usecases/create_offer_use_case.dart'
    as _i633;
import '../../features/profile/domain/usecases/fetch_coupons_summary_use_case.dart'
    as _i315;
import '../../features/profile/domain/usecases/fetch_coupons_use_case.dart'
    as _i879;
import '../../features/profile/domain/usecases/fetch_employees_permissions_use_case.dart'
    as _i202;
import '../../features/profile/domain/usecases/fetch_employees_use_case.dart'
    as _i560;
import '../../features/profile/domain/usecases/fetch_offers_summary_use_case.dart'
    as _i623;
import '../../features/profile/domain/usecases/fetch_offers_use_case.dart'
    as _i980;
import '../../features/profile/domain/usecases/fetch_resturant_data_use_case.dart'
    as _i958;
import '../../features/profile/domain/usecases/fetch_working_time_use_case.dart'
    as _i379;
import '../../features/profile/domain/usecases/update_resturant_data_use_case.dart'
    as _i38;
import '../../features/profile/domain/usecases/update_working_time_use_case.dart'
    as _i903;
import '../../features/profile/view/manager/bloc/profile_bloc.dart' as _i821;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.factory<_i98.MainBloc>(() => _i98.MainBloc());
  gh.singleton<_i960.DioNetwork>(() => injectableModule.dio);
  gh.lazySingleton<_i931.MainRemoteDataSource>(
    () => _i931.MainRemoteDataSource(),
  );
  gh.lazySingleton<_i540.MainRepo>(() => _i959.MainRepoImpl());
  gh.lazySingleton<_i777.AuthRemoteDataSource>(
    () => _i777.AuthRemoteDataSource(dioNetwork: gh<_i497.DioNetwork>()),
  );
  gh.lazySingleton<_i557.HomeRemoteDataSource>(
    () => _i557.HomeRemoteDataSource(dioNetwork: gh<_i960.DioNetwork>()),
  );
  gh.lazySingleton<_i543.InventoryRemoteDataSource>(
    () => _i543.InventoryRemoteDataSource(dioNetwork: gh<_i960.DioNetwork>()),
  );
  gh.lazySingleton<_i702.OrdersRemoteDataSource>(
    () => _i702.OrdersRemoteDataSource(dioNetwork: gh<_i960.DioNetwork>()),
  );
  gh.lazySingleton<_i811.ProductsRemoteDataSource>(
    () => _i811.ProductsRemoteDataSource(dioNetwork: gh<_i960.DioNetwork>()),
  );
  gh.lazySingleton<_i502.ProfileRemoteDataSource>(
    () => _i502.ProfileRemoteDataSource(dioNetwork: gh<_i960.DioNetwork>()),
  );
  gh.lazySingleton<_i976.AuthRepo>(
    () => _i751.AuthRepoImpl(
      authRemoteDataSource: gh<_i777.AuthRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i37.LoginUseCase>(
    () => _i37.LoginUseCase(auth: gh<_i976.AuthRepo>()),
  );
  gh.lazySingleton<_i396.HomeRepo>(
    () => _i1013.HomeRepoImpl(
      homeRemoteDataSource: gh<_i557.HomeRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i132.OrdersRepo>(
    () => _i849.OrdersRepoImpl(
      ordersRemoteDataSource: gh<_i702.OrdersRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i1071.InventoryRepo>(
    () => _i821.InventoryRepoImpl(
      inventoryRemoteDataSource: gh<_i543.InventoryRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i275.ProfileRepo>(
    () => _i265.ProfileRepoImpl(
      profileRemoteDataSource: gh<_i502.ProfileRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i420.AcceptOrderUseCase>(
    () => _i420.AcceptOrderUseCase(orders: gh<_i132.OrdersRepo>()),
  );
  gh.lazySingleton<_i1013.GetOrdersUseCase>(
    () => _i1013.GetOrdersUseCase(orders: gh<_i132.OrdersRepo>()),
  );
  gh.lazySingleton<_i194.RejectOrderUseCase>(
    () => _i194.RejectOrderUseCase(orders: gh<_i132.OrdersRepo>()),
  );
  gh.lazySingleton<_i829.AddEmployeeUseCase>(
    () => _i829.AddEmployeeUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i158.CreateCouponUseCase>(
    () => _i158.CreateCouponUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i633.CreateOfferUseCase>(
    () => _i633.CreateOfferUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i315.FetchCouponsSummaryUseCase>(
    () => _i315.FetchCouponsSummaryUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i879.FetchCouponsUseCase>(
    () => _i879.FetchCouponsUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i202.FetchEmployeesPermissionsUseCase>(
    () => _i202.FetchEmployeesPermissionsUseCase(
      profile: gh<_i275.ProfileRepo>(),
    ),
  );
  gh.lazySingleton<_i560.FetchEmployeesUseCase>(
    () => _i560.FetchEmployeesUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i623.FetchOffersSummaryUseCase>(
    () => _i623.FetchOffersSummaryUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i980.FetchOffersUseCase>(
    () => _i980.FetchOffersUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i958.FetchResturantDataUseCase>(
    () => _i958.FetchResturantDataUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i379.FetchWorkingTimeUseCase>(
    () => _i379.FetchWorkingTimeUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i38.UpdateResturantDataUseCase>(
    () => _i38.UpdateResturantDataUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i903.UpdateWorkingTimeUseCase>(
    () => _i903.UpdateWorkingTimeUseCase(profile: gh<_i275.ProfileRepo>()),
  );
  gh.lazySingleton<_i466.ProductsRepo>(
    () => _i99.ProductsRepoImpl(
      productsRemoteDataSource: gh<_i811.ProductsRemoteDataSource>(),
    ),
  );
  gh.factory<_i305.OrdersBloc>(
    () => _i305.OrdersBloc(
      gh<_i1013.GetOrdersUseCase>(),
      gh<_i420.AcceptOrderUseCase>(),
      gh<_i194.RejectOrderUseCase>(),
    ),
  );
  gh.factory<_i958.AuthBloc>(() => _i958.AuthBloc(gh<_i37.LoginUseCase>()));
  gh.lazySingleton<_i230.FetchCategoriesUseCase>(
    () => _i230.FetchCategoriesUseCase(products: gh<_i466.ProductsRepo>()),
  );
  gh.lazySingleton<_i73.FetchProductsUseCase>(
    () => _i73.FetchProductsUseCase(products: gh<_i466.ProductsRepo>()),
  );
  gh.lazySingleton<_i425.GenerateAiProductDataFromImageUseCase>(
    () => _i425.GenerateAiProductDataFromImageUseCase(
      products: gh<_i466.ProductsRepo>(),
    ),
  );
  gh.lazySingleton<_i663.GenerateAiProductDataFromMenuUseCase>(
    () => _i663.GenerateAiProductDataFromMenuUseCase(
      products: gh<_i466.ProductsRepo>(),
    ),
  );
  gh.lazySingleton<_i990.GenerateAiProductImageUseCase>(
    () =>
        _i990.GenerateAiProductImageUseCase(products: gh<_i466.ProductsRepo>()),
  );
  gh.lazySingleton<_i456.PostNewProductUseCase>(
    () => _i456.PostNewProductUseCase(products: gh<_i466.ProductsRepo>()),
  );
  gh.lazySingleton<_i204.FetchNotificationsUseCase>(
    () => _i204.FetchNotificationsUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i937.HomeOverviewPerformanceUseCase>(
    () => _i937.HomeOverviewPerformanceUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i418.HomeOverviewUseCase>(
    () => _i418.HomeOverviewUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i546.ReadAllNotificationsUseCase>(
    () => _i546.ReadAllNotificationsUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.factory<_i113.ProductsBloc>(
    () => _i113.ProductsBloc(
      gh<_i230.FetchCategoriesUseCase>(),
      gh<_i73.FetchProductsUseCase>(),
      gh<_i990.GenerateAiProductImageUseCase>(),
      gh<_i425.GenerateAiProductDataFromImageUseCase>(),
      gh<_i663.GenerateAiProductDataFromMenuUseCase>(),
      gh<_i456.PostNewProductUseCase>(),
    ),
  );
  gh.lazySingleton<_i398.CreateInventoryItemUseCase>(
    () =>
        _i398.CreateInventoryItemUseCase(inventory: gh<_i1071.InventoryRepo>()),
  );
  gh.lazySingleton<_i835.DeleteInventoryItemUseCase>(
    () =>
        _i835.DeleteInventoryItemUseCase(inventory: gh<_i1071.InventoryRepo>()),
  );
  gh.lazySingleton<_i396.FetchInventoryItemsUseCase>(
    () =>
        _i396.FetchInventoryItemsUseCase(inventory: gh<_i1071.InventoryRepo>()),
  );
  gh.lazySingleton<_i385.FetchInventorySummaryUseCase>(
    () => _i385.FetchInventorySummaryUseCase(
      inventory: gh<_i1071.InventoryRepo>(),
    ),
  );
  gh.lazySingleton<_i330.UpdateInventoryItemUseCase>(
    () =>
        _i330.UpdateInventoryItemUseCase(inventory: gh<_i1071.InventoryRepo>()),
  );
  gh.factory<_i648.HomeBloc>(
    () => _i648.HomeBloc(
      gh<_i204.FetchNotificationsUseCase>(),
      gh<_i546.ReadAllNotificationsUseCase>(),
      gh<_i418.HomeOverviewUseCase>(),
      gh<_i937.HomeOverviewPerformanceUseCase>(),
    ),
  );
  gh.lazySingleton<_i821.ProfileBloc>(
    () => _i821.ProfileBloc(
      gh<_i980.FetchOffersUseCase>(),
      gh<_i623.FetchOffersSummaryUseCase>(),
      gh<_i879.FetchCouponsUseCase>(),
      gh<_i315.FetchCouponsSummaryUseCase>(),
      gh<_i379.FetchWorkingTimeUseCase>(),
      gh<_i903.UpdateWorkingTimeUseCase>(),
      gh<_i633.CreateOfferUseCase>(),
      gh<_i158.CreateCouponUseCase>(),
      gh<_i73.FetchProductsUseCase>(),
      gh<_i560.FetchEmployeesUseCase>(),
      gh<_i202.FetchEmployeesPermissionsUseCase>(),
      gh<_i829.AddEmployeeUseCase>(),
      gh<_i958.FetchResturantDataUseCase>(),
      gh<_i38.UpdateResturantDataUseCase>(),
    ),
  );
  gh.factory<_i784.InventoryBloc>(
    () => _i784.InventoryBloc(
      gh<_i385.FetchInventorySummaryUseCase>(),
      gh<_i396.FetchInventoryItemsUseCase>(),
      gh<_i398.CreateInventoryItemUseCase>(),
      gh<_i330.UpdateInventoryItemUseCase>(),
      gh<_i835.DeleteInventoryItemUseCase>(),
    ),
  );
  return getIt;
}

class _$InjectableModule extends _i464.InjectableModule {}
