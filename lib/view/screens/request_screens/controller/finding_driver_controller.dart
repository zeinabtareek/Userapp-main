import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/mxins/sokcit-io/socket_io_mixin.dart';
import 'package:ride_sharing_user_app/view/screens/request_screens/controller/base_map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/controller/create_trip_controller.dart';

import '../../../../enum/request_states.dart';

class FindingDriverController extends CreateATripController with SocketIoMixin {
  ///handle future state only for testing
  @override
  onInit() async {
    super.onInit();
    String? oId = getOrderId();
    initializeSocket(
      onConnect: () {
        sendSocketEvent("current_order", {
          "status": "driver_accept",
          "order_id": oId,
        });

        subscribeToEvent("map_$oId", (data) {
          if (kDebugMode) {
            print(" received data $data  $tag ");
            // showTrip();
          }
          // if (data["order_id"].toString() == getOrderId()) {
          if (true) {
            showTrip();
          }
        });
      },
    );
    connectSocket();

    await handelState();
  }

  handelState() async {
    if (Get.find<BaseMapController>().widgetNumber.value ==
        request[RequestState.findDriverState]) {
      // Get.find<BaseMapController>(). key.currentState?.contract();
      Future.delayed(const Duration(seconds: 5), () async {
        Get.find<BaseMapController>().key.currentState!.expand();
        Get.find<BaseMapController>()
            .changeState(request[RequestState.findDriverState]!);

        Get.find<BaseMapController>().update();

        // Get.find<BaseMapController>().changeState(request[RequestState.riderDetailsState]!);//riderDetailsState
      });
    }
  }
}
