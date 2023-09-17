import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/onboarding/componants/pie_chart.dart';
import '../../../../util/app_style.dart';
import '../model/pie_chard_model.dart';

pieChartWidget({onTap, dynamic previous, dynamic next ,isLast,String ?text}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(Get.context!).size.width / 5,
        height: MediaQuery.of(Get.context!).size.height / 10,
        child: PieChart(
          data: [
            PieChartData(Theme.of(Get.context!).primaryColor, next),
            PieChartData(
                Theme.of(Get.context!).primaryColor.withOpacity(.4), previous),
          ],
          radius: 80,
          strokeWidth: 8,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).primaryColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white, width: 5),
            ),
            child:   Center(
              child: isLast?Text(text??'',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: Dimensions.fontSizeExtraLarge),): const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
}
