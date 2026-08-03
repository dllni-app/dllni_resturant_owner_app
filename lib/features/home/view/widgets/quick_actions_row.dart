import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/inventory/view/manager/bloc/inventory_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/seller_permission_access.dart';
import '../../../../generated/assets.dart';
import '../../../inventory/view/screens/create_inventory_item_screen.dart';
import '../../../products/view/screens/add_product_details_screen.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final access = SellerPermissionAccess.current();
    final actions = <_QuickAction>[
      if (access.can(RestaurantPermissionCodes.meals))
        _QuickAction(
          title: 'منتج جديد',
          isPrimary: true,
          onTap: () {
            context.pushRoute(
              '/products/new_product/details',
              arguments: AddProductDetailsScreenParams(),
            );
          },
        ),
      if (access.can(RestaurantPermissionCodes.offersAndCoupons))
        _QuickAction(
          title: 'إنشاء عرض',
          image: Assets.images.newOfferAction.path,
          onTap: () => context.pushRoute('/offersmanagement/new'),
        ),
      if (access.can(RestaurantPermissionCodes.warehouse))
        _QuickAction(
          title: 'تعديل مخزون',
          image: Assets.images.updateInventoryAction.path,
          onTap: () {
            context.pushRoute(
              '/inventory/new',
              arguments: CreateInventoryItemScreenParams(
                bloc: getIt<InventoryBloc>(),
              ),
            );
          },
        ),
      if (access.hasFullAccess)
        _QuickAction(
          title: 'التقارير',
          image: Assets.images.reportsAction.path,
          onTap: () => context.pushRoute('/performance-reports'),
        ),
    ];

    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      spacing: 12,
      children: actions
          .map(
            (action) => Expanded(
              child: InkWell(
                onTap: action.onTap,
                borderRadius: BorderRadius.circular(24),
                child: Column(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(7),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xffF3F4F6),
                          width: 1,
                        ),
                        color: action.isPrimary
                            ? context.primaryContainer
                            : context.onPrimaryContainer,
                      ),
                      padding: const EdgeInsetsDirectional.all(15),
                      child: action.isPrimary
                          ? Icon(
                              Icons.add,
                              color: context.onPrimaryContainer,
                            )
                          : AppImage.asset(action.image!),
                    ),
                    const SizedBox(height: 8),
                    AppText.labelMedium(
                      action.title,
                      color: const Color(0xff4B5563),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _QuickAction {
  const _QuickAction({
    required this.title,
    required this.onTap,
    this.image,
    this.isPrimary = false,
  });

  final String title;
  final String? image;
  final bool isPrimary;
  final VoidCallback onTap;
}
