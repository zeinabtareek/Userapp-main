import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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


 static bool checkIfPointIsInPolyLine(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (_rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

static  bool _rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
     double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }

    if (aX == bX) {
      return true;
    }
    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }
}

extension ToLatLong on PointLatLng {
  LatLng get toLatLng => LatLng(latitude, longitude);
}
