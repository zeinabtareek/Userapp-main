import 'dart:async';
import 'dart:math';

import 'package:geolocator/geolocator.dart';

class MapHelper {
  static Future<LocationPermission> checkPermission() async {
    return Geolocator.checkPermission();
  }

  static Future<bool> isLocationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  static Future<Position?> getCurrentPosition({
    required Future<bool> Function() showLocationPermissionDialog,
    required Future<bool> Function() showServiceEnabledDialog,
  }) async {
    LocationPermission locationPermission = await checkPermission();
    bool isHaveLocationPermission =
        locationPermission == LocationPermission.denied ||
            locationPermission == LocationPermission.deniedForever;

    if (!isHaveLocationPermission) {
      bool state = await showLocationPermissionDialog();

      if (!state) {
        return null;
      } else {
        return toAppSetting().then((value) async => await getCurrentPosition(
              showLocationPermissionDialog: showLocationPermissionDialog,
              showServiceEnabledDialog: showServiceEnabledDialog,
            ));
      }
    }

    bool isServiceEnabled = await isLocationServiceEnabled();

    if (!isServiceEnabled) {
      bool state = await showServiceEnabledDialog();
      if (!state) {
        return null;
      } else {
        toSystemSetting().then(
          (value) async => await getCurrentPosition(
            showLocationPermissionDialog: showLocationPermissionDialog,
            showServiceEnabledDialog: showServiceEnabledDialog,
          ),
        );
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
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static double calculateDistanceWithGeolocator(
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
