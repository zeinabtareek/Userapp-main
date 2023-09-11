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
      '$loggingTag-REQUEST[${options.method}] => PATH: ${options.path}',
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      '$loggingTag-RESPONSE[${response.data}] => EXTRAS: ${response.extra}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
      '$loggingTag-ERROR[${err.error}] => MESSAGE: ${err.message}|| StackTrace: ${err.stackTrace}',
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
