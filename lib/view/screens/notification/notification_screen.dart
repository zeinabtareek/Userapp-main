import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/notification/controller/notification_controller.dart';
import 'package:ride_sharing_user_app/view/screens/notification/widgets/notification_shimmer.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    Get.find<NotificationController>().getNotificationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      appBar:  CustomAppBar(title: 'you_have_lots_of_notification'.tr,showBackButton: false,),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              child: Text(
                'your_notification'.tr,
                style: textBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeExtraLarge),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault,),

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  const CustomImage(
                                    image: '',
                                    radius: Dimensions.radiusDefault,
                                    height: 35, width: 35,
                                    placeholder: Images.carPlaceholder,
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeSmall,),

                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notificationController.notificationList?[item].data.title ?? '',
                                        style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                                      ),

                                      Text(notificationController.notificationList?[item].data.description ?? ''),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                              child: Row(
                                children: [
                                 const Text('30 min ago',
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                                  Icon(
                                    Icons.alarm,
                                    size: Dimensions.fontSizeLarge,
                                    color: Theme.of(context).hintColor.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
