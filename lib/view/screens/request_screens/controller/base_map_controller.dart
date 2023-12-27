import 'dart:async';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/images.dart';

import '../../../../bases/base_controller.dart';
import '../../../../enum/request_states.dart';
import '../../../../helper/cache_helper.dart';
import '../../../../mxins/map/map_view_helper.dart';
import '../../../../mxins/sokcit-io/socket_io_mixin.dart';
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
  LatLng? _initialPosition = const LatLng(23.83721, 90.363715);
  LatLng? get initialPosition => _initialPosition;

  late Position _position;
  Position get position => _position;

  //double _persistentContentHeight = 300;
  double _persistentContentHeight = 500;
  double percent = 0;
  set persistentContentHeightt(double num) {
    _persistentContentHeight = num;
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

  void setMapController(GoogleMapController mapController) {
    // mapViewHelperMapCompleter = mapController;
    controller = mapController;
    // widgetNumber.value = request[RequestState.findDriverState]!;
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
    setMapController(gController);
    await getCurrantLocation();
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

  void listonOnNotificationSocketAfterAccept({
    Function()? onStartTrip,
    Function()? onFinishedTrip,
    Function()? onCancelTrip,
  }) async {
    await getUser;
    if (getOrderId() != null) {

      // trackDriverLocationOnOrder();
      // sendMassage(["user_id", "${user!.id}"]);
      // subscribeToEvent("user-notification.${user!.id}", (data) {
      //   print('data :: $data');
      //   if ((data["data"]['order_id'].toString()) == getOrderId()) {
      //     if (data["data"]["notify_type"] == "change_order_status") {
      //       String? status = (data["data"]["status"].toString());
      //       if (status == "start_trip") {
      //         changeState(request[RequestState.tripOngoing]!);
      //       } else if (status == "finished") {
      //         disconnectSocket();
      //         changeState(request[RequestState.tripFinishedState]!);
      //       } else if (status == "cancel") {
      //         disconnectSocket();
      //         // TODO:
      //         changeState(request[RequestState.initialState]!);
      //       }
      //
      //       //
      //     }
      //   }
      // });

      initializeSocket(
        onConnect: () {
          trackDriverLocationOnOrder();
          sendMassage(["user_id", "${user!.id}"]);
          subscribeToEvent("user-notification.${user!.id}", (data) async {
            if ((data["data"]['order_id'].toString()) == getOrderId()) {
              if (data["data"]["notify_type"] == "change_order_status") {
                var baseMapController = Get.find<BaseMapController>();
                String? status = (data["data"]["status"].toString());
                if (status == "start_trip") {
                  print('start trip TAG');
                  baseMapController
                      .changeState(request[RequestState.tripOngoing]!);
                  baseMapController.persistentContentHeightt = 300;
                  baseMapController.key.currentState!.contract();

                  baseMapController.update();
                  Get.find<CreateATripController>().update();
                } else if (status == "finished") {
                  print('finished trip TAG');

                  // disconnectSocket();
                  baseMapController
                      .changeState(request[RequestState.tripFinishedState]!);
                } else if (status == "cancel") {
                  // TODO:

                  print('cancel trip TAG');

                  baseMapController
                      .changeState(request[RequestState.findDriverState]!);
                }

                //
              }
            }
          });
        },
        onDisconnect: (socket) {
          unsubscribeFromEvent("user-notification.${user?.id}");
        },
      );
      connectSocket();
    }
  }

  void trackDriverLocationOnOrder() {
    String? oId = getOrderId();
    sendSocketEvent("current_order", {
      "status": "driver_accept",
      "order_id": oId,
    });

    subscribeToEvent("map_$oId", (data) {
      if (kDebugMode) {
        print(" received data $data  $tag ");

      }
    });
  }

  RxnDouble distance = RxnDouble();
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
    return distance.value = result;
  }

///calculate duration 1
  // calculateDuration(List<LatLng> points) async {
  //   for (var i = 0; i < points.length - 1; i++) {
  //     DistanceModel model = await SearchServices.getDistance(
  //       points[i],
  //       points[i + 1],
  //     );
  //     duration = model.rows?[0].elements?[0].duration?.text ?? '';
  //   }
  //   return duration;
  // }

///calculate distance 1
  // calculateDistance(List<LatLng> points) async {
  // var result = 0.0;

  // for (var i = 0; i < points.length - 1; i++) {
  //      result += await SearchServices.getDistance(
  //        points[i],
  //        points[i + 1],
  //      );
  //   }
  // return distance.value = result;
  // }

  ///calculate duration 2
  // calculateDuration(LatLng source, LatLng dis) async {
  //   final result = await SearchServices.getDistanceAndDuration(
  //     source,
  //     dis,
  //   );
  //   final duration = result['duration'].toString();
  //   print('Duration: $duration');
  //   return duration;
  // }
}
