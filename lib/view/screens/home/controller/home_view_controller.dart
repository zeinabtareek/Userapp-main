import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'dart:ui' as ui;
import '../../../../helper/location_permission.dart';
import '../../../../mxins/map/map_view_helper.dart';
import '../../../../util/images.dart';
import '../../../widgets/permission_dialog.dart';
import '../widgets/home_map_view.dart';

class HomeViewController extends BaseController {
  GoogleMapController? mapController;
  final markers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();
  Position? _position;

  Position? get position => _position;
  final googleMapController = Completer<GoogleMapController>();
  final stream = Stream.periodic(kDuration, (count) => kLocations[count])
      .take(kLocations.length);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  onInit() async {
    super.onInit();

    // _position = await MapHelper.getCurrentPosition();

  }


getPermission()async{
  _position = await MapHelper.getCurrentPosition().then((value) async {
    if (value is Position) {
      myAddressString = await getPlaceNameFromLatLng(
          LatLng(value.latitude, value.longitude));
      update();
    }
  });
}

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void newLocationUpdate(LatLng latLng) async {
    var marker = RippleMarker(
        markerId: kMarkerId,
        position: latLng,
        ripple: false,
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(Images.carIcon, 100)),
        onTap: () {});
    var marker2 = RippleMarker(
        markerId: kMarkerId2,
        position: const LatLng(23.836982, 90.374282),
        ripple: false,
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(Images.carIcon, 100)),
        onTap: () {});
    // setState(() {
    markers[kMarkerId] = marker;
    markers[kMarkerId2] = marker2;
    // });

    update();
  }

  // Future<Position?> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     showDialog(
  //         context: Get.context!,
  //         barrierDismissible: false,
  //         builder: (context) => const PermissionDialog());
  //     Get.back();
  //
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       showDialog(
  //           context: Get.context!,
  //           barrierDismissible: false,
  //           builder: (context) => const PermissionDialog());
  //
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     showDialog(
  //         context: Get.context!,
  //         barrierDismissible: false,
  //         builder: (context) => const PermissionDialog());
  //
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   _position = await Geolocator.getCurrentPosition();
  //   print(position?.latitude);
  //   mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(position?.latitude ?? 0.0, position?.longitude ?? 0.0),
  //       zoom: 17)));
  //   var marker = RippleMarker(
  //       markerId: kMarkerId,
  //       position: LatLng(position?.latitude ?? 0.0, position?.longitude ?? 0.0),
  //       ripple: false,
  //       icon: BitmapDescriptor.fromBytes(
  //           await getBytesFromAsset(Images.carIcon, 100)),
  //       onTap: () {});
  //   // setState(() {
  //   markers[kMarkerId] = marker;
  //   // });
  //   update();
  //   return position;
  // }

}
