import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/inventory_repo.dart';
import '../../data/models/fetch_inventory_summary_model.dart';

@lazySingleton
class FetchInventorySummaryUseCase implements UseCase<FetchInventorySummaryModel, FetchInventorySummaryParams> {

  final InventoryRepo inventory;

  FetchInventorySummaryUseCase({required this.inventory});

  @override
  DataResponse<FetchInventorySummaryModel> call(FetchInventorySummaryParams params) {
    return inventory.fetchInventorySummary(params);
  }
}

class FetchInventorySummaryParams with Params{}
