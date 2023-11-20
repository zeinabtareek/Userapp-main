import 'dart:async';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../bases/base_controller.dart';
import '../../../../enum/request_states.dart';
import '../../../../helper/cache_helper.dart';
import '../../../../mxins/map/map_view_helper.dart';
import '../../../../mxins/sokcit-io/socket_io_mixin.dart';
import '../../ride/controller/ride_controller.dart';
import '../../where_to_go/model/distance_model.dart';
import '../../where_to_go/repository/search_service.dart';

class BaseMapController extends BaseController with SocketIoMixin {
  GlobalKey<ExpandableBottomSheetState> key = GlobalKey();
  var expansionStatus = ExpansionStatus.contracted.obs;
  var widgetNumber = 0.obs;

  Completer<GoogleMapController> mapCompleter =
      Completer<GoogleMapController>();
  GoogleMapController? _mapController;
  late LatLng _initialPosition = const LatLng(23.83721, 90.363715);
  LatLng get initialPosition => _initialPosition;

  late Position _position;
  Position get position => _position;

  double _persistentContentHeight = 500;
  // final double _persistentContentHeight = 500;
  double percent = 0;
  set persistentContentHeightt(double num) {
    _persistentContentHeight = num;
  }

  double get persistentContentHeight => _persistentContentHeight;
  bool showRiderRequest = false;

  String? orderId;

  static const String orderIdKey = "orderIdKey";

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
      widgetNumber.value = request[RequestState.driverAcceptState]!;
    }
    update();
  }

  onBackPressed() {
    Get.find<RideController>().resetControllerValue();
    Get.back();
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future _getCurrantLocation() async {
    try {
      _position = (await MapHelper.getCurrentPosition())!;
      _initialPosition = LatLng(_position.latitude, _position.longitude);
    } on Exception {
      // TODO
    }
  }

  onMapCreated(gController) {
    _getCurrantLocation();

    setMapController(gController);
  }

  changeState(int value) {

if(key.currentState!=null){
    key.currentState?.contract();
    expansionStatus.value = key.currentState!.expansionStatus;
    widgetNumber.value = value;

  }
else{
  key = GlobalKey<ExpandableBottomSheetState>();

}
  update();
  }

  void listonOnNotificationSocketAfterAccept() async {
    await getUser;
    if (getOrderId() != null) {
      initializeSocket(
        onConnect: () {
          trackDriverLocationOnOrder();
          sendMassage(["user_id", "${user!.id}"]);
          subscribeToEvent("user-notification.${user!.id}", (data) {
            if ((data["data"]['order_id'].toString()) == getOrderId()) {
              if (data["data"]["notify_type"] == "change_order_status") {
                String? status = (data["data"]["status"].toString());
                if (status == "start_trip") {
                  changeState(request[RequestState.tripOngoing]!);
                } else if (status == "finished") {
                  disconnectSocket();
                  changeState(request[RequestState.tripFinishedState]!);
                } else if (status == "cancel") {
                  disconnectSocket();
                  // TODO:
                  changeState(request[RequestState.initialState]!);
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
        // showTrip();
      }
      // if (data is List) {
      // bool isMyOrder = data.first['order_id'].toString() == oId;
      // // if (data["order_id"].toString() == getOrderId()) {
      // if (isMyOrder) {
      //   showTrip();
      // }
      // }
    });
  }

  RxnDouble distance = RxnDouble();
  String duration = '';
  ///calculate Distance

  calculateDistance(List<LatLng> points) async {

      double result = 0.0;

      for (var i = 0; i < points.length - 1; i++) {
        DistanceModel distanceModel = await SearchServices.getDistance(
          points[i],
          points[i + 1],
        );

        double distance = distanceModel.rows?[0].elements?[0].distance?.value?.toDouble() ?? 0.0;
         result += distance;
      }
      print('total $result');

      return distance.value =result;

  }

    calculateDuration(List<LatLng> points) async {
      for (var i = 0; i < points.length - 1; i++) {
    DistanceModel model = await SearchServices. getDistance( points[i],
      points[i + 1],
        );
      duration = model.rows?[0].elements?[0].duration?.text ?? '';
  }
      return   duration;
  }

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

  ///calculate duration
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
