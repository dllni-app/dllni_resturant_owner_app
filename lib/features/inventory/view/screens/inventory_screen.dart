import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/inventory/domain/usecases/fetch_inventory_items_use_case.dart';
import 'package:dllni_resturant_owner_app/features/inventory/domain/usecases/fetch_inventory_summary_use_case.dart';
import 'package:dllni_resturant_owner_app/features/inventory/domain/usecases/delete_inventory_item_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_inventory_item_screen.dart';
import '../manager/bloc/inventory_bloc.dart';
import '../widgets/inventory_app_bar.dart';
import '../widgets/inventory_categories_list.dart';
import '../widgets/inventory_item_card.dart';
import '../widgets/inventory_statistics_grid.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InventoryBloc>(
      create: (context) => getIt<InventoryBloc>()
        ..add(FetchInventorySummaryEvent(params: FetchInventorySummaryParams()))
        ..add(FetchInventoryItemsEvent(params: FetchInventoryItemsParams())),
      child: SafeArea(
        child: Column(
          children: [
            InventoryAppBar(),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: BlocBuilder<InventoryBloc, InventoryState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      context.pushRoute('/inventory/new', arguments: CreateInventoryItemScreenParams(bloc: context.read<InventoryBloc>()));
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: context.primaryContainer),
                      width: context.width,
                      padding: EdgeInsetsDirectional.symmetric(vertical: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle, color: context.onPrimaryContainer, size: 22),
                          SizedBox(width: 8),
                          AppText.labelLarge('إضافة مادة جديدة', color: context.onPrimaryContainer, fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            InventoryStatisticsGrid(),
            SizedBox(height: 16),
            InventoryCategoriesList(),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<InventoryBloc, InventoryState>(
                builder: (context, state) {
                  return state.inventoryItems!.builder(
                    loadingWidget: SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator.adaptive())),
                    emptyWidget: Center(child: AppText.labelLarge('لا يوجد منتجات', fontWeight: FontWeight.bold)),
                    failedWidget: Center(
                      child: AppText.labelLarge(
                        state.inventoryItems?.errorMessage ?? 'حدث خطا ما',
                        fontWeight: FontWeight.bold,
                        color: context.error,
                      ),
                    ),
                    successWidget: () {
                      return ListView.separated(
                        padding: EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 10),
                        itemBuilder: (context, index) {
                          if (state.inventoryItems!.list.length == index) {
                            if (state.inventoryItems!.list.length <= index) {
                              context.read<InventoryBloc>().add(FetchInventoryItemsEvent(params: FetchInventoryItemsParams()));
                            }
                            return SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator.adaptive()));
                          }
                          final item = state.inventoryItems!.list[index];
                          return InventoryItemCard(
                            isLow: item.quantity! <= item.minimumLimit!,
                            productName: item.name!,
                            currentQuantity: '${item.quantity} ${item.unit}',
                            minimumQuantity: '${item.minimumLimit} ${item.unit}',
                            statusText: item.quantity! <= item.minimumLimit! ? 'منخفض' : 'طبيعي',
                            lastUpdated: DateFormat('MM/dd - HH:mm a', 'en').format(DateTime.parse(item.updatedAt!)),
                            cardColor: item.quantity! <= item.minimumLimit! ? context.error : Color(0xff24B364),
                            onIncrement: () {},
                            onDecrement: () {},
                            onAdjustQuantity: () {},
                            onUpdate: () {
                              context.pushRoute(
                                '/inventory/new',
                                arguments: CreateInventoryItemScreenParams(item: item, bloc: context.read<InventoryBloc>()),
                              );
                            },
                            onDelete: () {
                              context.read<InventoryBloc>().add(
                                DeleteInventoryItemEvent(
                                  params: DeleteInventoryItemParams(id: item.id!),
                                  context: context,
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 16),
                        itemCount: state.inventoryItems!.listLength(1),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
