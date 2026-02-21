// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:common_package/helpers/dio_network.dart' as _i497;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/home/data/repository/home_repo_impl.dart' as _i1013;
import '../../features/home/data/source/home_remote_data_source.dart' as _i557;
import '../../features/home/domain/repository/home_repo.dart' as _i396;
import '../../features/home/domain/usecases/accept_order_usecase_use_case.dart'
    as _i955;
import '../../features/home/domain/usecases/create_offer_usecase_use_case.dart'
    as _i214;
import '../../features/home/domain/usecases/create_order_usecase_use_case.dart'
    as _i1031;
import '../../features/home/domain/usecases/create_product_usecase_use_case.dart'
    as _i106;
import '../../features/home/domain/usecases/get_daily_analytics_usecase_use_case.dart'
    as _i130;
import '../../features/home/domain/usecases/get_dashboard_overview_usecase_use_case.dart'
    as _i646;
import '../../features/home/domain/usecases/get_low_stock_products_usecase_use_case.dart'
    as _i755;
import '../../features/home/domain/usecases/get_monthly_analytics_usecase_use_case.dart'
    as _i869;
import '../../features/home/domain/usecases/get_orders_usecase_use_case.dart'
    as _i215;
import '../../features/home/domain/usecases/reject_order_usecase_use_case.dart'
    as _i636;
import '../../features/home/view/manager/bloc/home_bloc.dart' as _i648;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.singleton<_i497.DioNetwork>(() => injectableModule.dio);
  gh.lazySingleton<_i557.HomeRemoteDataSource>(
    () => _i557.HomeRemoteDataSource(dioNetwork: gh<_i497.DioNetwork>()),
  );
  gh.lazySingleton<_i396.HomeRepo>(
    () => _i1013.HomeRepoImpl(
      homeRemoteDataSource: gh<_i557.HomeRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i955.AcceptOrderUsecaseUseCase>(
    () => _i955.AcceptOrderUsecaseUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i214.CreateOfferUsecaseUseCase>(
    () => _i214.CreateOfferUsecaseUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i1031.CreateOrderUsecaseUseCase>(
    () => _i1031.CreateOrderUsecaseUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i106.CreateProductUsecaseUseCase>(
    () => _i106.CreateProductUsecaseUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i130.GetDailyAnalyticsUsecaseUseCase>(
    () => _i130.GetDailyAnalyticsUsecaseUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i646.GetDashboardOverviewUsecaseUseCase>(
    () => _i646.GetDashboardOverviewUsecaseUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i755.GetLowStockProductsUsecaseUseCase>(
    () => _i755.GetLowStockProductsUsecaseUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i869.GetMonthlyAnalyticsUsecaseUseCase>(
    () => _i869.GetMonthlyAnalyticsUsecaseUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i215.GetOrdersUsecaseUseCase>(
    () => _i215.GetOrdersUsecaseUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.lazySingleton<_i636.RejectOrderUsecaseUseCase>(
    () => _i636.RejectOrderUsecaseUseCase(home: gh<_i396.HomeRepo>()),
  );
  gh.factory<_i648.HomeBloc>(
    () => _i648.HomeBloc(
      gh<_i646.GetDashboardOverviewUsecaseUseCase>(),
      gh<_i215.GetOrdersUsecaseUseCase>(),
      gh<_i755.GetLowStockProductsUsecaseUseCase>(),
      gh<_i955.AcceptOrderUsecaseUseCase>(),
      gh<_i636.RejectOrderUsecaseUseCase>(),
      gh<_i130.GetDailyAnalyticsUsecaseUseCase>(),
      gh<_i869.GetMonthlyAnalyticsUsecaseUseCase>(),
      gh<_i106.CreateProductUsecaseUseCase>(),
      gh<_i214.CreateOfferUsecaseUseCase>(),
      gh<_i1031.CreateOrderUsecaseUseCase>(),
    ),
  );
  return getIt;
}

class _$InjectableModule extends _i464.InjectableModule {}
