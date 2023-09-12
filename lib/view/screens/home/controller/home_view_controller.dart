import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import '../../../../helper/location_permission.dart';
import '../../../../util/images.dart';
import '../widgets/home_map_view.dart';

class HomeViewController extends GetxController{

  Position? position;
  GoogleMapController? mapController;
  final markers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();


  onInit()async{
    super.onInit();

    // await checkPermissionBeforeNavigate(Get.context!);
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


// convertLocation() async {
//   GeoData data = await Geocoder2.getDataFromCoordinates(
//       latitude: pickedPosition.value.latitude,
//       longitude: pickedPosition.value.longitude,
//       googleMapApiKey: AppConstants.mapKey);
//   print(data.address);
//   addressEditingController.text = data.address;
//   _address.value.value = addressEditingController.text;
// }
}