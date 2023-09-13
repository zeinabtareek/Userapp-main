import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../util/images.dart';
import '../../../widgets/permission_dialog.dart';
import '../../home/widgets/home_map_view.dart';
import '../../where_to_go/where_to_go_screen.dart';


class MapController extends GetxController implements GetxService {

  
  String fromPage = 'parcel';
  
  final double _persistentContentHeight = 550;
  double get persistentContentHeight => _persistentContentHeight;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _checkIsRideAccept = false;
  bool get checkIsRideAccept => _checkIsRideAccept;

  double infoContainerHeight = 200;

  bool clickedAssistant = false;

  @override
  void onInit()async {
  
    super.onInit();
      await determinePosition();
  }
  void toggleAssistant(){
    clickedAssistant = !clickedAssistant;
    update();
  }

  StreamSubscription<ServiceStatus> serviceStatusStream = Geolocator.getServiceStatusStream().listen(
          (ServiceStatus status) async {
        try{

          print(status);
          LocationPermission permission;

          bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
          if (!serviceEnabled) {
            await Geolocator.openAppSettings();
            // await Geolocator.openLocationSettings();
            // await openLocationSettings();
            Get.back();
            Get.defaultDialog(content:  Text('Location services are disabled. Please enable the services.....',style: TextStyle(fontSize: 16),));
            Get.back();
            return ;
          }
          permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              Get.back();
              Get.defaultDialog(content: Text('Location permissions are denied',style: TextStyle(fontSize: 16),));
              return  ;
            }
          }
          if (permission == LocationPermission.deniedForever) {
            Get.back();

            Get.defaultDialog(content: Text('Location permissions are permanently denied, we cannot request permissions **.',style: TextStyle(fontSize: 16),));
            Get.off(SetDestinationScreen( ));
            // Get.off(AddItemScreen(address: '', apartmentNumber: '', landMark: '', lat: '', lng: '', areaNumber: ''));
            return  ;
          }
          if (permission == LocationPermission.always || permission == LocationPermission.whileInUse)  {
            // markers.clear();
            // markers=[];

            return  await Geolocator.getCurrentPosition(  desiredAccuracy: LocationAccuracy.high)
                .then((currLocation) async{

              // initialPosition = LatLng(currLocation.latitude, currLocation.longitude);
              // currentLocation=LatLng(currLocation.latitude, currLocation.longitude);
              // await getUserLocation(LatLng(currLocation.latitude, currLocation.longitude));


              // await   showPinsOnMap(LatLng(currLocation.latitude, currLocation.longitude));
              print(currLocation.longitude);

              Get.to(SetDestinationScreen());
            });
          }
        }     on TimeoutException {
          Get.defaultDialog(content: Text('Location request timed out.',style: TextStyle(fontSize: 12),));


        } on PermissionDeniedException {
          Get.defaultDialog(content: Text('Location permissions are denied.',style: TextStyle(fontSize: 12),));


        } on LocationServiceDisabledException {
          Get.defaultDialog(content: Text('Location services are disabled.',style: TextStyle(fontSize: 12),));

        } on PermissionRequestInProgressException {
          Get.defaultDialog(content: Text('Location Permission Request InProgress Exception  .',style: TextStyle(fontSize: 12),));

        }
      }

  );
  bool isExpanded = false;
  void toggleExpanded(){
    isExpanded = !isExpanded;
    if(isExpanded){
      infoContainerHeight = 500;
    }
    update();
  }
  

  bool activatedPack = false;
  void toggleActivatedPack(){
    activatedPack = !activatedPack;
    update();
  }

  void notifyMapController(){
    update();
  }


  int _stayOnlineTypeIndex = 0;
  int get stayOnlineTypeIndex => _stayOnlineTypeIndex;
  void setStayOnlineTypeIndex(int index){
    _stayOnlineTypeIndex = index;
    update();
  }


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }




  final List<LatLng> _latLngList = [const LatLng(23.8376661, 90.3701626),];
  List<LatLng> toTatLngList = [const LatLng(23.8376661, 90.3701626),];

  List<LatLng> get latLngList => _latLngList;
  final double _distance = 0;
  double get distance => _distance;

  late Position _position;
  Position get position => _position;

  LatLng _initialPosition = const LatLng(23.83721, 90.363715);
  LatLng get initialPosition => _initialPosition;

  final LatLng _customerPosition = const LatLng(12,12);//Get.find<AuthController>().currentLocation;
  late LatLng _destinationPosition;
  LatLng get customerInitialPosition => _customerPosition;
  LatLng get destinationPosition => _destinationPosition;

  var markers = <MarkerId, Marker>{};
   GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;
  Map<PolylineId, Polyline> polyLines = {

  };
  List<LatLng> polylineCoordinates = [];
  LatLng carLocation = const LatLng(23.835856, 90.363715);
  final int _reload = 0;
  int get reload => _reload;
  MarkerId myMarkerId = const MarkerId('myMarker');
  MarkerId customerMarkerId = const MarkerId('customerMarker');


  void initializeData() {
    getCurrentLocation();
    markers = {};
    polyLines = {};
    _isLoading = false;
  }


  void acceptedRideRequest(){
    _checkIsRideAccept = !_checkIsRideAccept;
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  
  Future<Position> getCurrentLocation({bool isAnimate = true}) async {
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _position = newLocalData;
      _initialPosition = LatLng(_position.latitude, _position.longitude);
      if(isAnimate) {
        _mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _initialPosition, zoom: 16)));
      }
    }catch(e){
      if (kDebugMode) {
        print('');
      }
    }

    return _position;
  }
  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => const PermissionDialog());
      Get.back();

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

    _position = await Geolocator.getCurrentPosition();
    print(position.latitude);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude ?? 0.0, position.longitude ?? 0.0),
        zoom: 17)));
    var marker = RippleMarker(
        markerId: kMarkerId,
        position: LatLng(position.latitude ?? 0.0, position.longitude ?? 0.0),
        ripple: false,
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(Images.carIcon, 100)),
        onTap: () {});
    // setState(() {
    markers[kMarkerId] = marker;
    // });
    update();
    return position;
  }
}