import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/search_suggestion_model.dart';
import 'search_repo.dart';

class SearchOnMapUseCase {
  final SearchOnMapRepo searchOnMapRepo;

  SearchOnMapUseCase(this.searchOnMapRepo);

  Future<List<Predictions>> getAutoCompleteFrom(
      {required String search, String country = ''}) {
    return searchOnMapRepo.getAutoCompleteFrom(
        search: search, country: country);
  }

  Future<String> getPlaceId(String input) {
    return searchOnMapRepo.getPlaceId(input);
  }

  Future<Map<String, dynamic>> getPlace(String input) {
    return searchOnMapRepo.getPlace(input);
  }

  Future<Map<String, dynamic>> getDirections(String origin, String des) {
    return searchOnMapRepo.getDirections(origin, des);
  }

  Future<PlaceDetail> getPlaceDetails(String placeId) {
    return searchOnMapRepo.getPlaceDetails(placeId);
  }

  Future<String> getPlaceNameFromLatLng(LatLng latLng) {
    return searchOnMapRepo.getPlaceNameFromLatLng(latLng);
  }

  Future<LatLng?> getLatLngFromAddress(Position address) {
    return searchOnMapRepo.getLatLngFromAddress(address);
  }
}
