import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/text_style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import 'dart:async';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_expendable_bottom_sheet.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/ride_expendable_bottom_sheet.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class ChooseFromMapScreen extends StatelessWidget {
  const ChooseFromMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CustomBody(
            appBar: CustomAppBar(title: Strings.seTDestination.tr),
            body: GetBuilder<MapController>(builder: (userMapController) {
              Completer<GoogleMapController> mapCompleter =
                  Completer<GoogleMapController>();
              if (userMapController.mapController != null) {
                mapCompleter.complete(userMapController.mapController);
              }
              return Stack(
                children: [
                  Animarker(
                    curve: Curves.easeIn,
                    rippleRadius: 0.2,
                    useRotation: true,
                    duration: const Duration(milliseconds: 2300),
                    mapId:
                        mapCompleter.future.then<int>((value) => value.mapId),
                    //markers: {},
                    shouldAnimateCamera: false,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusOverLarge),
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        compassEnabled: true,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: userMapController.initialPosition,
                            zoom: 16),
                        onMapCreated: (gController) {
                          userMapController.setMapController(gController);
                        },
                        polylines: Set<Polyline>.of(
                            userMapController.polyLines.values),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      bottom: 200,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 120,
                          child: Image.asset(Images.mapLocationIcon),
                        ),
                      ))
                ],
              );
            }),
          ),
          Positioned(
              bottom: 0,
              right: 5,
              left: 5,
              child: Container(
                padding: K.fixedPadding0,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(22))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    K.sizedBoxH0,
                    // Add your desired content here
                      Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // K.sizedBoxW0,
                        Text(Strings.selectDestination.tr,
                          style: textMedium,
                        ),
                        // K.sizedBoxW0,
                      ],
                    ),
                    K.sizedBoxH0,
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [

                       SizedBox(
                           width: MediaQuery.of(context).size.width/1.5,
                           child: Text('In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the' ,style: textMedium,textAlign: TextAlign.left,)),
                        K.sizedBoxW0,


                        Container(
                          width: 40,
                          height: 20,
                          // margin: K.fixedPadding0,
                          decoration:   BoxDecoration(
                            color: Theme.of(Get.context!).hintColor.withOpacity(.4),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            // width: 35,
                              margin: EdgeInsets.all(4),
                              decoration:   BoxDecoration(
                                color: Theme.of(Get.context!).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(' ')),
                        ),
                      ],
                    ),
Spacer(),
                    CustomButton(
                      buttonText:Strings.seTDestination.tr,
                      radius: 25,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
