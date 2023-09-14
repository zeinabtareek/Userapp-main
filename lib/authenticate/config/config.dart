import 'package:get/get.dart';

import '../../initialize_dependencies.dart';
import '../presentation/controller/auth_controller.dart';
import '../presentation/forgot_password/forget_password_screen.dart';
import '../presentation/login-with-otp/otp_log_in_screen.dart';
import '../presentation/login-with-pass/sign_in_screen.dart';
import '../presentation/sign-up/sign_up_screen.dart';

class AuthLib {
  AuthLib._();
  static const String routeName = "user/";

  static const String domain = "http://172.16.13.22:8000/api/";
  // end- points

  static const String baseUrl = "$domain$routeName";

  static const String loginWithPassEndPoint = "login";

  static const String loginWithOtpEndPoint = "login_with_otp";

  static const String registerEndPoint = "register";

  static const String completeDataEndPoint = "complete_data";

  static const String verifyPhoneEndPoint = "verify_phone";

  static const String sendOtpEndPoint = "send_otp";

  static const String forgetPasswordEndPoint = "forget_password";

  static const String updatePasswordEndPoint = "update_password";

  static const String changePassEndPoint = "change_password";
  static const String checkOtpEndPoint = "check_code";

  static List<GetPage> authPages = [
    GetPage(
      name: AuthScreenPath.loginScreenWithPassRouteName,
      page: () =>  SignInScreen(),
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
    ),
    GetPage(
      name: AuthScreenPath.forgetPasswordScreenRouteName,
      page: () => const ForgotPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController(sl()));
      }),
    ),
    GetPage(
      name: AuthScreenPath.loginScreenOtpRouteName,
      page: () => const OtpLoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController(sl()));
      }),
    )
  ];
}

class AuthScreenPath {
  AuthScreenPath._();

  static const String loginScreenWithPassRouteName =
      "/loginScreenWithPassRouteName";

  static const String loginScreenOtpRouteName = "/loginScreenOtpRouteName";

  static const String signUpScreenRouteName = '/signUpScreenRouteName';
  static const String forgetPasswordScreenRouteName =
      "/forgetPasswordRouteName";

  static const String otpLoginScreenRouteName = "/otpLoginScreenRouteName";

  static const String otpScreenForgetRouteName = "/otpScreenForgetRouteName";

  static const String verifyPhoneScreenRouteName =
      '/verifyPhoneScreenRouteName';
}
