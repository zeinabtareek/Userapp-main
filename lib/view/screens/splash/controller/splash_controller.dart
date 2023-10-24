import 'dart:async';

import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';

class  SplashController extends GetxController{



  @override
  void onInit() {
     super.onInit();


     Timer(
         Duration(seconds: 5), () async {

       Get.offAll(  DashboardScreen());
     });
  }
}