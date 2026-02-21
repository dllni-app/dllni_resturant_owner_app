import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/reject_order_usecase_model.dart';

@lazySingleton
class RejectOrderUsecaseUseCase implements UseCase<RejectOrderUsecaseModel, RejectOrderUsecaseParams> {

  final HomeRepo home;

  RejectOrderUsecaseUseCase({required this.home});

  @override
  DataResponse<RejectOrderUsecaseModel> call(RejectOrderUsecaseParams params) {
    return home.rejectOrderUsecase(params);
  }
}

class RejectOrderUsecaseParams with Params{
  final int orderId;

  RejectOrderUsecaseParams({required this.orderId});
}
