import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/images.dart';
import '../../../util/text_style.dart';
import 'componants/dots_indicator.dart';
import 'componants/page_view_body.dart';
import 'componants/pie_chart.dart';
import 'componants/pie_chart_widget.dart';
import 'controller/onboard_controller.dart';
import 'model/onboard_model.dart';
import 'model/pie_chard_model.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const OnBoardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,actions:[ InkWell(
          onTap: () {
            Get.offAll(DashboardScreen());
          },
          child: Padding(
            padding: K.fixedPadding1,
            child: Text(
              Strings.skip.tr,
              style: K.primaryMediumTextStyle,
            ),
          )),]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: MediaQuery.of(context).size.height/1.5,
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.tabs.length,
                physics: const NeverScrollableScrollPhysics(),
                pageSnapping: false,
                itemBuilder: (BuildContext context, int index) {
                  return PageViewBody(
                    image:  controller.tabs[controller.currentIndex.value].image,
                    title:   controller.tabs[controller.currentIndex.value].title
                        .toString(),
                    subTitle: controller.tabs[controller.currentIndex.value].subtitle
                        .toString(),

                  );
                },
                onPageChanged: controller.onPageChanged,
              ),
            ),
            Obx(
              () => pieChartWidget(
                onTap: controller.onTap,
                next: controller.prev.value,
                previous: controller.next.value,
                isLast: controller.currentIndex.value==2?true:false,
                text: Strings.go.tr
              ),
            ),
          ],
        ),
      ),
    );
  }
}
