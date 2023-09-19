import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapRepo {
  // RxnDouble get distanceBetweenTwoPoints;

  Future getCurrentLocation(LatLng currentLocation);
  Future addPins(LatLng currentLocation);
  Future drawPolylineBetweenTwoPoints(LatLng source, LatLng destination);

  // calculateDistanceBetweenTwoPoints(LatLng source, LatLng destination);

  /*
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
   */
  // listenOnChangeLocation();

  // closeListeningStream();

  // clearDistanceBetweenTwoPoints();

  /*
  final RxDouble dist = 0.0.obs;
        for (var i = 0; i < coordinates.length - 1; i++) {
          dist.value += calculateDistance(
              coordinates[i].latitude,
              coordinates[i].longitude,
              coordinates[i + 1].latitude,
              coordinates[i + 1].longitude);
        }
   */

  // requestTripFromUser(LatLng source, LatLng destination);

  // cancelTripFromUser();

  // acceptTripFromUser();
  // acceptTripFromDriver();

  // rejectTripFromDriver();


  // completeTripFromDriver();
}
