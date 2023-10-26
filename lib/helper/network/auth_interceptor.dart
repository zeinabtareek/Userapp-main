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
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vYXJhYmNoYW5jZS5jb20vSG9vZC1CYWNrZW5kLURhc2hib2FyZC9wdWJsaWMvYXBpL3VzZXIvbG9naW4iLCJpYXQiOjE2OTc5NzAwNTgsImV4cCI6MTcyOTUwNjA1OCwibmJmIjoxNjk3OTcwMDU4LCJqdGkiOiJVNDBsSzZQSVZQbGFsWTljIiwic3ViIjoiMTAiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.fCRqwliUR5kuze2c4fllN4Vy9ZcmV39wsi_oEsFRUl0";

      // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTcyLjE2LjEzLjIyOjgwMDAvYXBpL2RyaXZlci9sb2dpbiIsImlhdCI6MTY5NjI0NTE2NywiZXhwIjoxNzI3NzgxMTY3LCJuYmYiOjE2OTYyNDUxNjcsImp0aSI6IlNTcUE5b3dJSmJQU2lqeE0iLCJzdWIiOiIxIiwicHJ2IjoiOTE5YzMyNmQ0M2FiMTUxOWE4YmEzYjg1ODZiNjg3NTJlOGM4MzgwNyJ9.5NSiFX1ot3uk4UiA2RYm7xEV1zlSfQethXzEgt7IbNA";
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
