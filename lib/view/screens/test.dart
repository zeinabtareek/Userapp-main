//
//
//
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/directions.dart' as wb;
// // import 'package:google_maps_webservice/directions.dart';
// import 'package:location/location.dart';
//
// class HomeScreen1 extends StatefulWidget {
//   @override
//   _HomeScreen1State createState() => _HomeScreen1State();
// }
//
// class _HomeScreen1State extends State<HomeScreen1> {
//   final Completer<GoogleMapController> _controller = Completer();
//   final MarkerId _markerId = MarkerId('currentLocation');
//   final LatLng _defaultLocation = LatLng(30.7046, 77.1025);
//   LatLng _currentLocation = LatLng(30.7046, 77.1025);
//   LatLng ? _destinationLocation;
//   double _time = 0;
//   double _distance = 0;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getLiveLocation();
//   }
//
//   Future<void> getLiveLocation() async {
//     Location location = Location();
//     bool locPermissionDenied =true;
//     // bool locPermissionDenied = await location.hasPermission();
//     if (locPermissionDenied) {
//       LocationData currentLocation = await location.getLocation();
//       animateCamera(currentLocation.latitude!, currentLocation.longitude!);
//       setState(() {
//         _currentLocation = LatLng(
//           currentLocation.latitude!,
//           currentLocation.longitude!,
//         );
//       });
//     }
//   }
//
//   void animateCamera(double latitude, double longitude) async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(latitude, longitude),
//           zoom: 14.0,
//         ),
//       ),
//     );
//   }
//
//   void onCenter() {
//     animateCamera(_currentLocation.latitude, _currentLocation.longitude);
//   }
//
//   void fetchValue(LatLng data) {
//     setState(() {
//       _destinationLocation = data;
//     });
//   }
//
//   void fetchTimeAndDistance(wb.DirectionsResponse response) {
//     if (response.isOkay) {
//       final route = response.routes[0];
//       wb.Leg leg = route.legs[0];
//
//       setState(() {
//         _time = leg.duration.value.toDouble();
//         _distance = leg.distance.value.toDouble();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//           children: [
//             GoogleMap(
//               mapType: MapType.normal,
//               initialCameraPosition: CameraPosition(
//                 target: _defaultLocation,
//                 zoom: 14.0,
//               ),
//               markers: Set<Marker>.of([
//                 Marker(
//                   markerId: _markerId,
//                   position: _currentLocation,
//                   icon: BitmapDescriptor.defaultMarker,
//                 ),
//                 if (_destinationLocation != null)
//                   Marker(
//                     markerId: MarkerId('destinationLocation'),
//                     position: _destinationLocation!,
//                     icon: BitmapDescriptor.defaultMarkerWithHue(
//                       BitmapDescriptor.hueGreen,
//                     ),
//                   ),
//               ]),
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//               polylines: {
//                 if (_destinationLocation != null)
//                     Polyline(
//                     polylineId: PolylineId('route'),
//                     color: Colors.red,
//                     width: 6,
//                     points: [
//                       _currentLocation,
//                       _destinationLocation!,
//                     ],
//                   ),
//               },
//               onCameraMove: (CameraPosition position) {
//                 _currentLocation = position.target;
//               },
//             ),
//             if (_distance != 0 && _time != 0)
//               Positioned(
//                 bottom: 16.0,
//                 left: 16.0,
//                 right: 16.0,
//                 child: Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         Text('Time left: ${_time.toInt()}'),
//                         Text('Distance left: ${_distance.toInt()}'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             Positioned(
//               bottom: 16.0,
//               right: 16.0,
//               child: FloatingActionButton(
//                 onPressed: onCenter,
//                 child: Icon(Icons.my_location),
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//         onPressed: () {
//       // Navigator.push
//       }));}}