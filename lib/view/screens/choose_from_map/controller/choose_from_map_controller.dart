import 'dart:async';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../controller/base_controller.dart';
import '../../../../util/images.dart';
import '../../../widgets/permission_dialog.dart';
import '../../home/widgets/home_map_view.dart';
import '../../where_to_go/repository/search_service.dart';
import '../../where_to_go/where_to_go_screen.dart';

class ChooseFromMapController extends BaseController {
  final searchController = TextEditingController();
  final searchDesTextEditing = TextEditingController();

  final carouselController = CarouselController();
  SearchServices services = SearchServices();
  var markers = <MarkerId, Marker>{};
  GoogleMapController? _mapController;

  GoogleMapController? get mapController => _mapController;
  Map<PolylineId, Polyline> polyLines = {};
  double distance = 0.0;
  late Position _position;

  Position get position => _position;

  LatLng _initialPosition = const LatLng(23.83721, 90.363715);

  LatLng get initialPosition => _initialPosition;
  final address = ''.obs;
  final isDataLoading = false.obs;
  final RxBool isContainerVisible = false.obs;

  void toggleContainerVisibility() {
    isContainerVisible.value = !isContainerVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
  }


  ///Get Current location
  Future<Position> getCurrentLocation({bool isAnimate = true}) async {
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _position = newLocalData;
      _initialPosition = LatLng(_position.latitude, _position.longitude);
      if (isAnimate) {
        _mapController?.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: _initialPosition, zoom: 16)));
      }
    } catch (e) {
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

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  onCameraIdle() async {//accuracy
    isDataLoading.value=true;
    if (mapController != null) {
      LatLngBounds bounds = await mapController!.getVisibleRegion();
      final lon = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
      final lat = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;

      address.value = await services.getPlaceNameFromLatLng(LatLng(lat, lon));
      print('address is : ${address.value}');

    }
    isDataLoading.value=false;
  }

  ///needs to be refactored
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
  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  onMapCreated(gController){
      setMapController(gController);

  }

  onCameraMove  (CameraPosition position) {
  print(position.target);
  }



}
