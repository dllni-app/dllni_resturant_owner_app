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

  DataResponse<ReadAllNotificationsModel> readOne(String notificationId) {
    return home.readNotification(notificationId);
  }

  DataResponse<ReadAllNotificationsModel> deleteOne(String notificationId) {
    return home.deleteNotification(notificationId);
  }

  DataResponse<ReadAllNotificationsModel> deleteAll() {
    return home.deleteAllNotifications();
  }
}
