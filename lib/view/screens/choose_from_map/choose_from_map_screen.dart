import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../util/app_strings.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import 'controller/choose_from_map_controller.dart';
import 'widgets/search_bottom_sheet.dart';

class ChooseFromMapScreen extends StatelessWidget {
  ChooseFromMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: GetBuilder<ChooseFromMapController>(
          init: ChooseFromMapController(),
          builder: (controller) => Stack(
            children: [
              CustomBody(
                appBar: CustomAppBar(title: Strings.seTDestination.tr),
                body: GetBuilder<ChooseFromMapController>(
                    builder: (userMapController) {
                      print(" userMapController.markers lenght ${userMapController.markers.length} ");
                  Completer<GoogleMapController> mapCompleter =
                      Completer<GoogleMapController>();
                  if (userMapController.mapController != null) {
                    mapCompleter.complete(userMapController.mapController);
                    userMapController.mapViewHelperMapCompleter =
                        userMapController.mapController!;
                  }
                  return Stack(
                    children: [
                      // Animarker(
                      //   curve: Curves.easeIn,
                      //   rippleRadius: 0.2,
                      //   useRotation: true,
                      //   duration: const Duration(milliseconds: 2300),
                      //   mapId:
                      //       mapCompleter.future.then<int>((value) => value.mapId),
                      //   //markers: {},
                      //   shouldAnimateCamera: false,
                      //   child: ClipRRect(
                      //     borderRadius:
                      //         BorderRadius.circular(Dimensions.radiusOverLarge),
                      //     child: GoogleMap(
                      //       zoomControlsEnabled: false,
                      //       myLocationButtonEnabled: true,
                      //       myLocationEnabled: true,
                      //       compassEnabled: true,
                      //       mapType: MapType.normal,
                      //       initialCameraPosition: CameraPosition(
                      //           target: userMapController.initialPosition,
                      //           zoom: 16),
                      //       onMapCreated: (gController) {
                      //         userMapController.setMapController(gController);
                      //
                      //       },
                      //       polylines: Set<Polyline>.of(
                      //           userMapController.polyLines.values),
                      //       onCameraMove: (CameraPosition position){
                      //         print(position.target);
                      //
                      //       },
                      //         onCameraIdle: () {
                      //           LatLngBounds bounds = mapController.getVisibleRegion();
                      //           final lon = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
                      //           final lat = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
                      //         }
                      //     ),
                      //   ),
                      // ),

                      Animarker(
                        curve: Curves.easeIn,
                        rippleRadius: 0.2,
                        useRotation: true,
                        duration: const Duration(milliseconds: 2300),
                        mapId: controller.getMapViewHelperMapCompleter?.future.then<int>((value) => value.mapId)??Future.value(3),
                        markers: controller.markers,
                        shouldAnimateCamera: false,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusOverLarge),
                          child: GoogleMap(
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            compassEnabled: true,
                            markers: userMapController.markers,
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: userMapController.initialPosition,
                              zoom: 16,
                            ),
                            onMapCreated: controller.onMapCreated,
                            // (gController) {
                            // userMapController.setMapController(gController);
                            // mapController = gController;
                            // },
                            polylines: controller.polylines,
                            onCameraMove: controller.onCameraMove,
                            onCameraIdle: userMapController.onCameraIdle,
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

              ///normal bottom sheet
              // Positioned(
              //     bottom: 0,
              //     right: 5,
              //     left: 5,
              //     child: Container(
              //       padding: K.fixedPadding0,
              //       height: MediaQuery.of(context).size.height / 3.5,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius:
              //               BorderRadius.only(topLeft: Radius.circular(22))),
              //       child: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: [
              //           K.sizedBoxH0,
              //           // Add your desired content here
              //             Row(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               // K.sizedBoxW0,
              //               Text(Strings.selectDestination.tr,
              //                 style: textMedium,
              //               ),
              //               // K.sizedBoxW0,
              //             ],
              //           ),
              //           K.sizedBoxH0,
              //           // Row(
              //           //   // crossAxisAlignment: CrossAxisAlignment.end,
              //           //   mainAxisAlignment: MainAxisAlignment.end,
              //           //
              //           //   children: [
              //
              //              SizedBox(
              //                  width: MediaQuery.of(context).size.width/1.3,
              //                  child: Text('In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the' ,style: textMedium,textAlign: TextAlign.left,)),
              //               K.sizedBoxW0,
              //
              //
              //               // Container(
              //               //   width: 40,
              //               //   height: 20,
              //               //   // margin: K.fixedPadding0,
              //               //   decoration:   BoxDecoration(
              //               //     color: Theme.of(Get.context!).hintColor.withOpacity(.4),
              //               //     shape: BoxShape.circle,
              //               //   ),
              //               //   child: Container(
              //               //     // width: 35,
              //               //       margin: EdgeInsets.all(4),
              //               //       decoration:   BoxDecoration(
              //               //         color: Theme.of(Get.context!).primaryColor,
              //               //         shape: BoxShape.circle,
              //               //       ),
              //               //       child: Text(' ')),
              //               // ),
              //             // ],
              //           // ),
              //           Spacer(),
              //           CustomButton(
              //             buttonText:Strings.seTDestination.tr,
              //             radius: 25,
              //             onPressed: () {
              //               Get.back();
              //             },
              //           ),
              //         ],
              //       ),
              //     ))

              const AnimatedPositioned(
                left: 0,
                right: 0,
                bottom: 15,
                duration: Duration(milliseconds: 2000),
                curve: Curves.easeIn,
                child: SearchBottom(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
