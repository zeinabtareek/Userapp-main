import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/view/screens/history/controller/activity_controller.dart';

class ActivityScreenMapView extends StatelessWidget {
  LatLng position;
    ActivityScreenMapView({Key? key ,required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityController>(builder: (activityController){
      Completer<GoogleMapController> mapCompleter = Completer<GoogleMapController>();

      if(activityController.mapController != null) {
        mapCompleter.complete(activityController.mapController);
      }
      return Animarker(
        curve: Curves.easeIn,
        rippleRadius: 0.2,
        useRotation: true,
        duration: const Duration(milliseconds: 2300),
        mapId: mapCompleter.future.then<int>((value) => value.mapId),
        // markers: {},
        shouldAnimateCamera: false,
        child:  Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GoogleMap(
              compassEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(target: position, zoom: 16),
              // initialCameraPosition: CameraPosition(target: activityController.initialPosition, zoom: 16),
              onMapCreated: (gController) {
                activityController.setMapController(gController);

              },
              polylines: Set<Polyline>.of(activityController.polyLines.values),
            ),
          ),
        ),
      );
    });
  }
}
