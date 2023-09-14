import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:ride_sharing_user_app/services/map_services/map_repo.dart';

class MapRepoImplementation implements MapRepo{
  @override
  Future addPins(LatLng currentLocation) {
    // TODO: implement addPins
    throw UnimplementedError();
  }

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

}