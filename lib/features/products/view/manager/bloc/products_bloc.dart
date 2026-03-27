import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:common_package/helpers/pagination_helper.dart';
import 'package:common_package/helpers/droppable_helper.dart';
import '../../../domain/usecases/fetch_categories_use_case.dart';
import '../../../data/models/fetch_categories_model.dart';
import '../../../domain/usecases/fetch_products_use_case.dart';
import '../../../data/models/fetch_products_model.dart';
import '../../../domain/usecases/generate_ai_product_image_use_case.dart';
import '../../../data/models/generate_ai_product_image_model.dart';
import '../../../domain/usecases/generate_ai_product_data_from_image_use_case.dart';
import '../../../data/models/generate_ai_product_data_from_image_model.dart';
import '../../../domain/usecases/generate_ai_product_data_from_menu_use_case.dart';
import '../../../data/models/generate_ai_product_data_from_menu_model.dart';
import '../../../domain/usecases/post_new_product_use_case.dart';
import '../../../data/models/post_new_product_model.dart';

part 'products_event.dart';

part 'products_state.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final PostNewProductUseCase postNewProductUseCase;
  final GenerateAiProductDataFromMenuUseCase generateAiProductDataFromMenuUseCase;
  final GenerateAiProductDataFromImageUseCase generateAiProductDataFromImageUseCase;
  final GenerateAiProductImageUseCase generateAiProductImageUseCase;
  final FetchProductsUseCase fetchProductsUseCase;
  final FetchCategoriesUseCase fetchCategoriesUseCase;

  ProductsBloc(this.fetchCategoriesUseCase, this.fetchProductsUseCase,
    this.generateAiProductImageUseCase,
    this.generateAiProductDataFromImageUseCase,
    this.generateAiProductDataFromMenuUseCase,
    this.postNewProductUseCase,) : super(ProductsState()) {
    on<FetchCategoriesEvent>(_fetchCategories, transformer: droppableProMax());
    on<FetchProductsEvent>(_fetchProducts, transformer: droppableProMax());
  
    on<GenerateAiProductImageEvent>(_generateAiProductImage);
    on<GenerateAiProductDataFromImageEvent>(_generateAiProductDataFromImage);
    on<GenerateAiProductDataFromMenuEvent>(_generateAiProductDataFromMenu);
    on<PostNewProductEvent>(_postNewProduct);}

  EventTransformer<T> droppableProMax<T extends EventWithReload>() {
    return (events, mapper) {
      return events.transform(ExhaustMapStreamTransformer(mapper));
    };
  }

  FutureOr<void> _fetchCategories(FetchCategoriesEvent event, Emitter<ProductsState> emit) async {
    if (!state.categories!.isEndPage || event.isReload) {
      emit(state.copyWith(categories: state.categories!.setLoading(isReload: event.isReload)));
      final res = await fetchCategoriesUseCase(event.params);
      res.fold(
        (l) {
          emit(
            state.copyWith(
              categories: state.categories!.setFaild(errorMessage: l.message),
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          add(FetchProductsEvent(params: FetchProductsParams(categoryId: r.data![0].id!, page: 1)));
          emit(state.copyWith(categories: state.categories!.setSuccess(data: r.data!)));
        },
      );
    }
  }

  FutureOr<void> _fetchProducts(FetchProductsEvent event, Emitter<ProductsState> emit) async {
    if (!state.products!.isEndPage || event.isReload) {
      emit(state.copyWith(products: state.products!.setLoading(isReload: event.isReload)));
      final res = await fetchProductsUseCase(event.params);
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


  FutureOr<void> _generateAiProductImage(GenerateAiProductImageEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(generateAiProductImageStatus: BlocStatus.loading));
    final res = await generateAiProductImageUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        generateAiProductImageStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        generateAiProductImageStatus: BlocStatus.success,
        generateAiProductImage: r,
      ));
    });
  }

  FutureOr<void> _generateAiProductDataFromImage(GenerateAiProductDataFromImageEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(generateAiProductDataFromImageStatus: BlocStatus.loading));
    final res = await generateAiProductDataFromImageUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        generateAiProductDataFromImageStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        generateAiProductDataFromImageStatus: BlocStatus.success,
        generateAiProductDataFromImage: r,
      ));
    });
  }

  FutureOr<void> _generateAiProductDataFromMenu(GenerateAiProductDataFromMenuEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(generateAiProductDataFromMenuStatus: BlocStatus.loading));
    final res = await generateAiProductDataFromMenuUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        generateAiProductDataFromMenuStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        generateAiProductDataFromMenuStatus: BlocStatus.success,
        generateAiProductDataFromMenu: r,
      ));
    });
  }

  FutureOr<void> _postNewProduct(PostNewProductEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(newProductStatus: BlocStatus.loading));
    final res = await postNewProductUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        newProductStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        newProductStatus: BlocStatus.success,
        newProduct: r,
      ));
    });
  }}
