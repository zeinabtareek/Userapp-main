import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../enum/view_state.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../where_to_go/widget/search_list_widget.dart';
import 'controller/choose_from_map_controller.dart';
import 'widgets/search_bottom_sheet.dart';

class ChooseFromMapScreen extends StatelessWidget {
  final List<LatLng>? points;
  const ChooseFromMapScreen(
    this.points, {
    super.key,
  });

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
        //  backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: GetBuilder<ChooseFromMapController>(
          init: ChooseFromMapController(),
          builder: (controller) {
            if (points != null) {
              controller.pickedPoints = points!;
            }

            return WillPopScope(
              onWillPop: () {
                controller.searchResultsFrom.clear();

                return Future.value(true);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomBody(
                    appBar: CustomAppBar(title: Strings.seTDestination.tr),
                    body: GetBuilder<ChooseFromMapController>(
                        builder: (userMapController) {
                      // Completer<GoogleMapController> mapCompleter =
                      //     Completer<GoogleMapController>();
                      // if (userMapController.mapController != null) {
                      //   mapCompleter.complete(userMapController.mapController);
                      //   userMapController.mapViewHelperMapCompleter =
                      //       userMapController.mapController!;
                      // }
                      return Stack(
                        children: [
                          Animarker(
                            curve: Curves.easeIn,
                            rippleRadius: 0.2,
                            useRotation: true,
                            duration: const Duration(milliseconds: 2300),
                            mapId: Future.value(3),
                            markers: controller.markers,
                            shouldAnimateCamera: false,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusOverLarge),
                              child: FutureBuilder(
                                future: Future.delayed(
                                    const Duration(milliseconds: 250),
                                    () => true),
                                builder: (context, snap) {
                                  if (!snap.hasData) {
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  }
                                  return GoogleMap(
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
                                    onCameraMoveStarted: () {},
                                    onCameraMove: controller.onCameraMove,
                                    onCameraIdle:
                                        userMapController.onCameraIdle,
                                  );
                                },
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
                              )),
                          AnimatedPositioned(
                            left: 0,
                            right: 0,
                            bottom: 15,
                            duration: const Duration(milliseconds: 2000),
                            curve: Curves.easeIn,
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: const SearchBottom(),
                            ),
                          ),
                          Obx(
                            () => userMapController.searchResultsFrom.isNotEmpty
                                ? userMapController.state == ViewState.busy
                                    ? const Center(
                                        child: CupertinoActivityIndicator(),
                                      )
                                    : Positioned(
                                        left: 15,
                                        right: 15,
                                        bottom:
                                            MediaQuery.of(context).size.height /
                                                3.5.h,
                                        top: 0,
                                        child: SearchListWidget(
                                          listOfSearchedPlaces:
                                              userMapController
                                                  .searchResultsFrom,
                                          onTap: (item) {
                                            userMapController
                                                .getLocationOfSelectedSearchItem(
                                                    item);
                                            // userMapController
                                          },
                                          inputTextField: userMapController
                                              .searchController,
                                        ),
                                      )
                                : const SizedBox(),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
        // bottomSheet:   SearchBottom(),
      ),
    );
  }
}
