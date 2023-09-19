import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class FlutterPolylinePointsHelper {
  FlutterPolylinePointsHelper._() {
    _init();
  }
  static PolylinePoints? _polylinePoints;
  static PolylinePoints get instance {
    if (_polylinePoints == null) {
      _init();
    }
    return _polylinePoints!;
  }

  static _init() {
    _polylinePoints ??= PolylinePoints();
  }

  static Future<PolylineResult> getRouteBetweenCoordinates(
    String googleAPiKey,
    double lat1,
    double long1,
    double lat2,
    double long2,
  ) async {
    PointLatLng origin = PointLatLng(lat1, long1);

    PointLatLng dest = PointLatLng(lat2, long2);

    PolylineResult result =
        await instance.getRouteBetweenCoordinates(googleAPiKey, origin, dest);
    return result;
  }

  static List<PointLatLng> decodePolyline(String decode) {
    List<PointLatLng> result = instance.decodePolyline(decode);
    return result;
  }

  // static Future<List<PolylineResult>> getRouteWithAlternatives(
  //   String googleAPiKey,
  //   double lat1,
  //   double long1,
  //   double lat2,
  //   double long2, {
  //   TravelMode mode = TravelMode.driving,
  // }) async {
  //   PointLatLng origin = PointLatLng(lat1, long1);

  //   PointLatLng dest = PointLatLng(lat2, long2);

  //   PolylineRequest request = PolylineRequest(
  //     apiKey: googleAPiKey,
  //     origin: origin,
  //     destination: dest,
  //     mode: mode,
  //     wayPoints: 
  //   );
  //   List<PolylineResult> result =
  //       await instance.getRouteWithAlternatives(request: request);

  //   return result;
  // }


}
