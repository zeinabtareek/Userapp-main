import 'dart:async';
import 'dart:math' as math;
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../view/widgets/permission_dialog.dart';

mixin MapViewHelper on GetxController {
  // MapViewHelper(this.mapCompleter);
  Set<Marker> _markers = <Marker>{};
  Set<Marker> get markers => _markers;

  final Set<Polyline> _polylines = <Polyline>{};

  Set<Polyline> get polylines => _polylines;

  List<LatLng> points = [];

  late Polyline thePolyline;

  Future<void> goToPlaceByCamera(
    Function() update, {
    required double lat,
    required double lng,
    required GoogleMapController controller,
    double bearing = 170,
    double zoom = 19.0,
    bool isAnimate = true,
    double? disLat,
    double? disLng,
  }) async {
    bool isHaveDist = disLat != null && disLng != null;
    // GoogleMapController? controller = _mapViewHelperMapController;

    LatLngBounds? bounds;
    LatLng? centerBounds;
    if (isHaveDist) {
      bounds = LatLngBounds(
        southwest: LatLng(lat, lng),
        northeast: LatLng(disLat, disLng),
      );
      centerBounds = LatLng(
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
      );
      zoomToFit(
        controller,
        bounds,
        centerBounds,
        padding: 0.2,
      );
    }

    // double? zoomCamara = 0.0;
    // if (isHaveDist) {
    //   LatLng dis = LatLng(disLat, disLng);
    //   zoomCamara = calculateZoomLevel(LatLng(lat, lng), dis);
    // }
    else {
      var cameraPosition = CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(lat, lng),
          zoom: isHaveDist ? 17 : zoom,
        ),
      );

      if (!isAnimate) {
        await controller.moveCamera(
          cameraPosition,
        );
      } else {
        await controller.animateCamera(cameraPosition);
      }
    }
    // update();
    // if (isHaveDist) {
    //   zoomToFit(controller, bounds!, centerBounds!, padding: 1.5);
    // }
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

  replaceMarkers(
    Function() update, {
    required List<Marker> markers,
    bool isRequestUpdateForEachAddOneUi = false,
    bool isRequestUpdateUiAfterAddedALL = true,
  }) {
    _markers.clear();
    _markers = <Marker>{};
    addListMarker(update, markers: markers);
    update();
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

  Future<void> zoomToFit(
      GoogleMapController controller, LatLngBounds bounds, LatLng centerBounds,
      {double padding = 0.5}) async {
    bool keepZoomingOut = true;

    while (keepZoomingOut) {
      final LatLngBounds screenBounds = await controller.getVisibleRegion();
      if (fits(bounds, screenBounds)) {
        keepZoomingOut = false;
        final double zoomLevel = await controller.getZoomLevel() - padding;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
        break;
      } else {
        final double zoomLevel = await controller.getZoomLevel() - 0.1;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck =
        screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck =
        screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck =
        screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck =
        screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck &&
        northEastLongitudeCheck &&
        southWestLatitudeCheck &&
        southWestLongitudeCheck;
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

  double calculateZoomLevel(LatLng origin, LatLng destination) {
    const double zoomConst = 15.0;
    const double maxZoom = 21.0;

    // Calculate the distance between the two LatLng points using Haversine formula
    double distance = MapHelper.calculateDistance(
      origin.latitude,
      origin.longitude,
      destination.latitude,
      destination.longitude,
    );

    // Adjust the distance for the zoom level calculation
    double zoomLevel = zoomConst - log(distance) / log(2);

    // Ensure the zoom level is within bounds
    if (zoomLevel < 0) {
      return 0;
    } else if (zoomLevel > maxZoom) {
      return maxZoom;
    } else {
      return zoomLevel;
    }
  }

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
        return await getCurrentPosition();
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
          if (value) {
            return await getCurrentPosition();
          }
        });

        //     .then((value) async {
        //   if (value == false) {
        //     await getCurrentPosition();
        //   }
        // });
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

  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
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

  // static Stream<Position>? _positionStream;
  // static _initStream({LocationSettings? locationSettings}) {
  //   _positionStream ??=
  //       Geolocator.getPositionStream(locationSettings: locationSettings);
  // }

  // static StreamSubscription<Position> getPositionWhenMove({
  //   accuracy = LocationAccuracy.best,
  //   int distanceFilter = 10,
  //   Duration? timeLimit,
  //   Function(Position position)? onChangeLocation,
  // }) {
  //   var locationOptions = LocationSettings(
  //     accuracy: accuracy,
  //     distanceFilter: distanceFilter,
  //     timeLimit: timeLimit,
  //   );
  //   _initStream(locationSettings: locationOptions);

  //   return _positionStream!.listen(
  //     onChangeLocation,
  //   );
  // }
}

class FlutterPolylinePointsHelper {
  FlutterPolylinePointsHelper._() {
    _init();
  }
  static PolylinePoints? _polylinePoints;
  static PolylinePoints get instance {
    if (_polylinePoints == null) {
      _init();
    }
    return _polylinePoints!;
  }

  static _init() {
    _polylinePoints ??= PolylinePoints();
  }

  static Future<PolylineResult> getRouteBetweenCoordinates(
    String googleAPiKey,
    double lat1,
    double long1,
    double lat2,
    double long2,
  ) async {
    PointLatLng origin = PointLatLng(lat1, long1);

    PointLatLng dest = PointLatLng(lat2, long2);

    PolylineResult result =
        await instance.getRouteBetweenCoordinates(googleAPiKey, origin, dest);
    return result;
  }

  static List<PointLatLng> decodePolyline(String decode) {
    List<PointLatLng> result = instance.decodePolyline(decode);
    return result;
  }

  // static Future<List<PolylineResult>> getRouteWithAlternatives(
  //   String googleAPiKey,
  //   double lat1,
  //   double long1,
  //   double lat2,
  //   double long2, {
  //   TravelMode mode = TravelMode.driving,
  // }) async {
  //   PointLatLng origin = PointLatLng(lat1, long1);

  //   PointLatLng dest = PointLatLng(lat2, long2);

  //   PolylineRequest request = PolylineRequest(
  //     apiKey: googleAPiKey,
  //     origin: origin,
  //     destination: dest,
  //     mode: mode,
  //     wayPoints:
  //   );
  //   List<PolylineResult> result =
  //       await instance.getRouteWithAlternatives(request: request);

  //   return result;
  // }

  static bool checkIfPointIsInPolyLine(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (_rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  static bool _rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }

    if (aX == bX) {
      return true;
    }
    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }
}

extension ToLatLong on PointLatLng {
  LatLng get toLatLng => LatLng(latitude, longitude);
}
