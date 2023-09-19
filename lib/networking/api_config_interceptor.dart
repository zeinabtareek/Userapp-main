import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ride_sharing_user_app/authenticate/data/models/res-models/user_model.dart';
import 'package:ride_sharing_user_app/authenticate/domain/use-cases/auth_cases.dart';
import 'package:ride_sharing_user_app/initialize_dependencies.dart';

import '../helper/network_info.dart';

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

    if (await sl<AuthCases>().isAuthenticated()) {
      User? user =
          await sl<AuthCases>().getUserData();
          
          options.headers.addAll({
            "Authorization":"Bearer ${user!.tkn}"
          });
    }

    debugPrint(
      '$loggingTag-REQUEST[${options.method}] => PATH: ${options.path} \n Body [${options.data}]',
    );


    if (!await NetworkInfo.isConnected()) {
      throw DioException.connectionError(
          reason: "No Internet connection ", requestOptions: options);
    }
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
