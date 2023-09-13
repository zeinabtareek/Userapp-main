import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../util/app_constants.dart';

class TestPolylineController extends GetxController{
 // Set markers = {};
 //  Map<MarkerId, Marker> markers = {};
  Set<Marker> markers =Set<Marker>();

   late PolylinePoints polylinePoints;
  final polyline = <Polyline>{}.obs;
  final polylineCoordinates = <LatLng>[].obs;
 // polylines: Set<Polyline>.of(controller.polyline)
   double originLatitude = 6.5212402, originLongitude = 3.3679965;
   double destLatitude = 6.849660, destLongitude = 3.648190;
  late GoogleMapController mapController;


  onInit()async{
     // await  setPolylines(LatLng(originLatitude, originLongitude),LatLng(destLatitude, destLongitude));
    // await  showPinsOnMap(LatLng(originLatitude, originLongitude),LatLng(destLatitude, destLongitude));


  }


  Polygon ?polygon;
   Future<void> buildPolygon(List<Offset> shape) async {
    final List<LatLng> points = <LatLng>[];
    final devicePixelRatio = MediaQuery.of(Get.context!).devicePixelRatio;

    await Future.forEach(shape, (Offset offset) async {
      LatLng point = await mapController.getLatLng(
        ScreenCoordinate(
          x: (offset.dx * devicePixelRatio).round(),
          y: (offset.dy * devicePixelRatio).round(),
        ),
      );
      points.add(point);
    });

    final PolygonId polygonId = PolygonId("1");
    polygon = Polygon(
      polygonId: polygonId,
      consumeTapEvents: true,
      strokeColor: Colors.blue,
      strokeWidth: 5,
      fillColor: Colors.orange.withOpacity(0.2),
      points: points,
    );
  }
//LatLng position, String id, BitmapDescriptor descriptor)
//    addMarker( ){
//      MarkerId markerId = MarkerId('id');
//      Marker marker =Marker(markerId: markerId,   position: LatLng(originLatitude, originLongitude));
//     markers[markerId] = marker;
//
//    }

  showPinsOnMap(LatLng point ,LatLng desPoint  ){
    try {
      markers.add(
          Marker(
              markerId: MarkerId('sourcePin'),
              position: point,
              // position: currentLocation!,
              // icon: sourceIcon!,
              infoWindow: InfoWindow(title: 'locality', snippet: "Pick Up Locaation"),
              onTap: () {
                try {
                  update();
                } catch (e) {
                  printError(info: '#####################');
                }
              }
          )
      );

      markers.add(
          Marker(
              markerId: MarkerId('destinationPin',),
              position: desPoint,
              // icon: destinationIcon!,
              onTap: () {
                try {
                  print('first marker');
                  update();
                } catch (e) {
                  printError(info: '#####################');
                }
              }
          ));
      // setPolylines(point,desPoint);
      // calculateDistanceFunc(currentLocation!.latitude,currentLocation!.longitude);
      update();
    }catch(e){
      printError(info: '############no#########');
    }

  }
  onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await  showPinsOnMap(LatLng(originLatitude, originLongitude),LatLng(destLatitude, destLongitude));
    // await setPolylines(LatLng(originLatitude, originLongitude),LatLng(destLatitude, destLongitude));
  }


  Set<Polyline> polyLines=Set<Polyline>();
  final listPolyLineCoordinates =<LatLng>[].obs;
  // List<LatLng> listPolyLineCoordinates=[];

  // setPolylines(LatLng point, LatLng desPoint)async{
  //   PolylineResult result=await polylinePoints.getRouteBetweenCoordinates(
  //     'AIzaSyCzuhU5w3Ah8t2x2pIKXzsGoATsdzVNK9I',
  //     // AppConstants.mapKey,
  //     PointLatLng(
  //       point.latitude,
  //       point.longitude,
  //       //  currentLocation!.latitude,
  //       // currentLocation!.longitude,
  //     ),
  //     PointLatLng(
  //       desPoint.latitude,
  //       desPoint.longitude,
  //       // destinationLocation!.longitude,
  //     ),
  //     travelMode: TravelMode.driving,
  //
  //   );print("my points");
  //   print(result.points);
  //
  //   // calculateDistanceFunc(currentLocation!.latitude,currentLocation!.longitude);
  //   if(result.status =='OK'&& result.points.isNotEmpty){
  //     listPolyLineCoordinates.value = [];
  //     result.points.forEach((PointLatLng point) {
  //       listPolyLineCoordinates.add(
  //           LatLng(
  //             point.latitude,
  //             point.longitude,
  //           ));
  //       polyLines.add(
  //         Polyline(
  //           polylineId: PolylineId('polyline'),
  //           width: 10,
  //           color: const Color(0xFF08A5CB),
  //           points: listPolyLineCoordinates,
  //           startCap: Cap.roundCap,
  //           endCap: Cap.buttCap,
  //         ),
  //       );
  //       update();
  //     });
  //   }else{
  //     printError(info: '((((((((((((((((((((((((');
  //   }
  //     update();
  // }
}