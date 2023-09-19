import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/search_suggestion_model.dart';


abstract class SearchOnMapRepo{
  Future<List<Predictions>> getAutoCompleteFrom({ required String search, String country='' });
  Future<String> getPlaceId(String input) ;
  Future<Map<String, dynamic>> getPlace(String input);
  Future<Map<String, dynamic>> getDirections(String origin, String des);
  Future<PlaceDetail> getPlaceDetails(String placeId);
  Future<String> getPlaceNameFromLatLng(LatLng latLng);
  Future<LatLng?> getLatLngFromAddress(Position address);
}