import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';

class OnBoardController extends GetxController  implements GetxService{
  int pageIndex = 0;
  final  pageController=PageController();

  late Animation<double> opacityAnimation;
  void onPageChanged(int index){
    pageIndex = index;
    update();
  }

  void onPageIncrement(){
    if(AppConstants.onBoardPagerData.length-1>pageIndex){
      pageController.animateToPage(pageIndex=pageIndex+1, duration: Duration(seconds: 1),
        curve: Curves.easeIn,);
    }
    update();


    // if(AppConstants.onBoardPagerData.length-1>pageIndex){
    //   pageIndex++;
    // }
    // update();
  }


}