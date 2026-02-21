import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/accept_order_usecase_model.dart';

@lazySingleton
class AcceptOrderUsecaseUseCase implements UseCase<AcceptOrderUsecaseModel, AcceptOrderUsecaseParams> {

  final HomeRepo home;

  AcceptOrderUsecaseUseCase({required this.home});

  @override
  DataResponse<AcceptOrderUsecaseModel> call(AcceptOrderUsecaseParams params) {
    return home.acceptOrderUsecase(params);
  }
}

class AcceptOrderUsecaseParams with Params{
  final int orderId;

  AcceptOrderUsecaseParams({required this.orderId});
}
