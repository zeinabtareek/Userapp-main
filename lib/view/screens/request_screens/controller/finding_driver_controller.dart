import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../enum/request_states.dart';
import '../../where_to_go/controller/create_trip_controller.dart';
import 'base_map_controller.dart';

class FindingDriverController extends CreateATripController {
  ///handle future state only for testing
  ///
  String? oId;
  @override
  onInit() async {
    super.onInit();
    oId = getOrderId();
    handelSocket();

    await handelState();
  }

  void handelSocket() {
    initializeSocket(
      onConnect: () {
        sendSocketEvent("current_order", {
          // "status": "driver_accept",
          "status": "pending",
          "order_id": oId,
        });

        // subscribeToEvent("map_$oId", (data) {

        subscribeToEvent("map", (data) {
          if (kDebugMode) {
            print(" received data $data  $tag ");
            // showTrip();
          }
          if (data is List) {
            bool isMyOrder = data.first['order_id'].toString() == oId;
            // if (data["order_id"].toString() == getOrderId()) {
            if (isMyOrder) {
              disconnectSocket();

              showTrip();
              // unsubscribeFromEvent("map");
            }
          }
        });
      },
      onDisconnect: (socket) {
        socket.off("map");
      },
    );
    connectSocket();
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
