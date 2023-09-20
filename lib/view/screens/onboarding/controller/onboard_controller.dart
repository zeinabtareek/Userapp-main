import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/authenticate/presentation/login-with-pass/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';

import '../../../../authenticate/config/config.dart';
import '../../../../authenticate/presentation/controller/auth_controller.dart';
import '../../../../initialize_dependencies.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/images.dart';
import '../model/onboard_model.dart';

class OnBoardingController extends GetxController {
  final fixedIncrease = (100 / 3).obs;
  final next = 100.0.obs;
  final prev = (100 / 3).obs;
  final currentIndex = 0.obs;
  final  pageController = PageController();
  onInit() {
    super.onInit();
    next.value = 100 - prev.value;
  }

  onTap() async {

    if (prev.value < 100 && currentIndex.value !=2) {
      prev.value += fixedIncrease.value;
      next.value -= fixedIncrease.value;
      pageController.animateToPage(
        currentIndex.value=currentIndex.value+1, duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,);
    } else {
      // Get.offAll(SignInScreen(),binding:  BindingsBuilder(
      //       () {
      //     Get.put( AuthController(sl()));
      //   },
      // ));
      Get.offAllNamed(AuthScreenPath.loginScreenWithPassRouteName);
      // Get.offAll(DashboardScreen());
    }
    print(prev.value);
  }

  setPreviousAgain() {
    prev.value = 100 - next.value;
  }


  onPageChanged (value) {
     currentIndex.value = value;
  }




  List<OnboardingModel> tabs = [
    OnboardingModel(
     Images.onboard1,
      Strings.onBoardTitle1.tr,
      Strings.onBoardSubTitle1.tr,
    ),

    OnboardingModel(
      Images.onboard2,
      Strings.onBoardTitle2.tr,
      Strings.onBoardSubTitle2.tr,

    ),
    OnboardingModel(
      Images.onboard3,
      Strings.onBoardTitle3.tr,
      Strings.onBoardSubTitle3.tr,
    ),

  ];


}
