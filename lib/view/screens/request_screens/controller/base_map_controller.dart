import 'dart:async';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';

import '../../../../enum/request_states.dart';
import '../../../../helper/cache_helper.dart';
import '../../../../mxins/map/map_view_helper.dart';
import '../../ride/controller/ride_controller.dart';

class BaseMapController extends BaseController {
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

  final double _persistentContentHeight = 500;
  double percent = 0;

  double get persistentContentHeight => _persistentContentHeight;
  bool showRiderRequest = false;

  String? orderId;

  static const String orderIdKey = "orderIdKey";

  void setOrderId(String orderId) async {
    this.orderId = orderId;
    CacheHelper.setValue(kay: orderIdKey, value: orderId);
  }

  String? getOrderId() {
    if (!CacheHelper.instance!.containsKey(orderIdKey)) return null;
    return orderId = CacheHelper.getValue<String?>(kay: orderIdKey);
  }

  @override
  onInit() async {
    super.onInit();

    // if (getOrderId() != null) {
    //   Get.find<RideController>().updateRideCurrentState(RideState.findingRider);
    //   print('new trip data   $orderId');

    //   Get.find<BaseMapController>().key.currentState!.contract();
    //   Get.find<BaseMapController>()
    //       .changeState(request[RequestState.findDriverState]!);
    //   Get.find<BaseMapController>().update();
    // }

    await _getCurrantLocation();

    Timer? timer;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      percent += 50;
      if (percent >= 100) {
        timer!.cancel();
        showRiderRequest = true;
      }
    });
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
    // key.currentState!.expand();
    key.currentState!.contract();
    expansionStatus.value = key.currentState!.expansionStatus;
    widgetNumber.value = value;
  }
}
