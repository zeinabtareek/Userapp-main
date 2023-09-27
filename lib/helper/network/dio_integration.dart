import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../util/app_constants.dart';
import 'dio_interceptors.dart';

class DioUtilNew {
  static DioUtilNew? _instance;
  static Dio? _dio;

  static DioUtilNew? getInstance() {
    if (_instance == null) {
      _dio = Dio(_getOptions());
      _dio!.interceptors.add(LoggingInterceptor());
      _dio!.interceptors.add((PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      )));
    }
    return _instance;
  }

  static Dio? get dio => _dio;

  static void setDioAgain() {
    _dio = Dio(_getOptions());
  }

  static BaseOptions _getOptions() {
    String dummyTokken="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTcyLjE2LjEzLjIyOjgwMDAvYXBpL3VzZXIvdmVyaWZ5X3Bob25lIiwiaWF0IjoxNjk1ODA2MzM5LCJleHAiOjE3MjczNDIzMzksIm5iZiI6MTY5NTgwNjMzOSwianRpIjoiV0o4d0p5cENzdXZvRjU0SSIsInN1YiI6IjIiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.VoRgxfRYl8PIjVMAu0auMe1MfzjOzh-o1cAfyv3nysw";
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) => status! <= 500,
    );

    options.connectTimeout = const Duration(minutes: 1); //10 sec
    options.receiveTimeout = const Duration(minutes: 1); //20 sec
    options.baseUrl = AppConstants.baseUrl;
    options.headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': "Bearer ${CacheHelper.getData(key: AppConstants.token)}",
      'Authorization': 'Bearer $dummyTokken'


    // AppConstants.acceptLanguage: languageCode ?? AppConstants.languages[0].languageCode,

    //     CacheHelper.getData(key: AppConstants.languageCode) == "en"
      //         ? "en-US"
      //         : "ar-EG"
    };
    options.queryParameters = {};

    return options;
  }

//this just returns the language key
}
