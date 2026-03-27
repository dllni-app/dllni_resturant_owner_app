import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/fetch_notifications_model.dart';

@lazySingleton
class FetchNotificationsUseCase implements UseCase<FetchNotificationsModel, FetchNotificationsParams> {
  final HomeRepo home;

  FetchNotificationsUseCase({required this.home});

  @override
  DataResponse<FetchNotificationsModel> call(FetchNotificationsParams params) {
    return home.fetchNotifications(params);
  }
}

class FetchNotificationsParams with Params {
  final String status;

  FetchNotificationsParams({required this.status});

  /// Tab must be query params for GET; a JSON body on GET is often stripped/blocked (403 HTML from edge).
  @override
  QueryParams getParams() => {'tab': status};
}
