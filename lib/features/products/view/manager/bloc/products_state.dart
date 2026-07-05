part of 'products_bloc.dart';

class ProductsState {
  BlocStatus? newProductStatus;
  PostNewProductModel? newProduct;
  BlocStatus? postProductsFromMenuStatus;
  PostProductsFromMenuResult? postProductsFromMenuResult;
  BlocStatus? updateProductStatus;
  PostNewProductModel? updatedProduct;
  BlocStatus? deleteProductStatus;
  DeleteProductModel? deletedProduct;
  BlocStatus? generateAiProductDataFromMenuStatus;
  GenerateAiProductDataFromMenuModel? generateAiProductDataFromMenu;
  BlocStatus? generateAiProductDataFromImageStatus;
  GenerateAiProductDataFromImageModel? generateAiProductDataFromImage;
  BlocStatus? generateAiProductImageStatus;
  GenerateAiProductImageModel? generateAiProductImage;
  PaginationStateModel<FetchProductsModelDataItem>? products;
  PaginationStateModel<FetchCategoriesModelDataItem>? categories;
  String? errorMessage;

  ProductsState({
    this.errorMessage,
    this.categories = const PaginationStateModel(perPage: 10),
    this.products = const PaginationStateModel(perPage: 10),
    this.generateAiProductImage,
    this.generateAiProductImageStatus,
    this.generateAiProductDataFromImage,
    this.generateAiProductDataFromImageStatus,
    this.generateAiProductDataFromMenu,
    this.generateAiProductDataFromMenuStatus,
    this.newProduct,
    this.newProductStatus,
    this.postProductsFromMenuStatus,
    this.postProductsFromMenuResult,
    this.updateProductStatus,
    this.updatedProduct,
    this.deleteProductStatus,
    this.deletedProduct,
  });

  ProductsState copyWith({
    String? errorMessage,
    PaginationStateModel<FetchCategoriesModelDataItem>? categories,
    PaginationStateModel<FetchProductsModelDataItem>? products,
    GenerateAiProductImageModel? generateAiProductImage,
    BlocStatus? generateAiProductImageStatus,
    GenerateAiProductDataFromImageModel? generateAiProductDataFromImage,
    BlocStatus? generateAiProductDataFromImageStatus,
    GenerateAiProductDataFromMenuModel? generateAiProductDataFromMenu,
    BlocStatus? generateAiProductDataFromMenuStatus,
    PostNewProductModel? newProduct,
    BlocStatus? newProductStatus,
    PostProductsFromMenuResult? postProductsFromMenuResult,
    BlocStatus? postProductsFromMenuStatus,
    PostNewProductModel? updatedProduct,
    BlocStatus? updateProductStatus,
    DeleteProductModel? deletedProduct,
    BlocStatus? deleteProductStatus,
  }) => ProductsState(
    errorMessage: errorMessage ?? this.errorMessage,
    categories: categories ?? this.categories,
    products: products ?? this.products,
    generateAiProductImage: generateAiProductImage ?? this.generateAiProductImage,
    generateAiProductImageStatus: generateAiProductImageStatus ?? this.generateAiProductImageStatus,
    generateAiProductDataFromImage: generateAiProductDataFromImage ?? this.generateAiProductDataFromImage,
    generateAiProductDataFromImageStatus: generateAiProductDataFromImageStatus ?? this.generateAiProductDataFromImageStatus,
    generateAiProductDataFromMenu: generateAiProductDataFromMenu ?? this.generateAiProductDataFromMenu,
    generateAiProductDataFromMenuStatus: generateAiProductDataFromMenuStatus ?? this.generateAiProductDataFromMenuStatus,
    newProduct: newProduct ?? this.newProduct,
    newProductStatus: newProductStatus ?? this.newProductStatus,
    postProductsFromMenuResult: postProductsFromMenuResult ?? this.postProductsFromMenuResult,
    postProductsFromMenuStatus: postProductsFromMenuStatus ?? this.postProductsFromMenuStatus,
    updatedProduct: updatedProduct ?? this.updatedProduct,
    updateProductStatus: updateProductStatus ?? this.updateProductStatus,
    deletedProduct: deletedProduct ?? this.deletedProduct,
    deleteProductStatus: deleteProductStatus ?? this.deleteProductStatus,
  );
}
