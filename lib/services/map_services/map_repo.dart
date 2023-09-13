
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapRepo{

  Future getCurrentLocation(LatLng currentLocation);
  Future addPins(LatLng currentLocation);
  Future drawPolylineBetweenTwoPoints(LatLng source,LatLng destination);


}