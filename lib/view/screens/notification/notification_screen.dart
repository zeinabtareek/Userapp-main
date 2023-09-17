import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/notification/controller/notification_controller.dart';
import 'package:ride_sharing_user_app/view/screens/notification/widgets/notification_list_tile.dart';
import 'package:ride_sharing_user_app/view/screens/notification/widgets/notification_shimmer.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

import '../../../util/app_strings.dart';

class NotificationScreen extends StatelessWidget {
    NotificationScreen({Key? key}) : super(key: key){
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
// TODO:  unHash Expanded widget
            Expanded(
              child: GetBuilder<NotificationController>(
                  builder: (notificationController) {
                    return notificationController.notificationList != null ?
                    ListView.builder(
                      itemCount: notificationController.notificationList?.length,
                      itemBuilder: (context, item) => Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.07),
                          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault,
                          vertical: Dimensions.paddingSizeLarge,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: NotificationListTile(
                          title:
                          notificationController.notificationList?[item].data.title ?? '',
                          desc: notificationController.notificationList?[item].data.description??'', timer: '30 min ago', image: '',
                        )
                      ),
                    ) : const NotificationShimmer();
                  }
              ),
            ),

            Container(height: 70),
          ],
        ),
      ),
    );
  }
}
