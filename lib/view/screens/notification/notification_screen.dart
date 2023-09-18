import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/notification/controller/notification_controller.dart';
import 'package:ride_sharing_user_app/view/screens/notification/widgets/activity_notification_tap.dart';
import 'package:ride_sharing_user_app/view/screens/notification/widgets/notification_list_tile.dart';
import 'package:ride_sharing_user_app/view/screens/notification/widgets/notification_shimmer.dart';
import 'package:ride_sharing_user_app/view/screens/notification/widgets/offer_notification_page.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../widgets/custom_tap_bar.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key) {
    Get.find<NotificationController>().getNotificationList();
  }

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
            builder: (notificationController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomTapBar(
                  tabController: notificationController.tabController,
                  firstTap: Strings.activity.tr,
                  secondTap: Strings.offer.tr,
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
                  controller: notificationController.tabController,
                  children: const [
                    ActivityNotificationPage(),
                    OfferNotificationPage(),
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
