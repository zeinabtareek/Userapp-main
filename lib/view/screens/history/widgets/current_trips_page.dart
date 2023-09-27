import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/controller/base_controller.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/history_model.dart';

import '../../../../enum/view_state.dart';
import '../../../../util/app_strings.dart';
import '../controller/activity_controller.dart';
import 'activity_item_view.dart';

class CurrentTripsPage extends GetView<ActivityController> {
  List<HistoryData >model;
    CurrentTripsPage({super.key ,required this.model});

  @override
  Widget build(BuildContext context) {
 
    return   ListView.builder(
          itemBuilder: (context, index) {
            // var item = controller.model.data![index];
            //
            return index==model.length ?
            SizedBox(height: 200,):ActivityItemView(
              activityItemModel: model[index],
              isDetailsScreen: false,
            );
          },
          itemCount: model.length+1,
          padding: EdgeInsets.zero,
          shrinkWrap: true,

     );
  }
}
