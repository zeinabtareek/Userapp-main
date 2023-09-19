import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:ride_sharing_user_app/services/map_services/map_repo.dart';

class MapRepoImplementation implements MapRepo{
  @override
  Future addPins(LatLng currentLocation) {
    // TODO: implement addPins
    throw UnimplementedError();
  }

  @override
  calculateDistanceBetweenTwoPoints(LatLng source, LatLng destination) {
    // TODO: implement calculateDistanceBetweenTwoPoints
    throw UnimplementedError();
  }

  @override
  clearDistanceBetweenTwoPoints() {
    // TODO: implement clearDistanceBetweenTwoPoints
    throw UnimplementedError();
  }

  @override
  closeListeningStream() {
    // TODO: implement closeListeningStream
    throw UnimplementedError();
  }

  @override
  // TODO: implement distanceBetweenTwoPoints
  RxnDouble get distanceBetweenTwoPoints => throw UnimplementedError();

  @override
  Future drawPolylineBetweenTwoPoints(LatLng source, LatLng destination) {
    // TODO: implement drawPolylineBetweenTwoPoints
    throw UnimplementedError();
  }

  @override
  Future getCurrentLocation(LatLng currentLocation) {
    // TODO: implement getCurrentLocation
    throw UnimplementedError();
  }

  @override
  listenOnChangeLocation() {
    // TODO: implement listenOnChangeLocation
    throw UnimplementedError();
  }
}