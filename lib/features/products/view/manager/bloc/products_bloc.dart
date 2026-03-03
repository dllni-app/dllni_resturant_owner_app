import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:common_package/helpers/pagination_helper.dart';
import 'package:common_package/helpers/droppable_helper.dart';
import '../../../domain/usecases/get_products_use_case.dart';
import '../../../data/models/get_products_model.dart';
import '../../../domain/usecases/get_categories_use_case.dart';
import '../../../data/models/get_categories_model.dart';

part 'products_event.dart';

part 'products_state.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  ProductsBloc(this.getProductsUseCase, this.getCategoriesUseCase) : super(ProductsState()) {
    on<GetProductsEvent>(_getProducts, transformer: droppableProMax());
    on<GetCategoriesEvent>(_getCategories);
  }

  EventTransformer<T> droppableProMax<T extends EventWithReload>() {
    return (events, mapper) {
      return events.transform(ExhaustMapStreamTransformer(mapper));
    };
  }

  FutureOr<void> _getProducts(GetProductsEvent event, Emitter<ProductsState> emit) async {
    if (!state.products!.isEndPage || event.isReload) {
      emit(state.copyWith(products: state.products!.setLoading(isReload: event.isReload)));
      final res = await getProductsUseCase(event.params);
      res.fold(
        (l) {
          emit(
            state.copyWith(
              products: state.products!.setFaild(errorMessage: l.message),
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          emit(state.copyWith(products: state.products!.setSuccess(data: r.data!)));
        },
      );
    }
  }

  FutureOr<void> _getCategories(GetCategoriesEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(categoriesStatus: BlocStatus.loading));
    final res = await getCategoriesUseCase(event.params);
    res.fold(
      (l) {
        emit(state.copyWith(categoriesStatus: BlocStatus.failed, errorMessage: l.message));
      },
      (r) {
        add(GetProductsEvent(params: GetProductsParams(page: 1, categoryId: r.data![0].id!)));
        emit(state.copyWith(categoriesStatus: BlocStatus.success, categories: r));
      },
    );
  }
}
