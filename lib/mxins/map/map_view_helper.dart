import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../view/widgets/permission_dialog.dart';

mixin MapViewHelper on GetxController {
  GoogleMapController? _mapViewHelperMapController;

  set mapViewHelperMapController(GoogleMapController com) {
    _mapViewHelperMapController = com;
  }

  Completer<GoogleMapController>? _mapViewHelperMapCompleter;
  set mapViewHelperMapCompleter(GoogleMapController com) {
    mapViewHelperMapController = com;
    _mapViewHelperMapCompleter = Completer<GoogleMapController>()
      ..complete(com);
    // com.complete(_mapViewHelperMapController);
  }

  Completer<GoogleMapController>? get getMapViewHelperMapCompleter =>
      _mapViewHelperMapCompleter;

  // MapViewHelper(this.mapCompleter);
  final Set<Marker> _markers = <Marker>{};
  Set<Marker> get markers => _markers;

  final Set<Polyline> _polylines = <Polyline>{};

  Set<Polyline> get polylines => _polylines;

  List<LatLng> points = [];

  late Polyline thePolyline;

  Future<void> goToPlaceByCamera(
    Function() update, {
    required double lat,
    required double lng,
    double bearing = 192.8334901395799,
    double zoom = 19.0,
    bool isAnimate = true,
    double? disLat,
    double? disLong,
  }) async {
    bool isHaveDist = disLat != null && disLong != null;
    GoogleMapController controller =
        (await _mapViewHelperMapCompleter?.future)!;

    double zoomCamara = 0.0;
    if (isHaveDist) {
      LatLng dis = LatLng(disLat ?? lat, disLong ?? lng);
      // zoomCamara = calculateZoomLevel(LatLng(lat, lng), dis);
    }
    var cameraPosition = CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: bearing,
        target: LatLng(lat, lng),
        zoom: isHaveDist ? zoomCamara : zoom,
      ),
    );

    if (!isAnimate) {
      await controller.moveCamera(
        cameraPosition,
      );
    } else {
      await controller.animateCamera(cameraPosition);
    }
    update();
  }

  void addOneMarker(
    Function() update, {
    required Marker marker,
    bool isRequestUpdateUi = true,
  }) {
    if (_markers
        .any((element) => element.markerId.value == marker.markerId.value)) {
      _markers.removeWhere(
          (element) => element.markerId.value == marker.markerId.value);
    }
    _markers.add(marker);
    if (isRequestUpdateUi) {
      update();
    }
  }

  void addListMarker(
    Function() update, {
    required List<Marker> markers,
    bool isRequestUpdateForEachAddOneUi = false,
    bool isRequestUpdateUiAfterAddedALL = true,
  }) {
    for (var element in markers) {
      addOneMarker(
        update,
        marker: element,
        isRequestUpdateUi: isRequestUpdateForEachAddOneUi,
      );
    }
    if (isRequestUpdateUiAfterAddedALL) {
      update();
    }
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

  Future<Uint8List> getBytesFromNetwork(String imageUrl) async {
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
            .buffer
            .asUint8List();

    return bytes;
  }

  void addOnePolyline(
    Function() update, {
    required Polyline polyline,
    bool isRequestUpdateUi = true,
  }) {
    _polylines.add(polyline);
    thePolyline = polyline;

    if (isRequestUpdateUi) {
      update();
    }
  }

  void addOnePointToExistPolyline(
    Function() update, {
    required LatLng point,
    bool isRequestUpdateUi = true,
  }) {
    assert(_polylines.isNotEmpty,
        """ Must Add one polyline First   \n use  [addOnePolyline ] before this   """);

    // ignore: no_leading_underscores_for_local_identifiers
    List<LatLng> _points = [..._polylines.toList().first.points];
    _points.add(point);

    thePolyline = thePolyline.copyWith(pointsParam: _points);

    _polylines.remove(_polylines.elementAt(0));

    _polylines.add(thePolyline);
    if (isRequestUpdateUi) {
      update();
    }
  }

  void addListPointToExistPolyline(
    Function() update, {
    required List<LatLng> points,
    bool isRequestUpdateForEachAddOneUi = false,
    bool isRequestUpdateUiAfterAddedALL = true,
  }) {
    for (var point in points) {
      addOnePointToExistPolyline(() => update(),
          point: point, isRequestUpdateUi: isRequestUpdateForEachAddOneUi);
    }

    if (isRequestUpdateUiAfterAddedALL) {
      update();
    }
  }

  changeCurrentMarkerPoss(
    Function() update, {
    required LatLng newPos,
    bool isLiveUpdateUi = true,
    required Marker currentMarker,
  }) {
    var current = _markers.firstWhere(
      (element) => element.markerId.value == currentMarker.markerId.value,
      orElse: () => currentMarker,
    );

    _markers.remove(current);

    current = current.copyWith(positionParam: newPos);
    if (_markers
        .any((element) => element.markerId.value == current.markerId.value)) {
      _markers.removeWhere(
          (element) => element.markerId.value == current.markerId.value);
    }
    _markers.add(current);
    if (isLiveUpdateUi) {
      update();
    }
  }

  // double calculateZoomLevel(LatLng from, LatLng to) {
  //   // The map's camera position includes zoom, so you need to calculate that.
  //   // You can adjust the constants below to fine-tune the zoom level.
  //   const double minZoomLevel = 1.0; // Minimum zoom level
  //   const double maxZoomLevel = 21.0; // Maximum zoom level
  //   const double zoomChangeThreshold =
  //       1000.0; // Adjust this threshold as needed

  //   double distance =MapHelper.calculateDistance(
  //       from.latitude, from.longitude, to.latitude, to.longitude);

  //   double zoom = maxZoomLevel;

  //   if (distance > 0) {
  //     zoom = math.log(zoomChangeThreshold / distance) / math.ln2;
  //     zoom = math.max(minZoomLevel, math.min(maxZoomLevel, zoom));
  //   }

  //   return zoom;
  // }

  Future<void> openMap(LatLng source, LatLng dist) async {
    String domain = 'https://www.google.com/maps/dir/?api=1';
    String origin = 'origin=${source.latitude},${source.longitude}';
    String destination = 'destination=${dist.latitude},${dist.longitude}';
    //  travelMode  [driving, walking,transit,bicycling]
    String travelMode = 'travelmode=driving';
    String act = 'dir_action=navigate';
    String googleUrl = '$domain&$origin&$destination&$travelMode&$act';

    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

mixin MapHelper on GetxController {
  static Future<LocationPermission> checkPermission() async {
    return Geolocator.checkPermission();
  }

  static Future<bool> isLocationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  static Future<Position?> getCurrentPosition() async {
    LocationPermission locationPermission = await checkPermission();
    bool isHaveLocationPermission =
        locationPermission == LocationPermission.always ||
            locationPermission == LocationPermission.whileInUse;

    if (isHaveLocationPermission == false) {
      // if (false) {
      bool state = await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => const PermissionDialog(),
      );
    

      if (state == false) {
        return null;
      } else {
        return toAppSetting().then((value) async {
          if (value == false) {
            return await getCurrentPosition();
          }
          return null;
        });
      }
    }

    bool isServiceEnabled = await isLocationServiceEnabled();

    if (isServiceEnabled == false) {
      // if (false) {
      bool state = await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => const ServiceDialog(),
      );
      // Get.back();
      if (!state) {
        return null;
      } else {
        toSystemSetting().then((value) async {
          if (value == false) {
            await getCurrentPosition();
          }
        });
      }
    }

    return Geolocator.getCurrentPosition();
  }

  static Future<bool> toAppSetting() async {
    return Geolocator.openAppSettings();
  }

  static Future<bool> toSystemSetting() {
    return Geolocator.openLocationSettings();
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        math.cos((lat2 - lat1) * p) / 2 +
        math.cos(lat1 * p) *
            math.cos(lat2 * p) *
            (1 - math.cos((lon2 - lon1) * p)) /
            2;
    return 12742 * math.asin(math.sqrt(a));
  }

  double calculateDistanceWithGeolocator(
      double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  static Stream<Position>? _positionStream;
  static _initStream({LocationSettings? locationSettings}) {
    _positionStream ??=
        Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  static StreamSubscription<Position> getPositionWhenMove({
    accuracy = LocationAccuracy.best,
    int distanceFilter = 10,
    Duration? timeLimit,
    Function(Position position)? onChangeLocation,
  }) {
    var locationOptions = LocationSettings(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
      timeLimit: timeLimit,
    );
    _initStream(locationSettings: locationOptions);

    return _positionStream!.listen(
      onChangeLocation,
    );
  }
}
