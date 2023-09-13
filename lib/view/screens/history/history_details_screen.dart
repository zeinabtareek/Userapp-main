import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/history/controller/activity_controller.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/activity_details_map_view.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/activity_item_view.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/rider_details.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/trip_details.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import '../../../enum/view_state.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../widgets/custom_image.dart';
import 'model/history_model.dart';

// class HistoryDetailsScreen extends StatelessWidget {
//   final HistoryData activityItemModel;
//   Completer<GoogleMapController> mapCompleter = Completer<GoogleMapController>();
//
//     HistoryDetailsScreen({Key? key, required this.activityItemModel})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomBody(
//         appBar: CustomAppBar(
//           title: Strings.checkYourAllTrip.tr,
//           showBackButton: true,
//         ),
//         body: Padding(
//           padding: K.fixedPadding0,
//           child: GetBuilder<ActivityController>(
//             init: ActivityController(),
//               builder: (activityController) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(Strings.yourTripDetails.tr,
//                     style: textSemiBold.copyWith(
//                         fontSize: Dimensions.fontSizeExtraLarge,
//                         color: Theme.of(context).textTheme.bodyLarge?.color)),
//                 Divider(
//                   color: Theme.of(context).primaryColor.withOpacity(0.2),
//                 ),
//
//                 Obx(
//                   () => activityController.state == ViewState.busy
//                       ? const Center(
//                           child: CupertinoActivityIndicator(),
//                         )
//                       : ActivityItemView(
//                           activityItemModel: activityItemModel,
//                           isDetailsScreen: true,
//                         ),
//                 ),
//                 const SizedBox(
//                   height: Dimensions.paddingSizeSmall,
//                 ),
//                 ActivityScreenMapView(
//                   position: LatLng(
//                     activityItemModel.to?.lat ?? 0.0,
//                     activityItemModel.to?.lng ?? 0.0,
//                   ),
//                 ),
//                  GestureDetector(
//                         child: Text('go to place '),
//                         onTap: ()async{
//                           await activityController. goToPlace( mapCompleter, lat : 0.0, lng: 0.0 );}
//
//                 ),
//
//
//
//
//                 // if(activityItemModel.tripDetails!=null)
//                 ActivityScreenTripDetails(tripDetails: activityItemModel),
//                 // if(activityItemModel.tripDetails!=null)
//                 ///uncomment this
//                 // ActivityScreenRiderDetails(riderDetails: activityItemModel ),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
class HistoryDetailsScreen extends StatelessWidget {
  final HistoryData activityItemModel;
  final ActivityController activityController = ActivityController();
  Completer<GoogleMapController> mapCompleter=Completer<GoogleMapController>();

  HistoryDetailsScreen({Key? key, required this.activityItemModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
          title: Strings.checkYourAllTrip.tr,
          showBackButton: true,
        ),
        body: Padding(
          padding: K.fixedPadding0,
          child: GetBuilder<ActivityController>(
            init: activityController,
            builder: (activityController) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.yourTripDetails.tr,
                      style: textSemiBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraLarge,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                    Obx(() => activityController.state == ViewState.busy
                          ? const Center(
                        child: CupertinoActivityIndicator(), )
                          : ActivityItemView(
                        activityItemModel: activityItemModel,
                        isDetailsScreen: true,
                      ),
                    ),K.sizedBoxH0,
                    ActivityScreenMapView(
                      sourcePosition: LatLng(
                        activityItemModel.from?.lat ?? 0.0,
                        activityItemModel.from?.lng ?? 0.0,
                      ), destinationPosition: LatLng(
                        activityItemModel.to?.lat ?? 0.0,
                        activityItemModel.to?.lng ?? 0.0,
                      ),
                      activityController: activityController,
                      mapCompleter: mapCompleter,
                    ),
                    if(activityItemModel.tip!=null)
                    ActivityScreenTripDetails(tripDetails: activityItemModel,  mapCompleter: mapCompleter,),
                    if(activityItemModel.driver!=null)
                    ActivityScreenRiderDetails(riderDetails: activityItemModel.driver!),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
