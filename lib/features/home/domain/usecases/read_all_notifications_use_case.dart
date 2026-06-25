import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/read_all_notifications_model.dart';

@lazySingleton
class ReadAllNotificationsUseCase implements UseCase<ReadAllNotificationsModel, NoParams> {
  final HomeRepo home;

  ReadAllNotificationsUseCase({required this.home});

  @override
  DataResponse<ReadAllNotificationsModel> call(NoParams params) {
    return home.readAllNotifications();
  }
}

// class ReadAllNotificationsParams with Params {
//   final String tab;
//
//   ReadAllNotificationsParams({required this.tab});
//
//   @override
//   BodyMap getBody() => {'tab': tab};
// }
