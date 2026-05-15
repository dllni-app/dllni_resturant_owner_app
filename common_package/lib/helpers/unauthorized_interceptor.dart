import 'package:dio/dio.dart';

/// Runs [onUnauthorized] at most once until that callback's [Future] completes.
///
/// The handler should await navigation to login (until that route is popped);
/// otherwise it may finish too early and each additional 401 would invoke
/// [onUnauthorized] again. Forwards the error so callers still receive the
/// [DioException].
class UnauthorizedInterceptor extends Interceptor {
  UnauthorizedInterceptor({
    required this.onUnauthorized,
    this.excludedPathSuffixes = const [],
  });

  final Future<void> Function()? onUnauthorized;
  final List<String> excludedPathSuffixes;

  static bool _handlingUnauthorized = false;

  bool _isExcluded(RequestOptions options) {
    final path = options.uri.path;
    for (final suffix in excludedPathSuffixes) {
      if (path.endsWith(suffix)) {
        return true;
      }
    }
    return false;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final status = err.response?.statusCode;
    if (status == 401 && !_isExcluded(err.requestOptions)) {
      if (!_handlingUnauthorized) {
        _handlingUnauthorized = true;
        final future = onUnauthorized?.call();
        if (future != null) {
          future.whenComplete(() {
            _handlingUnauthorized = false;
          });
        } else {
          _handlingUnauthorized = false;
        }
      }
    }
    return super.onError(err, handler);
  }
}
