import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/fetch_categories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/products_bloc.dart';
import '../manager/products_notifier.dart';
import 'products_style_tokens.dart';

class ProductsTabBar extends StatefulWidget {
  const ProductsTabBar({super.key, required this.productsNotifier});

  final ProductsNotifier productsNotifier;

  @override
  State<ProductsTabBar> createState() => _ProductsTabBarState();
}

class _ProductsTabBarState extends State<ProductsTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      width: double.infinity,
      child: BlocBuilder<ProductsBloc, ProductsState>(
        buildWhen: (pre, cur) => pre.categories != cur.categories,
        builder: (context, state) {
          return state.categories!.builder(
            loadingWidget: LoadingMoreRow(),
            emptyWidget: Center(child: AppText.labelMedium('لا يوجد تصنيفات')),
            failedWidget: Center(child: AppText.labelMedium(state.categories?.errorMessage ?? 'حدث خطأ ما', color: context.error)),
            successWidget: () {
              return ListView.separated(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (state.categories!.list.length == index) {
                    if (!state.categories!.isEndPage && state.categories!.status != BlocStatus.loading) {
                      context.read<ProductsBloc>().add(FetchCategoriesEvent(params: FetchCategoriesParams(page: state.categories!.pageNumber)));
                    }
                    return LoadingMoreRow();
                  }
                  return InkWell(
                    borderRadius: BorderRadius.circular(99),
                    onTap: () {
                      final categoryId = state.categories!.list[index].id!;
                      setState(() => selectedIndex = index);
                      widget.productsNotifier.changeSelectedCategoryId(categoryId);
                      context.read<ProductsBloc>().add(
                            FetchProductsEvent(params: widget.productsNotifier.fetchParams(page: 1, categoryId: categoryId), isReload: true),
                          );
                    },
                    child: _CategoryChip(
                      title: state.categories!.list[index].name!,
                      count: state.categories!.list[index].products?.length ?? 0,
                      isSelected: selectedIndex == index,
                    ),
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemCount: state.categories!.listLength(1),
              );
            },
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.isSelected, required this.title, required this.count});

  final bool isSelected;
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? ProductsStyleTokens.titleColor : ProductsStyleTokens.cardBackground,
        borderRadius: ProductsStyleTokens.chipRadius,
        border: isSelected ? null : const Border.fromBorderSide(BorderSide(color: ProductsStyleTokens.lineLight)),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: isSelected ? Colors.white : ProductsStyleTokens.textMid,
        ),
      ),
    );
  }
}

class LoadingMoreRow extends StatelessWidget {
  const LoadingMoreRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsDirectional.only(top: 6, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: ProductsStyleTokens.textHint)),
          SizedBox(width: 8),
          Text(
            'جاري تحميل المزيد...',
            style: TextStyle(color: ProductsStyleTokens.textHint, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
