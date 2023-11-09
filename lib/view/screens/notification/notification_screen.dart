import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/text_style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_tap_bar.dart';
import 'controller/notification_controller.dart';
import 'pagnaintion/model/get_notification_req_model.dart';
import 'widgets/activity_notification_tap.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      appBar: CustomAppBar(
        title: Strings.youHaveLotsOfNotification.tr,
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: GetBuilder<NotificationController>(
         init: NotificationController(), 
          builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomTapBar(
                  tabController: controller.tabController,
                  firstTap: Strings.activity.tr,
                  secondTap: Strings.offer.tr,
                  onTabChanged: controller.viewIndex,
                ),
              ),
              // ),
              K.sizedBoxH0,
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraSmall),
                child: Text(
                  Strings.yourNotification.tr,
                  style: textBold.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeExtraLarge),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Obx(
                      () => controller.isShowActivity.isTrue
                          ?  ActivityNotificationPage(type: NotificationType.activity,)
                          : const SizedBox(),
                    ),
                    Obx(() => controller.isShowOffer.isTrue
                        ? const ActivityNotificationPage(
                            type: NotificationType.offer,
                          )
                        : const SizedBox()),
                  ],
                ),
              ),

              Container(height: 70),
            ],
          );
        }),
      ),
    );
  }
}
