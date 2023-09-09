import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';

import 'dart:ui' as ui;

import 'package:ride_sharing_user_app/view/widgets/permission_dialog.dart';

const kStartPosition = LatLng(18.488213, -69.959186);
const kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 15);
const kMarkerId = MarkerId('MarkerId1');
const kMarkerId2 = MarkerId('MarkerId2');
const kDuration = Duration(seconds: 2);
const kLocations = [
  kStartPosition,
  LatLng(23.837689, 90.370076),
];

class HomeMapView extends StatefulWidget {
  const HomeMapView({super.key});

  @override
  HomeMapViewState createState() => HomeMapViewState();
}

class HomeMapViewState extends State<HomeMapView> {
  Position? position;
  GoogleMapController? mapController;
  final markers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();
  final stream = Stream.periodic(kDuration, (count) => kLocations[count])
      .take(kLocations.length);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    _determinePosition();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.3))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          child: Animarker(
            curve: Curves.bounceOut,
            rippleRadius: 0.2,
            useRotation: false,
            duration: const Duration(milliseconds: 2300),
            mapId: controller.future.then<int>((value) => value.mapId),
            //Grab Google Map Id
            markers: markers.values.toSet(),
            child: GoogleMap(
                mapType: MapType.terrain,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: true,

                onTap: (p){
                  print(p);
                },
                onCameraMove: (poistion) {
                  print(poistion);
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        position?.latitude ?? 0.0, position?.longitude ?? 0.0)),
                onMapCreated: (gController) {
                  // stream.forEach((value) => newLocationUpdate(value));
                  controller.complete(gController);
                  _determinePosition();
                  //Complete the future GoogleMapController
                }),
          ),
        ),
      ),
    );
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
    setState(() {
      markers[kMarkerId] = marker;
      markers[kMarkerId2] = marker2;
    });
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => const PermissionDialog());

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) => const PermissionDialog());

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => const PermissionDialog());

      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition();
    print(position?.latitude);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position?.latitude ?? 0.0, position?.longitude ?? 0.0),
        zoom: 17)));
    var marker = RippleMarker(
        markerId: kMarkerId,
        position: LatLng(position?.latitude ?? 0.0, position?.longitude ?? 0.0),
        ripple: false,
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(Images.carIcon, 100)),
        onTap: () {});
    setState(() {
      markers[kMarkerId] = marker;
    });
    return position;
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
