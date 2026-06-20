import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/products_bloc.dart';
import '../manager/products_notifier.dart';
import 'filter_button.dart';
import 'products_style_tokens.dart';
import 'search_field.dart';

class ProductsAppBar extends StatelessWidget {
  const ProductsAppBar({super.key, required this.productsNotifier});

  final ProductsNotifier productsNotifier;

  void _reload(BuildContext context) {
    context.read<ProductsBloc>().add(FetchProductsEvent(params: productsNotifier.fetchParams(page: 1), isReload: true));
  }

  void _toggleFilter(BuildContext context) {
    final current = productsNotifier.availabilityFilter.value;
    final next = current == null ? true : (current == true ? false : null);
    productsNotifier.changeFilters(availability: next, lowStock: false, discounted: false);
    _reload(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.fromLTRB(16, 14 + MediaQuery.paddingOf(context).top, 16, 18),
      decoration: const BoxDecoration(
        color: ProductsStyleTokens.cardBackground,
        borderRadius: ProductsStyleTokens.appBarRadius,
        border: Border(bottom: BorderSide(width: 2, color: ProductsStyleTokens.primaryAction)),
        boxShadow: [ProductsStyleTokens.softShadow],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المنتجات',
            style: context.textTheme.titleLarge?.copyWith(
              color: ProductsStyleTokens.titleColor,
              fontSize: 38,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SearchField(
                  hintText: 'ابحث عن وجبة، مشروب...',
                  onChanged: (value) {
                    productsNotifier.changeSearchQuery(value);
                    _reload(context);
                  },
                ),
              ),
              const SizedBox(width: 10),
              FilterButton(onTap: () => _toggleFilter(context)),
            ],
          ),
        ],
      ),
    );
  }
}
