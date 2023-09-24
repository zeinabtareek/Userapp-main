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
    String dummyTokken="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vaG9vZGJhY2tlbmQuZGV2ZWxvYnVnLmNvbS9hcGkvdXNlci9sb2dpbiIsImlhdCI6MTY5NTU0NTk0NSwiZXhwIjoxNzI3MDgxOTQ1LCJuYmYiOjE2OTU1NDU5NDUsImp0aSI6IkpyTVpyeXhlaVpmQU5lZWoiLCJzdWIiOiIzIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.vem5d-pGU0ag9UlAISo4Z08ilarnkDX4N_fFAN2Df4A";
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
