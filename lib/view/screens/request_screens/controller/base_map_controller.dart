import 'dart:async';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../enum/request_states.dart';
import '../../../../mxins/map/map_view_helper.dart';
import '../../ride/controller/ride_controller.dart';

class BaseMapController extends GetxController {
  GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
  var expansionStatus = ExpansionStatus.contracted.obs;
  var widgetNumber = 0.obs;

  Completer<GoogleMapController> mapCompleter =
  Completer<GoogleMapController>();
  GoogleMapController? _mapController;
  late   LatLng _initialPosition =   LatLng(23.83721, 90.363715);
  LatLng get initialPosition => _initialPosition;

  late Position _position;
  Position get position => _position;

    final double _persistentContentHeight = 700;
     double percent = 0;

  double get persistentContentHeight => _persistentContentHeight;
  bool showRiderRequest = false;
   @override
  onInit()async{
    super.onInit();

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

  changeState(int value){

   // key.currentState!.expand();
   key.currentState!.contract();
     expansionStatus.value =
        key.currentState!.expansionStatus;
    widgetNumber.value = value;
  }
}
