import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import 'filter_button.dart';
import 'products_style_tokens.dart';
import 'search_field.dart';

class ProductsAppBar extends StatelessWidget {
  const ProductsAppBar({super.key});

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
                child: SearchField(hintText: 'ابحث عن وجبة، مشروب...', onChanged: (value) {}),
              ),
              const SizedBox(width: 10),
              const FilterButton(),
            ],
          ),
        ],
      ),
    );
  }
}
