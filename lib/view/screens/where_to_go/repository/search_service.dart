//
import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ride_sharing_user_app/util/app_constants.dart';

import '../model/distance_model.dart';
import '../model/search_suggestion_model.dart';

class SearchServices {
  final Completer<GoogleMapController> _controller = Completer();
  final String _country = 'sa';

// https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&components=country:eg&types=(cities)&key=${K.googleKeyAPi}
  Future<List<Predictions>> getAutoCompleteFrom(
      // Future<List<Suggestion>> getAutoCompleteFrom(
      {
    required String search,
  }) async {
    print('map api key is::${AppConstants.mapKey}');
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&components=country:$_country&key=${AppConstants.mapKey}';
    // 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&components=country:$country&key=AIzaSyCzuhU5w3Ah8t2x2pIKXzsGoATsdzVNK9I';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsnResults = json['predictions'] as List;
    return jsnResults.map((place) => Predictions.fromJson(place)).toList();
    // return jsnResults.map((place) => Suggestion.fromJson(place)).toList();
  }

  Future<String> getPlaceId(String input) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=${AppConstants.mapKey}';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;
    print(placeId);
    return placeId;
  }

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
    return results; // return results;
  }

  /// *******not needed till now***********
  Future<PlaceDetail> getPlaceDetails(String placeId) async {
    String placeDetailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${AppConstants.mapKey}';
    // 'https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&key=AIzaSyCzuhU5w3Ah8t2x2pIKXzsGoATsdzVNK9I';
    var response = await http.get(Uri.parse(placeDetailsUrl));
    var json = convert.jsonDecode(response.body);
    var jsnResults = json['result'] as Map<String, dynamic>;
    return PlaceDetail.fromJson(jsnResults);
  }

  Future<String> getPlaceNameFromLatLng(LatLng latLng) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    return "${placemark[0].name}, ${placemark[0].locality}, ${placemark[0].country}";
  }

  static Future<DistanceModel> getDistance(LatLng origin, LatLng destination) async {
    DistanceModel model;

    String Url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&destinations=${origin.latitude},${origin.longitude}&origins=${destination.latitude},${destination.longitude}&key=${AppConstants.mapKey}';
    try {
      ///thisWorks JustFine
      var response = await http.get(Uri.parse(Url));
      // if (response.statusCode == 200) {
      //   var responseData = jsonDecode(response.body);
      //   print(" responseData $responseData ");
      //   final distanceValue =
      //       responseData['rows'][0]['elements'][0]['distance']['value'];
      //   var distanceInKm = distanceValue / 1000;
      //   return distanceInKm;
      // } else {
      //   return null;
      // }
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        model = DistanceModel.fromJson(jsonDecode(response.body));
        return model;
      } else if (response.statusCode == 401) {
        print(response.statusCode);
        throw Error();
      } else if (response.statusCode == 500 ||
          response.statusCode == 501 ||
          response.statusCode == 504 ||
          response.statusCode == 502) {
        print(response.statusCode);
        throw Error();
      }
      else{
        throw Error();
      }
    } catch (e) {
      print(e);
      throw Exception();
      // return null;
    }
  }
 }
