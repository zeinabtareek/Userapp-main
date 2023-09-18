import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../util/dimensions.dart';
import '../controller/notification_controller.dart';
import 'notification_list_tile.dart';
import 'notification_shimmer.dart';

class ActivityNotificationPage extends StatelessWidget {
  const ActivityNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return     GetBuilder<NotificationController>(
        builder: (notificationController) {
          return notificationController.notificationList != null ?
          ListView.builder(
            itemCount: notificationController.notificationList?.length,
            itemBuilder: (context, item) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.07),
                  borderRadius:  const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
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
    );
  }
}