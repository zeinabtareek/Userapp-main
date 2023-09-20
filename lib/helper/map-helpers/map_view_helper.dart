import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/helper/map-helpers/map_helper.dart';

class MapViewHelper {
  Completer<GoogleMapController>? mapCompleter;
  MapViewHelper(this.mapCompleter);
  final Set<Marker> _markers = <Marker>{};
  Set<Marker> get markers => _markers;

  Set<Polyline> _polylines = <Polyline>{};

  Set<Polyline> get polylines => _polylines;

  List<LatLng> points = [];

  late Polyline thePolyline;

  Future<void> goToPlace(
    Function() update, {
    required double lat,
    required double lng,
    double bearing = 192.8334901395799,
    double zoom = 19.0,
    bool isAnimate = true,
    double? disLat,
    double? disLong,
  }) async {
    bool isHaveDist = disLat != null && disLong != null;
    GoogleMapController controller = await mapCompleter!.future;

    double zoomCamara=0.0;
    if (isHaveDist) {
  LatLng dis = LatLng(disLat ?? lat, disLong ?? lng);
   zoomCamara = calculateZoomLevel(LatLng(lat, lng), dis);
}
    var cameraPosition = CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: bearing,
        target: LatLng(lat, lng),
        zoom:isHaveDist? zoomCamara:zoom,
      ),
    );

    if (!isAnimate) {
      await controller.moveCamera(
        cameraPosition,
      );
    } else {
      await controller.animateCamera(cameraPosition);
    }
    update();
  }

  void addOneMarker(
    Function() update, {
    required Marker marker,
    bool isRequestUpdateUi = true,
  }) {
    if (_markers
        .any((element) => element.markerId.value == marker.markerId.value)) {
      _markers.removeWhere(
          (element) => element.markerId.value == marker.markerId.value);
    }
    _markers.add(marker);
    if (isRequestUpdateUi) {
      update();
    }
  }

  void addListMarker(
    Function() update, {
    required List<Marker> markers,
    bool isRequestUpdateForEachAddOneUi = false,
    bool isRequestUpdateUiAfterAddedALL = true,
  }) {
    for (var element in markers) {
      addOneMarker(
        update,
        marker: element,
        isRequestUpdateUi: isRequestUpdateForEachAddOneUi,
      );
    }
    if (isRequestUpdateUiAfterAddedALL) {
      update();
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List> getBytesFromNetwork(String imageUrl) async {
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
            .buffer
            .asUint8List();

    return bytes;
  }

  void addOnePolyline(
    Function() update, {
    required Polyline polyline,
    bool isRequestUpdateUi = true,
  }) {
    _polylines.add(polyline);
    thePolyline = polyline;

    if (isRequestUpdateUi) {
      update();
    }
  }

  void addOnePointToExistPolyline(
    Function() update, {
    required LatLng point,
    bool isRequestUpdateUi = true,
  }) {
    assert(_polylines.isNotEmpty,
        """ Must Add one polyline First   \n use  [addOnePolyline ] before this   """);

    // ignore: no_leading_underscores_for_local_identifiers
    List<LatLng> _points = [..._polylines.toList().first.points];
    _points.add(point);

    thePolyline = thePolyline.copyWith(pointsParam: _points);

    _polylines.remove(_polylines.elementAt(0));

    _polylines.add(thePolyline);
    if (isRequestUpdateUi) {
      update();
    }
  }

  void addListPointToExistPolyline(
    Function() update, {
    required List<LatLng> points,
    bool isRequestUpdateForEachAddOneUi = false,
    bool isRequestUpdateUiAfterAddedALL = true,
  }) {
    for (var point in points) {
      addOnePointToExistPolyline(() => update(),
          point: point, isRequestUpdateUi: isRequestUpdateForEachAddOneUi);
    }

    if (isRequestUpdateUiAfterAddedALL) {
      update();
    }
  }

  changeCurrentMarkerPoss(
    Function() update, {
    required LatLng newPos,
    bool isLiveUpdateUi = true,
    required Marker currentMarker,
  }) {
    var current = _markers.firstWhere(
      (element) => element.markerId.value == currentMarker.markerId.value,
      orElse: () => currentMarker,
    );

    _markers.remove(current);

    current = current.copyWith(positionParam: newPos);
    if (_markers
        .any((element) => element.markerId.value == current.markerId.value)) {
      _markers.removeWhere(
          (element) => element.markerId.value == current.markerId.value);
    }
    _markers.add(current);
    if (isLiveUpdateUi) {
      update();
    }
  }

  double calculateZoomLevel(LatLng from, LatLng to) {
    // The map's camera position includes zoom, so you need to calculate that.
    // You can adjust the constants below to fine-tune the zoom level.
    const double minZoomLevel = 1.0; // Minimum zoom level
    const double maxZoomLevel = 21.0; // Maximum zoom level
    const double zoomChangeThreshold =
        1000.0; // Adjust this threshold as needed

    double distance = MapHelper.calculateDistance(
        from.latitude, from.longitude, to.latitude, to.longitude);

    double zoom = maxZoomLevel;

    if (distance > 0) {
      zoom = math.log(zoomChangeThreshold / distance) / math.ln2;
      zoom = math.max(minZoomLevel, math.min(maxZoomLevel, zoom));
    }

    return zoom;
  }
}
