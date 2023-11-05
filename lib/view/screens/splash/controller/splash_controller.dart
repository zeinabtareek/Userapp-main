import 'dart:async';

import 'package:get/get.dart';

import '../../../../authenticate/config/config.dart';
import '../../../../authenticate/domain/use-cases/auth_cases.dart';
import '../../../../initialize_dependencies.dart';
import '../../dashboard/dashboard_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // Timer(const Duration(seconds: 5), () async {
    //   Future.delayed(const Duration(milliseconds: 2500), () async {
    Future.delayed(const Duration(milliseconds: 2000), () async {

      if (await sl<AuthCases>().isAuthenticated()) {
          Get.offAll(DashboardScreen());
        } else {
          //  Get.off(const OnBoardingScreen2());
          Get.offAllNamed(AuthScreenPath.loginScreenWithPassRouteName);
        }
      // });
    });
  }
}
