import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../controller/base_map_controller.dart';

class CommonMapWidget extends StatelessWidget {
  Future<int> mapId;
  CameraPosition initialCameraPosition;
  Function(GoogleMapController)? onMapCreated;
  Set<Marker> markers;
  Set<Polyline> polylines;

  CommonMapWidget({
    super.key,
    required this.mapId,
    required this.onMapCreated,
    required this.initialCameraPosition,
    this.markers = const <Marker>{},
    this.polylines = const <Polyline>{},
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 2 - 40.h,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Animarker(
        curve: Curves.easeIn,
        rippleRadius: 0.2,
        useRotation: true,
        duration: const Duration(milliseconds: 2300),
        mapId: mapId,
        shouldAnimateCamera: false,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
          child: GoogleMap(
            zoomControlsEnabled: true,
            myLocationButtonEnabled: true,
            // myLocationEnabled: true,
            compassEnabled: true,
            mapType: MapType.terrain,
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            polylines: polylines,
            onMapCreated: onMapCreated,
          ),
        ),
      ),
    );
  }
}
