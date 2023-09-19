import 'dart:convert' as convert;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart' as http;

import '../../util/app_constants.dart';
import 'models/search_suggestion_model.dart';
import 'search_repo.dart';

class SearchOnMapRepoImp implements SearchOnMapRepo {
  // TODO:
  @override
  Future<List<Predictions>> getAutoCompleteFrom({
    required String search,
    String country = 'eg',
  }) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&components=country:$country&key=${AppConstants.mapKey}';
    // 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&components=country:$country&key=AIzaSyCzuhU5w3Ah8t2x2pIKXzsGoATsdzVNK9I';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsnResults = json['predictions'] as List;
    return jsnResults.map((place) => Predictions.fromJson(place)).toList();
    // return jsnResults.map((place) => Suggestion.fromJson(place)).toList();
  }

  @override
  Future<Map<String, dynamic>> getDirections(String origin, String des) async {
    var url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$des&key=${AppConstants.mapKey}';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints().decodePolyline(
        json['routes'][0]['overview_polyline']['points'],
      )
    };
    print(results);
    return results;
  }

  @override
  Future<LatLng?> getLatLngFromAddress(Position address) async {
    // try {

    //   final locations = await locationFromAddress(address.toString());
    //   if (locations.isNotEmpty) {
    //     final firstLocation = locations.first;
    //     return LatLng(firstLocation.latitude, firstLocation.longitude);
    //   }
    // } catch (e) {
    //   print("Error: $e");
    // }
    // return null; // Return null if the address couldn't be geocoded

    return Future.value(LatLng(address.latitude, address.longitude));
  }

  @override
  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${AppConstants.mapKey}';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;
    print(results);
    return results;
  }

  @override
  Future<PlaceDetail> getPlaceDetails(String placeId) async {
    String placeDetailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${AppConstants.mapKey}';
    // 'https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&key=AIzaSyCzuhU5w3Ah8t2x2pIKXzsGoATsdzVNK9I';
    var response = await http.get(Uri.parse(placeDetailsUrl));
    var json = convert.jsonDecode(response.body);
    var jsnResults = json['result'] as Map<String, dynamic>;
    return PlaceDetail.fromJson(jsnResults);
  }

  @override
  Future<String> getPlaceId(String input) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=${AppConstants.mapKey}';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;
    print(placeId);
    return placeId;
  }

  @override
  Future<String> getPlaceNameFromLatLng(LatLng latLng) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    return "${placemark[0].name}, ${placemark[0].locality}, ${placemark[0].country}";
  }
}
