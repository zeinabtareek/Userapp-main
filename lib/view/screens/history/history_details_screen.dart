import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/history/controller/activity_controller.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/activity_details_map_view.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/activity_item_view.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/rider_details.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/trip_details.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final ActivityItemModel activityItemModel;
  // final HistoryModel activityItemModel;
  const HistoryDetailsScreen({Key? key, required this.activityItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: Strings.checkYourAllTrip.tr,showBackButton: true,),
        body: Padding(
          padding: K.fixedPadding0,
          child: GetBuilder<ActivityController>(builder: (activityController){
            return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              Text(Strings.yourTripDetails.tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                  color: Theme.of(context).textTheme.bodyLarge?.color)),
              Divider(color: Theme.of(context).primaryColor.withOpacity(0.2),),

              ActivityItemView(activityItemModel: activityItemModel,isDetailsScreen: true,),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              const ActivityScreenMapView(),
              if(activityItemModel.tripDetails!=null)
              ActivityScreenTripDetails(tripDetails: activityItemModel.tripDetails!),
              if(activityItemModel.tripDetails!=null)
              ActivityScreenRiderDetails(riderDetails: activityItemModel.riderDetails!),
            ],
            );
          }),
        ),
      ),
    );
  }
}