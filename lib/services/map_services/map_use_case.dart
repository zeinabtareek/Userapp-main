import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/services/map_services/map_repo.dart';

class MapUseCase{
  late MapRepo mapRepo ;
  MapUseCase(this.mapRepo);




  @override
  Future addPins(LatLng currentLocation) {
    return mapRepo.addPins(currentLocation);
  }

  @override
  Future drawPolylineBetweenTwoPoints(LatLng source, LatLng destination) {
    return mapRepo.drawPolylineBetweenTwoPoints(source, destination);

  }

  @override
  Future getCurrentLocation(LatLng currentLocation) {
    return mapRepo.getCurrentLocation(currentLocation);
  }



}