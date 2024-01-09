import 'dart:async';
import 'dart:developer';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../util/images.dart';

import '../../../../bases/base_controller.dart';
import '../../../../enum/request_states.dart';
import '../../../../helper/cache_helper.dart';
import '../../../../mxins/map/map_view_helper.dart';
import '../../../../mxins/sokcit-io/socket_io_mixin.dart';
import '../../../../util/app_constants.dart';
import '../../map/controller/map_controller.dart';
import '../../ride/controller/ride_controller.dart';
import '../../where_to_go/controller/create_trip_controller.dart';
import '../../where_to_go/model/distance_model.dart';
import '../../where_to_go/repository/search_service.dart';

class BaseMapController extends BaseController
    with SocketIoMixin, MapViewHelper {
  GlobalKey<ExpandableBottomSheetState> key = GlobalKey();
  var expansionStatus = ExpansionStatus.contracted.obs;
  var widgetNumber = 0.obs;
  MarkerId myMarkerId = const MarkerId('myMarker');

  Completer<GoogleMapController> mapCompleter =
      Completer<GoogleMapController>();
  LatLng? _initialPosition = const LatLng(24.774265, 46.738586);
  LatLng? get initialPosition => _initialPosition;

  late Position _position;
  Position get position => _position;

  //double _persistentContentHeight = 300;
  double _persistentContentHeight = 500;
  double percent = 0;
  set persistentContentHeightt(double num) {
    _persistentContentHeight = num;
    update();
  }

  double get persistentContentHeight => _persistentContentHeight;
  bool showRiderRequest = false;

  String? orderId;

  static const String orderIdKey = "orderIdKey";

  GoogleMapController? controller;

  void setOrderId(String? orderId) async {
    this.orderId = orderId;
    if (orderId != null) {
      CacheHelper.setValue(kay: orderIdKey, value: orderId);
    } else {
      CacheHelper.deleteOneValue(kay: orderIdKey);
    }
  }

  String? getOrderId() {
    if (!CacheHelper.instance!.containsKey(orderIdKey)) return null;
    return orderId = CacheHelper.getValue<String?>(kay: orderIdKey);
  }

  @override
  onInit() async {
    super.onInit();
    try {
      // await   WakelockPlus.enable();
    } catch (e) {
      print('Error enabling wakelock: $e');
    }

    // print('Wakelock ${WakelockPlus.enabled}');

    // await _getCurrantLocation();

    // setOrderId(null);
    // await checkRideStateToFindingDriver();
    persistentContentHeightt = 600;
    Timer? timer;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      percent += 50;
      if (percent >= 100) {
        timer!.cancel();
        showRiderRequest = true;
      }
    });
  }

  @override
  dispose() async {
    // Disable wakelock when the screen is disposed
    // await WakelockPlus.disable();
    super.dispose();
  }

  ///check whether there is a previous

  checkRideStateToFindingDriver() async {
    if (getOrderId() == null) {
      widgetNumber.value = request[RequestState.initialState]!;
    } else {
      // TODO::
      widgetNumber.value = request[RequestState.driverAcceptState]!;
    }
    update();
  }

  onBackPressed() {
    Get.find<RideController>().resetControllerValue();
    Get.back();
  }

  Future<LatLng?> getCurrantLocation() async {
    try {
      _position = (await MapHelper.getCurrentPosition())!;

      _initialPosition = LatLng(_position.latitude, _position.longitude);
      await drawMyMarker();

      goToPlaceByCamera(
        update,
        controller: controller!,
        lat: _initialPosition!.latitude,
        lng: _initialPosition!.longitude,
        bearing: _position.heading,
        isAnimate: true,
      );
      return _initialPosition;
    } on Exception {
      return null;
      throw UnimplementedError(" cannot getCurrantLocation  ");
    }
  }

  drawMyMarker() async {
    addOneMarker(
      update,
      marker: Marker(
        markerId: myMarkerId,
        position: _initialPosition!,
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset(Images.myMapIcon, 80),
        ),
        rotation: _position.heading,
      ),
    );
  }

  onMapCreated(gController) async {
    controller = gController;
    await getCurrantLocation();
    Get.put(CreateATripController()).getCurrantOrder();
    Get.find<RideController>().promoCodeController.text = '';
    // widgetNumber.value = request[RequestState.findDriverState]!;
  }

  changeState(int value) {
    if (key.currentState != null) {
      key.currentState?.contract();
      expansionStatus.value = key.currentState!.expansionStatus;
      widgetNumber.value = value;
    } else {
      key = GlobalKey<ExpandableBottomSheetState>();
      key.currentState?.contract();
    }
    update();
  }

  void listonOnNotificationSocketAfterAccept() async {
    await getUser;
    if (getOrderId() != null) {
      initializeSocket(
        onConnect: startListenOnNotification,
        onDisconnect: (socket) {
          stopListenOnNotification();
        },
      );
      connectSocket();
    }
  }

  void stopListenOnNotification() =>
      unsubscribeFromEvent("user-notification.${user?.id}");

  startListenOnNotification() {
    sendSocketEvent("user_id", "${user!.id}");
    trackingAllDriversOnMap();
    subscribeToEvent("user-notification.${user!.id}", (data) async {
      if ((data["data"]['order_id'].toString()) == getOrderId()) {
        if (data["data"]["notify_type"] == "change_order_status") {
          String? status = (data["data"]["status"].toString());
          log(
            'status:::  $tag $status ',
            name: "status:::  $tag",
          );
          handelTripUiBasedOnTripState(status);
        }
      }
    });
  }

  void handelTripUiBasedOnTripState(
    String status,
  ) {
    var baseMapController = Get.find<BaseMapController>();
    stopTrackingAllDriversOnMap();
    if (status == "start_trip") {
      Get.find<CreateATripController>().showTrip(orderId: getOrderId());

      if (kDebugMode) {
        print('start trip TAG');
      }
      baseMapController.changeState(request[RequestState.tripOngoing]!);
      baseMapController.persistentContentHeightt = 200;
      baseMapController.key.currentState!.contract();

      baseMapController.update();
      Get.find<CreateATripController>().update();
    } else if (status == "finished") {
      if (kDebugMode) {
        print('finished trip TAG');
      }

      baseMapController.changeState(request[RequestState.tripFinishedState]!);
      stopTrackTheDriverLocationOnOrder();

      disconnectSocket();
      setOrderId(null);
    } else if (status == "cancel" || status == "pending") {
      if (kDebugMode) {
        print('$state trip TAG');
      }
      if (status == "cancel") {
        stopTrackTheDriverLocationOnOrder();
      }
      trackingAllDriversOnMap();
      baseMapController.changeState(request[RequestState.findDriverState]!);
      // disconnectSocket();
    } else if (status == "driver_accept") {
      trackTheDriverLocationOnOrder();
      baseMapController.persistentContentHeightt = 200;
      baseMapController.key.currentState?.contract();
      baseMapController.update();
      Get.find<CreateATripController>().update();

      Get.find<CreateATripController>().showTrip(orderId: getOrderId());
    }
  }

  void trackingAllDriversOnMap() {
    subscribeToEvent(
      "map",
      (data) async {
        if (data is List<dynamic>) {
          drawListOfDriversOnMap(await _driversFromSocketToMarker(data));
        }
      },
    );
    String? oId = getOrderId();
    sendSocketEvent("current_order", {
      "status": "pending",
      "order_id": oId,
    });
  }

  Future<List<Marker>> _driversFromSocketToMarker(
    List<dynamic> data, {
    bool isTrackDriver = false,
  }) async {
    List<Marker> smarkers = [];
    for (var element in data) {
      if (kDebugMode) {
        print('elm $element  Ang ${element["angle"]} TAG  ${DateTime.now()}}');
      }

      String driverId = element["driver_id"];
      double lat = element["lat"];
      double lng = element["lng"];
      num head = element["angle"] ?? 30;
      Marker marker = Marker(
        markerId: MarkerId(driverId),
        position: LatLng(lat, lng),
        rotation: head.toDouble(),
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset(
              !isTrackDriver ? Images.nCar : Images.dCar, 50),
        ),
      );
      smarkers.add(marker);
    }
    return smarkers;
  }

  void stopTrackingAllDriversOnMap() {
    unsubscribeFromEvent("map");
  }

  void trackTheDriverLocationOnOrder() {
    String? oId = getOrderId();
    sendSocketEvent("current_order", {
      "status": "driver_accept",
      "order_id": oId,
    });

    subscribeToEvent("map_$oId", (data) async {
      if (data is List<dynamic>) {
        /// return the trip driver in list of one length
        var driverData = data.first;

        var list = driverData["points"] as List<dynamic>;

        bool isStarted = driverData["tripD"]["isStarted"];

        LatLng? dist;

        var driverMarkers = await _driversFromSocketToMarker(
          [driverData],
          isTrackDriver: true,
        );
        if (!isStarted) {
          dist = driverMarkers.first.position;
        } else {
          var lat = double.tryParse(driverData["tripD"]["to"]["lat"]);
          var lng = double.tryParse(driverData["tripD"]["to"]["lng"]);
          dist = LatLng(lat ?? 0, lng ?? 0);
        }

        if (list.isNotEmpty) {
          List<LatLng> points = list.map((e) {
            LatLng p = LatLng(e["lat"], e["lng"]);
            return p;
          }).toList();

          await _drawPolygyniesFromLatLngPoints(points);
        }
        drawListOfDriversOnMap(
          driverMarkers,
          isDrawMyMarker: !isStarted,
          trackPoint: dist,
        );
      }
    });
  }

  void stopTrackTheDriverLocationOnOrder() {
    String? oId = getOrderId();
    unsubscribeFromEvent("map_$oId");
  }

  RxnNum distance = RxnNum();
  String duration = '';
  var durationValue;

  ///calculate Distance

  calculateDistance(List<LatLng> points) async {
    double result = 0.0;

    for (var i = 0; i < points.length - 1; i++) {
      DistanceModel distanceModel = await SearchServices.getDistance(
        points[i],
        points[i + 1],
      );
      duration = distanceModel.rows?[0].elements?[0].duration?.text ?? '';
      durationValue =
          distanceModel.rows?[0].elements?[0].duration?.value ?? 0.0;
      double distanceInKm =
          (distanceModel.rows?[0].elements?[0].distance?.value?.toDouble() ??
                  0.0) /
              1000;
      result += distanceInKm;
    }
    return (distance.value = result.round()).round();
  }

  void drawListOfDriversOnMap(
    List<Marker> smarkers, {
    bool isDrawMyMarker = true,
    LatLng? trackPoint,
  }) {
    replaceMarkers(update, markers: smarkers);
    if (isDrawMyMarker) {
      drawMyMarker();
    }
    goToPlaceByCamera(
      update,
      controller: controller!,
      lat: initialPosition!.latitude,
      lng: initialPosition!.longitude,
      isAnimate: true,
      disLat: trackPoint?.latitude,
      disLng: trackPoint?.longitude,
    );
  }

  Future _drawPolygyniesFromLatLngPoints(List<LatLng> points) async {
    List<Polyline> polygynies = [];
    for (var i = 0; i < points.length - 1; i++) {
      polygynies.add(Polyline(
        polylineId: PolylineId("$i"),
        points: points,
        color: Colors.teal,
        width: 5,
        patterns: [PatternItem.dash(3.0)],
      ));
    }
    replacePolygynies(
      update,
      polygynies: polygynies,
    );
  }
}
