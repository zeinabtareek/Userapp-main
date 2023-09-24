import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/controller/base_controller.dart';

import '../../../../enum/view_state.dart';
import '../../../../util/app_strings.dart';
import '../controller/activity_controller.dart';
import 'activity_item_view.dart';

class CurrentTripsPage extends GetView<ActivityController> {
  const CurrentTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
 
    return Flexible(
      child: BaseStateWidget<ActivityController>(
        successWidget: ListView.builder(
          itemBuilder: (context, index) {
            var item = controller.model.data![index];
    
            return ActivityItemView(
              activityItemModel: item,
              isDetailsScreen: false,
            );
          },
          itemCount: controller.model.data!.length,
          padding: EdgeInsets.zero,
        ),
        emptyWord: Strings.noHistory.tr,
      ),
  //  child:   Obx(() {
  //       if (controller.state == ViewState.busy) {
  //         return const Center(child: CupertinoActivityIndicator(),);
  //       } else if (controller.model.data == null ||
  //           controller.model.data!.isEmpty||
  //           controller.model.data==[]) {
  //         return   Center(child: Text(Strings.noHistory.tr));
  //       } else {
  //         return
  //     ListView.builder(
  //       itemBuilder: (context, index) {
  //         return ActivityItemView(
  //           activityItemModel: controller.model.data![index],
  //           isDetailsScreen: false,
  //         );
  //       },
  //       itemCount: controller.model.data!.length,
  //       padding: EdgeInsets.zero,
  //     );
  //       }
  //     }),
    );
  }
}
