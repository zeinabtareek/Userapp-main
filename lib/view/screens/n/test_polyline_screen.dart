import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'controller.dart';
// import 'package:map_location_picker/map_location_picker.dart';

import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(13.0827, 80.2707),
    zoom: 14.4746,
  );

  final Set<Polygon> _polygons = HashSet<Polygon>();
  final Set<Polyline> _polyLines = HashSet<Polyline>();

  bool _drawPolygonEnabled = false;
  List<LatLng> _userPolyLinesLatLngList = [];
  bool _clearDrawing = false;
  int? _lastXCoordinate, _lastYCoordinate;

  List<LatLng> _mapLatLang = [];
  List<LatLng> _latLang = [];

  _getlatlan() {
    setState(() => LatLng(13.0827, 80.2707));
  }

  _toggleDrawing() {
    _clearPolygons();
    setState(() => _drawPolygonEnabled = !_drawPolygonEnabled);
  }

  _onPanUpdate(DragUpdateDetails details) async {
    // To start draw new polygon every time.
    if (_clearDrawing) {
      _clearDrawing = false;
      _clearPolygons();
    }

    if (_drawPolygonEnabled) {
      double x = 0, y = 0;
      if (Platform.isAndroid) {
        // It times in 3 without any meaning,
        // We think it's an issue with GoogleMaps package.
        x = details.globalPosition.dx * 3;
        y = details.globalPosition.dy * 3;
      } else if (Platform.isIOS) {
        x = details.globalPosition.dx;
        y = details.globalPosition.dy;
      }

      // Round the x and y.
      int xCoordinate = x.round();
      int yCoordinate = y.round();

      // Check if the distance between last point is not too far.
      // to prevent two fingers drawing.
      if (_lastXCoordinate != null && _lastYCoordinate != null) {
        var distance = Math.sqrt(Math.pow(
                xCoordinate - double.parse(_lastXCoordinate.toString()), 2) +
            Math.pow(
                yCoordinate - double.parse(_lastYCoordinate.toString()), 2));

        // Check if the distance of point and point is large.
        if (distance > 80.0) return;
      }

      // Cached the coordinate.
      _lastXCoordinate = xCoordinate;
      _lastYCoordinate = yCoordinate;

      ScreenCoordinate screenCoordinate =
          ScreenCoordinate(x: xCoordinate, y: yCoordinate);

      final GoogleMapController controller = await _controller.future;
      LatLng latLng = await controller.getLatLng(screenCoordinate);

      try {
        // Add new point to list.
        _userPolyLinesLatLngList.add(latLng);
        _latLang.add(latLng);

        _polyLines.removeWhere(
            (polyline) => polyline.polylineId.value == 'user_polyline');
        _polyLines.add(
          Polyline(
            polylineId: PolylineId('user_polyline'),
            points: _userPolyLinesLatLngList,
            width: 2,
            color: Colors.blue,
          ),
        );
      } catch (e) {
        print(" error painting $e");
      }
      setState(() {});
    }
  }

  _onPanEnd(DragEndDetails details) async {
    // Reset last cached coordinate
    _lastXCoordinate = null;
    _lastYCoordinate = null;

    if (_drawPolygonEnabled) {
      _polygons
          .removeWhere((polygon) => polygon.polygonId.value == 'user_polygon');
      _polygons.add(
        Polygon(
          polygonId: PolygonId('user_polygon'),
          points: _userPolyLinesLatLngList,
          strokeWidth: 2,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.4),
        ),
      );
      setState(() {
        _clearDrawing = true;
        _mapLatLang = _userPolyLinesLatLngList;
      });
    }
  }

  _clearPolygons() {
    setState(() {
      _polyLines.clear();
      _polygons.clear();
      _userPolyLinesLatLngList.clear();
    });
  }

  var lat = [LatLng(12.82879876203614, 80.12908793985844)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farm'),
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        actions: <Widget>[
          TextButton(
            // : Colors.grey.shade800,
            onPressed: () {
              _drawPolygonEnabled
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddEditPage(data: new DataLat(_latLang)),
                      ),
                    )
                  : null;
            },
            child: _drawPolygonEnabled ? Text("Save") : Text("Draw"),
            // shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (_drawPolygonEnabled) ? _onPanUpdate : null,
        onPanEnd: (_drawPolygonEnabled) ? _onPanEnd : null,
        child: GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          polygons: _polygons,
          polylines: _polyLines,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleDrawing,
        tooltip: 'Drawing',
        child: new IconTheme(
          data: new IconThemeData(color: Colors.grey.shade800),
          child: new Icon((_drawPolygonEnabled) ? Icons.cancel : Icons.edit),
        ),
      ),
    );
  }
}

class DataLat {
  List<LatLng> latLng;

  DataLat(this.latLng);
}

class AddEditPage extends StatelessWidget {
  AddEditPage({super.key, required this.data});

  DataLat data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text(data.latLng.first.toString())],
      ),
    );
  }
}
