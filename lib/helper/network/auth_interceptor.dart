import 'package:dio/dio.dart';

import '../../authenticate/data/models/res-models/user_model.dart';
import '../../authenticate/domain/use-cases/auth_cases.dart';
import '../../initialize_dependencies.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (await sl<AuthCases>().isAuthenticated()) {
    // if (false) {
      UserAuthModel? user = await sl<AuthCases>().getUserData();

      options.headers.addAll({"Authorization": "Bearer ${user!.tkn}"});
    } else {
      // TODO: remove
      String dummyTokken =
          // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FyYWJjaGFuY2UuY29tL0hvb2QtQmFja2VuZC1EYXNoYm9hcmQvcHVibGljL2FwaS91c2VyL2xvZ2luIiwiaWF0IjoxNjk4MzExODcyLCJleHAiOjE3Mjk4NDc4NzIsIm5iZiI6MTY5ODMxMTg3MiwianRpIjoidHJPc1UyM3ZwYjJhR21UZiIsInN1YiI6IjEwIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.vjXPuBqwOeClZMiRSf2J3lM8t5b5XkJ_EK9ye37rA3w";
"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FyYWJjaGFuY2UuY29tL0hvb2QtQmFja2VuZC1EYXNoYm9hcmQvcHVibGljL2FwaS91c2VyL2xvZ2luIiwiaWF0IjoxNjk3NjA5NTM0LCJleHAiOjE3MjkxNDU1MzQsIm5iZiI6MTY5NzYwOTUzNCwianRpIjoiVm5tRjUxcjQ0R2ZqN1NleSIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.yG-uhU_pA3DhsjKBX_Mbc4oVyDO5-HJ-TCBLPyDHUjU";
      // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FyYWJjaGFuY2UuY29tL0hvb2QtQmFja2VuZC1EYXNoYm9hcmQvcHVibGljL2FwaS91c2VyL2xvZ2luIiwiaWF0IjoxNjk3NjA5NTM0LCJleHAiOjE3MjkxNDU1MzQsIm5iZiI6MTY5NzYwOTUzNCwianRpIjoiVm5tRjUxcjQ0R2ZqN1NleSIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.yG-uhU_pA3DhsjKBX_Mbc4oVyDO5-HJ-TCBLPyDHUjU";

      options.headers.addAll({"Authorization": "Bearer $dummyTokken",});
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 405) {
      if (await sl<AuthCases>().isAuthenticated()) {
        sl<AuthCases>().setUserDate(null);
        // TODO: action in block case
      }
    }

    super.onResponse(response, handler);
  }
}
