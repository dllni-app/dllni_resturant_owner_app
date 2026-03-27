import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/fetch_working_time_model.dart';

@lazySingleton
class UpdateWorkingTimeUseCase implements UseCase<FetchWorkingTimeDay, UpdateWorkingTimeParams> {
  final ProfileRepo profile;

  UpdateWorkingTimeUseCase({required this.profile});

  @override
  DataResponse<FetchWorkingTimeDay> call(UpdateWorkingTimeParams params) {
    return profile.updateWorkingTime(params);
  }
}

class UpdateWorkingTimeParams with Params {
  final bool isTemporarilyClosed;
  final List<DailyHoursRequest>? dailyHours;

  UpdateWorkingTimeParams({required this.isTemporarilyClosed, this.dailyHours});

  @override
  BodyMap getBody() => {
    'isTemporarilyClosed': isTemporarilyClosed,
    if (dailyHours != null) ...{
      'dailyHours': dailyHours!
          .map(
            (day) => {
              'dayOfWeek': day.dayOfWeek,
              'isEnabled': day.isEnabled,
              'timeSlots': day.timeSlots.map((slot) => {'startTime': slot.startTime, 'endTime': slot.endTime}).toList(),
            },
          )
          .toList(),
    },
  };
}

class DailyHoursRequest {
  final String dayOfWeek;
  final bool isEnabled;
  final List<TimeSlotRequest> timeSlots;

  DailyHoursRequest({required this.dayOfWeek, required this.isEnabled, required this.timeSlots});
}

class TimeSlotRequest {
  final String startTime;
  final String endTime;

  TimeSlotRequest({required this.startTime, required this.endTime});
}
