import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'controller.dart';

class TestPolylineMap extends StatelessWidget {
  const TestPolylineMap({super.key});

  @override
  Widget build(BuildContext context) {
    final mapScreenController=Get.put(TestPolylineController());
    return SafeArea(
      child: Scaffold(
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(mapScreenController.originLatitude, mapScreenController.originLongitude), zoom: 15),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: mapScreenController.onMapCreated,
            markers: Set<Marker>.of(mapScreenController.markers),
            polylines: Set<Polyline>.of(mapScreenController.polyline),

          )),
    );
  }

}
