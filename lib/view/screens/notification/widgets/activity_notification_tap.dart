import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../helper/date_converter.dart';
import '../../../../pagination/typedef/page_typedef.dart';
import '../../../../pagination/widgets/paginations_widgets.dart';
import '../../../../util/dimensions.dart';
import '../model/notification_res_model.dart';
import '../pagnaintion/model/get_notification_req_model.dart';
import '../pagnaintion/use-case/get_notifications_use_case.dart';
import 'notification_list_tile.dart';

class ActivityNotificationPage extends StatelessWidget {
  final NotificationType type;
  const ActivityNotificationPage({super.key,required this.type,});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaginateNotificationController>(
        init: PaginateNotificationController(
          GetNotificationsUseCase(
              GetNotificationReqModel(1, type:type)),
        ),
        builder: (con) {
          return PaginateNotificationView(
            listPadding: const EdgeInsets.only(top: 0, bottom: 90),
            child: (entity) =>
                NotificationWidget(data: entity,),
            paginatedLst: (list) {
              return SmartRefresherApp(
                key: Key(type.name),
                controller: con,
                list: list,
              );
            },
          );
        });
    return const SizedBox();
    // return GetBuilder<NotificationController>(
    //     builder: (notificationController) {
    //   return notificationController.notificationList != null
    //       ? ListView.builder(
    //           itemCount: notificationController.notificationList?.length,
    //           itemBuilder: (context, item) => NotificationWidget(),
    //         )
    //       : const NotificationShimmer();
    // });
  }
}

class NotificationWidget extends PaginationViewItem<NotificationModel> {
  const NotificationWidget({super.key, required super.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.07),
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeLarge,
        ),
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: NotificationListTile(
          title: data.title??"",
          desc: data.body??"",
          timer: DateConverter.fromNow(data.createdAt),
          image: data.img ?? "",
        ));
  }
}
