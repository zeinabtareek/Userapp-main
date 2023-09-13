import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiConfigInterceptor extends InterceptorsWrapper {
  final loggingTag = "DIO_TAG";

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // options.queryParameters.addAll(
    //   {
    //     AppGlobalConstants.queryApiKey: AppGlobalConstants.moviesAPIKey,
    //     AppGlobalConstants.queryLanguage: AppGlobalConstants.language,
    //   },
    // );
    debugPrint('interceptor $loggingTag');

    debugPrint(
      '$loggingTag-REQUEST[${options.method}] => PATH: ${options.path} \n Body [${options.data}]',
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      '$loggingTag-RESPONSE[${response.data}] => EXTRAS: ${response.extra} \n Body [${response.data}]',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      '$loggingTag-ERROR[${err.error}] => MESSAGE: ${err.message}|| StackTrace: ${err.stackTrace} \n Body [${err.response?.data}]',
    );
    if (err.response == null) {
      handler.resolve(
        Response(
          requestOptions: err.requestOptions,
          data: <String, dynamic>{},
        ),
      );
    } else {
      handler.resolve(err.response!);
    }
  }
}
