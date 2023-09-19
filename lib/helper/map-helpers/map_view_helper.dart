import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewHelper {
  Completer<GoogleMapController>? mapCompleter;
  MapViewHelper(this.mapCompleter);
  final Set<Marker> _markers = <Marker>{};
  Set<Marker> get markers => _markers;

  Future<void> goToPlace(
    Function() update, {
    required double lat,
    required double lng,
    double bearing = 192.8334901395799,
    double zoom = 19.0,
    bool isAnimate = true,
  }) async {
    GoogleMapController controller = await mapCompleter!.future;
    var cameraPosition = CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: bearing,
        target: LatLng(lat, lng),
        zoom: zoom,
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
}
