import 'dart:convert';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/fetch_coupons_model.dart';

@lazySingleton
class FetchCouponsUseCase implements UseCase<FetchCouponsModel, FetchCouponsParams> {
  final ProfileRepo profile;

  FetchCouponsUseCase({required this.profile});

  @override
  DataResponse<FetchCouponsModel> call(FetchCouponsParams params) {
    // #region agent log
    try { final logFile = File(r'g:\my_projects\dllni_com\dllni_resturant_owner_app\.cursor\debug.log'); logFile.writeAsStringSync('${logFile.existsSync() ? logFile.readAsStringSync() : ""}${jsonEncode({"id":"log_${DateTime.now().millisecondsSinceEpoch}","timestamp":DateTime.now().millisecondsSinceEpoch,"location":"fetch_coupons_use_case.dart:18","message":"FetchCouponsUseCase.call entry","data":{"status":params.status,"search":params.search},"runId":"run1","hypothesisId":"A"})}\n', mode: FileMode.append); } catch (_) {}
    // #endregion
    return profile.fetchCoupons(params);
  }
}

class FetchCouponsParams with Params {
  final String status;
  final String? search;

  FetchCouponsParams({required this.status, this.search});

  @override
  QueryParams getParams() {
    // #region agent log
    try { final logFile = File(r'g:\my_projects\dllni_com\dllni_resturant_owner_app\.cursor\debug.log'); final params = {"status": status, "search": search}..removeWhere((key, value) => value == null); logFile.writeAsStringSync('${logFile.existsSync() ? logFile.readAsStringSync() : ""}${jsonEncode({"id":"log_${DateTime.now().millisecondsSinceEpoch}","timestamp":DateTime.now().millisecondsSinceEpoch,"location":"fetch_coupons_use_case.dart:30","message":"FetchCouponsParams.getParams","data":{"params":params},"runId":"post-fix","hypothesisId":"A"})}\n', mode: FileMode.append); } catch (_) {}
    // #endregion
    return {"status": status, "search": search}..removeWhere((key, value) => value == null);
  }

  @override
  BodyMap getBody() {
    // #region agent log
    try { final logFile = File(r'g:\my_projects\dllni_com\dllni_resturant_owner_app\.cursor\debug.log'); final body = {}; logFile.writeAsStringSync('${logFile.existsSync() ? logFile.readAsStringSync() : ""}${jsonEncode({"id":"log_${DateTime.now().millisecondsSinceEpoch}","timestamp":DateTime.now().millisecondsSinceEpoch,"location":"fetch_coupons_use_case.dart:36","message":"FetchCouponsParams.getBody","data":{"body":body},"runId":"post-fix","hypothesisId":"A"})}\n', mode: FileMode.append); } catch (_) {}
    // #endregion
    return {};
  }
}
