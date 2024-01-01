import 'package:dio/dio.dart';

import 'error_handler.dart';

//
class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 422) {
      HandleError.handleExceptionDio(err.type);
    }
    return super.onError(err, handler);
  }
}
