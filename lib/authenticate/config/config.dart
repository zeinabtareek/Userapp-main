import 'package:get/get.dart';

import '../../initialize_dependencies.dart';
import '../presentation/controller/auth_controller.dart';
import '../presentation/login-with-pass/sign_in_screen.dart';
import '../presentation/sign-up/sign_up_screen.dart';

class AuthLib {
  AuthLib._();

  // end- points
  static const String baseUrl = "";

  static const String loginWithPassEndPoint = "";

  static const String loginWithOtpEndPoint = "";

  static const String registerEndPoint = "";

  static const String completeDataEndPoint = "";

  static const String verifyPhoneEndPoint = "";

  static const String sendOtpEndPoint = "";

  static const String forgetPasswordEndPoint = "";

  static const String updatePasswordEndPoint = "";

// TODO:  implent
  static void afterLoginSuccess() {}

  static List<GetPage> authPages = [
    GetPage(
      name: AuthScreenPath.loginScreenRouteName,
      page: () => const SignInScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController(sl()));
      }),
    ),
    GetPage(
      name: AuthScreenPath.signUpScreenRouteName,
      page: () => const SignUpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController(sl()));
      }),
    )
  ];
}

class AuthScreenPath {
  AuthScreenPath._();

  static const String loginScreenRouteName = "/loginScreenRouteName";

  static const String signUpScreenRouteName = '/signUpScreenRouteName';
  static const String forgetPasswordScreenRouteName =
      "/forgetPasswordRouteName";

  static const String otpScreenRouteName = "/otpScreenRouteName";

  static const String verifyPhoneScreenRouteName =
      '/verifyPhoneScreenRouteName';
}
