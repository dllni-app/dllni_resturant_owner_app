part of 'products_bloc.dart';

class ProductsState {
  BlocStatus? categoriesStatus;
  GetCategoriesModel? categories;
  PaginationStateModel<GetProductsModelDataItem>? products;
  String? errorMessage;

  ProductsState({this.errorMessage, this.products = const PaginationStateModel(perPage: 10), this.categories, this.categoriesStatus});

  ProductsState copyWith({
    String? errorMessage,
    PaginationStateModel<GetProductsModelDataItem>? products,
    GetCategoriesModel? categories,
    BlocStatus? categoriesStatus,
  }) => ProductsState(
    errorMessage: errorMessage ?? this.errorMessage,
    products: products ?? this.products,
    categories: categories ?? this.categories,
    categoriesStatus: categoriesStatus ?? this.categoriesStatus,
  );
}
