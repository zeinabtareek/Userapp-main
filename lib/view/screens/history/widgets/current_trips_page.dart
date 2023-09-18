


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../enum/view_state.dart';
import '../../../../util/app_strings.dart';
import '../controller/activity_controller.dart';
import 'activity_item_view.dart';

class CurrentTripsPage extends StatelessWidget {
  const CurrentTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activityController=Get.put(ActivityController());
    return      Flexible(
      child:
      Obx(() {
        if (activityController.state == ViewState.busy) {
          return const Center(child: CupertinoActivityIndicator(),);
        } else if (activityController.model.data == null ||
            activityController.model.data!.isEmpty||
            activityController.model.data==[]) {
          return   Center(child: Text(Strings.noHistory.tr));
        } else {
          return
            ListView.builder(
              itemBuilder: (context, index) {
                return ActivityItemView(
                  activityItemModel: activityController.model.data![index],
                  isDetailsScreen: false,
                );
              },
              itemCount: activityController.model.data!.length,
              padding: EdgeInsets.zero,
            );
        }
      }),
    );
  }
}