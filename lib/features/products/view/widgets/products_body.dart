import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/fetch_products_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/products_bloc.dart';
import '../manager/products_notifier.dart';
import 'big_button_with_icon.dart';
import 'product_card.dart';
import 'products_tab_bar.dart';
import 'state_pointer.dart';
import '../screens/add_new_product_screen.dart';

class ProductsBody extends StatefulWidget {
  const ProductsBody({super.key});

  @override
  State<ProductsBody> createState() => _ProductsBodyState();
}

class _ProductsBodyState extends State<ProductsBody> {
  final ProductsNotifier productsNotifier = ProductsNotifier();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 14, 20, 0),
          child: BigButtonWithIcon(
            title: 'إضافة منتج جديد',
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushRoute(
                '/products/new_product',
                arguments: const AddNewProductScreenParams(),
              );
            },
          ),
        ),
        // const Padding(
        //   padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
        //   child: Row(
        //     children: [
        //       Expanded(child: StatePointer(title: 'إجمالي المنتجات النشطة', value: 142)),
        //       SizedBox(width: 12),
        //       Expanded(child: StatePointer(title: 'منخفض المخزون', value: 8, isCritical: true)),
        //     ],
        //   ),
        // ),
        ProductsTabBar(productsNotifier: productsNotifier),
        Expanded(
          child: BlocBuilder<ProductsBloc, ProductsState>(
            buildWhen: (pre, cur) => pre.products != cur.products,
            builder: (context, state) {
              return state.products!.builder(
                loadingWidget: LoadingMoreRow(),
                failedWidget: Center(
                  child: AppText.labelLarge(
                    state.products?.errorMessage ?? 'خطا في تحميل المنتجات',
                    color: context.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                emptyWidget: Center(child: AppText.labelLarge('لا يوجد منتجات', fontWeight: FontWeight.bold)),
                successWidget: () {
                  return ValueListenableBuilder(
                    valueListenable: productsNotifier.selectedCategoryId,
                    builder: (context, id, _) => ListView.separated(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 18),
                      separatorBuilder: (context, index) => const SizedBox(height: 14),
                      itemCount: state.products!.listLength(1),
                      itemBuilder: (context, index) {
                        if (state.products!.list.length == index) {
                          if (!state.products!.isEndPage && state.products!.status != BlocStatus.loading) {
                            context.read<ProductsBloc>().add(
                              FetchProductsEvent(
                                params: FetchProductsParams(categoryId: id, page: state.products!.pageNumber),
                                isReload: false,
                              ),
                            );
                          }
                          return LoadingMoreRow();
                        }
                        return ProductCard(product: state.products!.list[index],);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
