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
import '../../../domain/usecases/post_products_from_menu_use_case.dart';
import '../../../domain/usecases/update_product_use_case.dart';
import '../../../domain/usecases/delete_product_use_case.dart';
import '../../../data/models/delete_product_model.dart';

part 'products_event.dart';

part 'products_state.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final DeleteProductUseCase deleteProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final PostNewProductUseCase postNewProductUseCase;
  final PostProductsFromMenuUseCase postProductsFromMenuUseCase;
  final GenerateAiProductDataFromMenuUseCase generateAiProductDataFromMenuUseCase;
  final GenerateAiProductDataFromImageUseCase generateAiProductDataFromImageUseCase;
  final GenerateAiProductImageUseCase generateAiProductImageUseCase;
  final FetchProductsUseCase fetchProductsUseCase;
  final FetchCategoriesUseCase fetchCategoriesUseCase;

  ProductsBloc(this.fetchCategoriesUseCase, this.fetchProductsUseCase,
    this.generateAiProductImageUseCase,
    this.generateAiProductDataFromImageUseCase,
    this.generateAiProductDataFromMenuUseCase,
    this.updateProductUseCase,
    this.deleteProductUseCase,
    this.postNewProductUseCase,
    this.postProductsFromMenuUseCase)
    : super(ProductsState()) {
    on<FetchCategoriesEvent>(_fetchCategories, transformer: droppableProMax());
    on<FetchProductsEvent>(_fetchProducts, transformer: droppableProMax());
  
    on<GenerateAiProductImageEvent>(_generateAiProductImage);
    on<GenerateAiProductDataFromImageEvent>(_generateAiProductDataFromImage);
    on<GenerateAiProductDataFromMenuEvent>(_generateAiProductDataFromMenu);
    on<PostNewProductEvent>(_postNewProduct);
    on<PostProductsFromMenuEvent>(_postProductsFromMenu);
    on<UpdateProductEvent>(_updateProduct);
    on<DeleteProductEvent>(_deleteProduct);
  }

  EventTransformer<T> droppableProMax<T extends EventWithReload>() {
    return (events, mapper) {
      return events.transform(ExhaustMapStreamTransformer(mapper));
    };
  }

  FutureOr<void> _fetchCategories(FetchCategoriesEvent event, Emitter<ProductsState> emit) async {
    if (!state.categories!.isEndPage || event.isReload) {
      if (state.categories!.status == BlocStatus.loading && !event.isReload) return;
      emit(state.copyWith(categories: state.categories!.setLoading(isReload: event.isReload)));
      final res = await fetchCategoriesUseCase(event.params);
      res.fold(
        (l) {
          if (isClosed) return;
          emit(
            state.copyWith(
              categories: state.categories!.setFaild(errorMessage: l.message),
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          if (isClosed) return;
          final categories = r.data ?? [];
          if (categories.isNotEmpty && categories.first.id != null) {
            add(
              FetchProductsEvent(
                params: FetchProductsParams(
                  categoryId: categories.first.id!,
                  page: 1,
                ),
              ),
            );
          }
          emit(state.copyWith(categories: state.categories!.setSuccess(data: categories)));
        },
      );
    }
  }

  FutureOr<void> _fetchProducts(FetchProductsEvent event, Emitter<ProductsState> emit) async {
    if (!state.products!.isEndPage || event.isReload) {
      if (state.products!.status == BlocStatus.loading && !event.isReload) return;
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
  }

  FutureOr<void> _postProductsFromMenu(PostProductsFromMenuEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(postProductsFromMenuStatus: BlocStatus.loading));
    final res = await postProductsFromMenuUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        postProductsFromMenuStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        postProductsFromMenuStatus: BlocStatus.success,
        postProductsFromMenuResult: r,
      ));
    });
  }

  FutureOr<void> _updateProduct(UpdateProductEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(updateProductStatus: BlocStatus.loading));
    final res = await updateProductUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        updateProductStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        updateProductStatus: BlocStatus.success,
        updatedProduct: r,
      ));
      add(FetchProductsEvent(
        params: event.refreshParams,
        isReload: true,
      ));
    });
  }

  FutureOr<void> _deleteProduct(DeleteProductEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(deleteProductStatus: BlocStatus.loading));
    final res = await deleteProductUseCase(event.params);
    res.fold((l) {
      emit(state.copyWith(
        deleteProductStatus: BlocStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        deleteProductStatus: BlocStatus.success,
        deletedProduct: r,
      ));
      add(FetchProductsEvent(
        params: event.refreshParams,
        isReload: true,
      ));
    });
  }
}
