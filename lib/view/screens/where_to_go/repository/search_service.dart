//
import 'dart:async';
import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'dart:convert' as convert;

import '../../../../util/app_style.dart';
import '../model/search_suggestion_model.dart';

class SearchServices {
  Completer<GoogleMapController> _controller = Completer();

// https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&components=country:eg&types=(cities)&key=${K.googleKeyAPi}
  Future<List<Predictions>> getAutoCompleteFrom(
  // Future<List<Suggestion>> getAutoCompleteFrom(
      {required String search, String country = 'eg'}) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&components=country:$country&key=${AppConstants.mapKey}';
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

  /*********not needed till now************/
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
  static Future<dynamic> getDistance(LatLng origin, LatLng destination) async {
    String Url = 'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${origin.latitude},${origin.longitude}&origins=${destination.latitude},${destination.longitude}&key=AIzaSyA6NSYZTZaYj_Kgit9CAlNuCTvwLOoRSes';
    try {
      var response = await http.get(Uri.parse(Url));
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        final distanceValue = responseData['rows'][0]['elements'][0]['distance']['value'];
        var distanceInKm = distanceValue / 1000;
        return distanceInKm;

      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
  // static Future<dynamic> getDuration(LatLng origin, LatLng destination) async {
  //   String Url = 'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${origin.latitude},${origin.longitude}&origins=${destination.latitude},${destination.longitude}&key=AIzaSyA6NSYZTZaYj_Kgit9CAlNuCTvwLOoRSes';
  //   try {
  //     var response = await http.get(Uri.parse(Url));
  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);
  //       final duration = responseData['rows'][0]['elements'][0]['duration']['text'];
  //
  //       return duration;
  //
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }


  // Future<Map<String, dynamic>>
  static getDistanceAndDuration(LatLng origin, LatLng destination) async {
    final apiUrl = 'https://maps.googleapis.com/maps/api/distancematrix/json';
    final url = '$apiUrl?origins=${origin.latitude},${origin.longitude}&destinations=${destination.latitude},${destination.longitude}&key=AIzaSyA6NSYZTZaYj_Kgit9CAlNuCTvwLOoRSes';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final distance = data['rows'][0]['elements'][0]['distance']['text'];
    final duration = data['rows'][0]['elements'][0]['duration']['text'];
    return   duration;
    // return {'distance': distance, 'duration': duration};
  }
}
