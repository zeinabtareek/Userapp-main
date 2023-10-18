import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../controller/base_controller.dart';
import '../../../../mxins/map/map_view_helper.dart';
import '../../../../util/images.dart';
import '../../where_to_go/repository/search_service.dart';
import '../../where_to_go/where_to_go_screen.dart';

class ChooseFromMapController extends BaseController with MapViewHelper {
  List<LatLng> pickedPoints = [];
  @override
  void onInit() async {
    await _getCurrantLocation();
    await _drawMarkersIfHavePickedPoints();

    await _moveCameraToMyLocation();
    super.onInit();
  }

  final searchController = TextEditingController();
  final searchDesTextEditing = TextEditingController();

  final carouselController = CarouselController();
  SearchServices services = SearchServices();
  // var markers = <MarkerId, Marker>{};
  late Completer<GoogleMapController> completer;
  double distance = 0.0;
  late Position _position;
  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  Position get position => _position;

  LatLng _initialPosition = const LatLng(23.83721, 90.363715);

  LatLng get initialPosition => _initialPosition;
  final address = ''.obs;
  final isDataLoading = false.obs;
  final RxBool isContainerVisible = false.obs;

  void toggleContainerVisibility() {
    isContainerVisible.value = !isContainerVisible.value;
    if (isContainerVisible.isFalse) {
      searchController.clear();
    }
  }

  Future _getCurrantLocation() async {
    try {
      _position = (await MapHelper.getCurrentPosition())!;
      _initialPosition = LatLng(_position.latitude, _position.longitude);
    } on Exception {
      // TODO
    }
  }

  Future<void> _moveCameraToMyLocation() async {
    await Future.delayed(const Duration(milliseconds: 100));
    goToPlaceByCamera(
      lat: _position.latitude,
      lng: _position.longitude,
      () => update(),
    );
  }

  Future<void> _drawMarkersIfHavePickedPoints() async {
    if (pickedPoints.isNotEmpty) {
      List<RippleMarker> markers = [];
      for (var element in pickedPoints) {
        markers.add(RippleMarker(
          markerId: MarkerId(pickedPoints.indexOf(element).toString()),
          position: element,
          ripple: false,
          icon: BitmapDescriptor.fromBytes(
              await getBytesFromAsset(Images.carIcon, 100)),
          onTap: () {},
        ));
      }

      addListMarker(update, markers: markers);
    }
  }

  _drawPolylineIfHavePickedPoints() {
    if (pickedPoints.length > 2) {
      
    }
  }

/*
  // Future<Position?> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     showDialog(
  //       context: Get.context!,
  //       barrierDismissible: false,
  //       builder: (context) => const PermissionDialog(),
  //     );
  //     Get.back();

  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       showDialog(
  //           context: Get.context!,
  //           barrierDismissible: false,
  //           builder: (context) => const PermissionDialog());

  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     showDialog(
  //         context: Get.context!,
  //         barrierDismissible: false,
  //         builder: (context) => const PermissionDialog());

  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   _position = await Geolocator.getCurrentPosition();
  //   print(position.latitude);
  //   mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(position.latitude ?? 0.0, position.longitude ?? 0.0),
  //       zoom: 17)));
  //   var marker = RippleMarker(
  //       markerId: kMarkerId,
  //       position: LatLng(position.latitude ?? 0.0, position.longitude ?? 0.0),
  //       ripple: false,
  //       icon: BitmapDescriptor.fromBytes(
  //           await getBytesFromAsset(Images.carIcon, 100)),
  //       onTap: () {});

  //   // setState(() {
  //   // markers[kMarkerId] = marker;
  //   // });
  //   update();
  //   return position;
  // }
  */

  onCameraIdle() async {
    isDataLoading.value = true;
    if (mapController != null) {
      LatLngBounds bounds = await mapController!.getVisibleRegion();
      final lon = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
      final lat = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;

      address.value = await services.getPlaceNameFromLatLng(LatLng(lat, lon));
      print('address is : ${address.value}');
    }
    isDataLoading.value = false;
  }

  ///needs to be refactored
  StreamSubscription<ServiceStatus> serviceStatusStream =
      Geolocator.getServiceStatusStream().listen((ServiceStatus status) async {
    try {
      print(status);
      LocationPermission permission;

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openAppSettings();
        // await Geolocator.openLocationSettings();
        // await openLocationSettings();
        Get.back();
        Get.defaultDialog(
            content: const Text(
          'Location services are disabled. Please enable the services.....',
          style: TextStyle(fontSize: 16),
        ));
        Get.back();
        return;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.back();
          Get.defaultDialog(
              content: const Text(
            'Location permissions are denied',
            style: TextStyle(fontSize: 16),
          ));
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Get.back();

        Get.defaultDialog(
            content: const Text(
          'Location permissions are permanently denied, we cannot request permissions **.',
          style: TextStyle(fontSize: 16),
        ));
        Get.off(const SetDestinationScreen());
        // Get.off(AddItemScreen(address: '', apartmentNumber: '', landMark: '', lat: '', lng: '', areaNumber: ''));
        return;
      }
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        // markers.clear();
        // markers=[];

        return await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high)
            .then((currLocation) async {
          // initialPosition = LatLng(currLocation.latitude, currLocation.longitude);
          // currentLocation=LatLng(currLocation.latitude, currLocation.longitude);
          // await getUserLocation(LatLng(currLocation.latitude, currLocation.longitude));
          // await   showPinsOnMap(LatLng(currLocation.latitude, currLocation.longitude));
          print(currLocation.longitude);

          Get.to(const SetDestinationScreen());
        });
      }
    } on TimeoutException {
      Get.defaultDialog(
          content: const Text(
        'Location request timed out.',
        style: TextStyle(fontSize: 12),
      ));
    } on PermissionDeniedException {
      Get.defaultDialog(
          content: const Text(
        'Location permissions are denied.',
        style: TextStyle(fontSize: 12),
      ));
    } on LocationServiceDisabledException {
      Get.defaultDialog(
          content: const Text(
        'Location services are disabled.',
        style: TextStyle(fontSize: 12),
      ));
    } on PermissionRequestInProgressException {
      Get.defaultDialog(
          content: const Text(
        'Location Permission Request InProgress Exception  .',
        style: TextStyle(fontSize: 12),
      ));
    }
  });
  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
    mapViewHelperMapController = mapController;
    // _mapCompleter = Completer<GoogleMapController>()..complete(mapController);
  }

  onMapCreated(gController) {
    _getCurrantLocation();

    setMapController(gController);
  }

  onCameraMove(CameraPosition position) {
    print(position.target);
  }
}
