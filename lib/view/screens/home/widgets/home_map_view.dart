// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_animarker/core/ripple_marker.dart';
// import 'package:flutter_animarker/widgets/animarker.dart';
// import 'package:geocoder2/geocoder2.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:ride_sharing_user_app/util/dimensions.dart';
// import 'package:ride_sharing_user_app/util/images.dart';
//
// import 'dart:ui' as ui;
//
// import 'package:ride_sharing_user_app/view/widgets/permission_dialog.dart';
//
// import '../controller/home_view_controller.dart';
//
// const kStartPosition = LatLng(18.488213, -69.959186);
// const kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 15);
// const kMarkerId = MarkerId('MarkerId1');
// const kMarkerId2 = MarkerId('MarkerId2');
// const kDuration = Duration(seconds: 2);
// const kLocations = [
//   kStartPosition,
//   LatLng(23.837689, 90.370076),
// ];
//
// class HomeMapView extends StatefulWidget {
//   const HomeMapView({super.key});
//
//   @override
//   HomeMapViewState createState() => HomeMapViewState();
// }
//
// class HomeMapViewState extends State<HomeMapView> {
//   final controller =Get.put(HomeViewController());
//   // Position? position;
//   GoogleMapController? mapController;
//
//   //
//   // @override
//   // initState()   {
//   //   super.initState();
//   //    // _determinePosition();
//   // }
//
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
//       child: Container(
//         height: 180,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
//             border: Border.all(
//                 color: Theme.of(context).primaryColor.withOpacity(0.3))),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
//           child: Animarker(
//             curve: Curves.bounceOut,
//             rippleRadius: 0.2,
//             useRotation: false,
//             duration: const Duration(milliseconds: 2300),
//             mapId:controller. googleMapController.future.then<int>((value) => value.mapId),
//             //Grab Google Map Id
//             markers: controller.markers.values.toSet(),
//             child: GoogleMap(
//                 mapType: MapType.terrain,
//                 myLocationEnabled: true,
//                 zoomControlsEnabled: false,
//                 myLocationButtonEnabled: true,
//
//                 onTap: (p){
//                   print(p);
//                 },
//                 onCameraMove: (poistion) {
//                   print(poistion);
//                 },
//                 initialCameraPosition: CameraPosition(
//                     target: LatLng(
//                         controller. position?.latitude ?? 0.0,controller. position?.longitude ?? 0.0)),
//                 onMapCreated: (gController) async{
//                   await controller .determinePosition();
//
//                   // stream.forEach((value) => newLocationUpdate(value));
//                   controller. googleMapController.complete(gController);
//                   //Complete the future GoogleMapController
//                 }),
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
//
//
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/helper/map-helpers/flutter_polyline_points_helper.dart';
import 'package:ride_sharing_user_app/helper/map-helpers/map_helper.dart';
import 'package:ride_sharing_user_app/helper/map-helpers/map_view_helper.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';

import 'dart:ui' as ui;

import 'package:ride_sharing_user_app/view/widgets/permission_dialog.dart';

var kStartPosition = const LatLng(18.488213, -69.959186);
var kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 15);
const kMarkerId = MarkerId('MarkerId1');
const kMarkerId2 = MarkerId('MarkerId2');
const kDuration = Duration(seconds: 2);
var kLocations = [
  kStartPosition,
  const LatLng(23.837689, 90.370076),
];

const LatLng sorcse = LatLng(30.7865, 31.0004);

const LatLng dist = LatLng(30.7861, 31.0003);

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
  late CameraPosition cameraPosition;
  final stream = Stream.periodic(kDuration, (count) => kLocations[count])
      .take(kLocations.length);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  MapViewHelper? mapViewHelper;

  Set<Marker> markars = {};
  Set<Polyline> polylines = {};

  trackLiveLocation() {
    MapHelper.getPositionWhenMove(
        distanceFilter: 10,
        onChangeLocation: (pos) {
          LatLng target = LatLng(pos.latitude, pos.longitude);
          mapViewHelper?.goToPlace(
            zoom: 18,
            () {
              setState(() {});
            },
            lat: target.latitude,
            lng: target.longitude,
            // disLat: dist.latitude,
            // disLong: dist.longitude,
            isAnimate: true,
          );

          var x = Marker(
              markerId: const MarkerId('crPin'),
              position: target,
              onTap: () {},
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange));
          mapViewHelper?.changeCurrentMarkerPoss(() {
            setState(() {});
          }, newPos: target, currentMarker: x, isLiveUpdateUi: true);

          if (polylinePoints.isNotEmpty) {
            // if (!FlutterPolylinePointsHelper.checkIfPointIsInPolyLine(
            //     target, polylinePoints)) {
            //   getPloy(target, dist);
            // }

            if (!mp.PolygonUtil.isClosedPolygon(polylinePoints)) {
              getPloy(target, dist);
            }
          }
        });
  }

  addPolyLine() {
    Polyline x = Polyline(
        polylineId: const PolylineId("d"),
        color: Colors.teal,
        width: 4,
        // points: polylinePoints,
        visible: true,
        patterns: [PatternItem.dash(5)]);

    mapViewHelper?.addOnePolyline(
      () {
        polylines = mapViewHelper!.polylines;
        setState(() {});
      },
      polyline: x,
      isRequestUpdateUi: true,
    );
    mapViewHelper?.addListPointToExistPolyline(() {
      setState(() {});
    }, points: polylinePoints, isRequestUpdateUiAfterAddedALL: true);
  }

  showPinsOnMap(LatLng sourcePoint, LatLng desPoint) {
    try {
      var m1 = Marker(
          markerId: const MarkerId('sourcePin'),
          position: sourcePoint,
          onTap: () {});
      var m2 = Marker(
          markerId: const MarkerId('destination'),
          position: desPoint,
          onTap: () {});
      mapViewHelper?.addListMarker(() {
        markars = mapViewHelper!.markers;
        setState(() {});
      }, markers: [m1, m2], isRequestUpdateUiAfterAddedALL: true);
    } catch (e) {
      printError(info: '############no#########');
    }
  }

  List<LatLng> polylinePoints = [];
  getPloy(LatLng sorce, LatLng dist) {
    FlutterPolylinePointsHelper.getRouteBetweenCoordinates(AppConstants.mapKey,
            sorce.latitude, sorce.longitude, dist.latitude, dist.longitude)
        .then((value) {
      polylinePoints = value.points.map((e) => e.toLatLng).toList();
      showPinsOnMap(polylinePoints.first, polylinePoints.last);
      addPolyLine();
    });
  }

  @override
  initState() {
    super.initState();
    _determinePosition();
    trackLiveLocation();
    getPloy(sorcse, dist);
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
            markers: markars,
            child: position == null
                ? SpinKitThreeInOut(
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  )
                : GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: true,
                    polylines: polylines,
                    markers: markars,
                    onTap: (p) {
                      print(p);
                    },
                    onCameraMove: (poistion) {
                      print(poistion);
                    },
                    initialCameraPosition: cameraPosition,
                    onMapCreated: (gController) async {
                      // stream.forEach((value) => newLocati //onUpdate(value));
                      controller.complete(gController);
                      mapViewHelper = MapViewHelper(controller);
                      // stream.forEach((value) => _determinePosition());

                      //Complete the future GoogleMapController
                    },
                  ),
          ),
        ),
        // ),
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
    cameraPosition = CameraPosition(
        target: LatLng(position?.latitude ?? 0.0, position?.longitude ?? 0.0),
        zoom: 17);
    mapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    var marker = RippleMarker(
        markerId: kMarkerId,
        position: LatLng(position?.latitude ?? 0.0, position?.longitude ?? 0.0),
        ripple: false,
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(Images.locationFill, 70)),
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
