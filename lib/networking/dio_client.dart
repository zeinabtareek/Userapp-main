// import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import 'api_config_interceptor.dart';

class DioClient {
  static Dio? dio;
  // static DioAdapter? dioAdapter;
  static Dio get instance => getInstance();
  static Dio getInstance() {
    if (dio != null) return dio!;
    dio = Dio();
    dio?.interceptors.add(LogInterceptor());
    // dio?.interceptors.add(ChuckerDioInterceptor());
    dio?.interceptors.add(ApiConfigInterceptor());
    // if (ApiConstants.enableMockUp) {
    //   dioAdapter = DioAdapter(dio: dio!);
    //   dio!.httpClientAdapter = dioAdapter!;
    // }
    // dio?.interceptors.add(
    //   DioCacheManager(
    //     CacheConfig(
    //       baseUrl: ApiConstants.baseDevUrl,
    //     ),
    //   ).interceptor,
    // );
    return dio!;
  }
}
