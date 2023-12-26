import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/ui/overlay_helper.dart';

import '../../../../enum/request_states.dart';
import '../../../../util/images.dart';
import '../../where_to_go/controller/create_trip_controller.dart';
import 'base_map_controller.dart';

class FindingDriverController extends CreateATripController {
  ///handle future state only for testing
  ///
  String? oId;
  Timer? _timer; // Declare the Timer as an instance variable

  @override
  void dispose() {
    // Cancel the timer when the screen is disposed
    _timer?.cancel();
    super.dispose();
  }
  @override
  onInit() async {
    super.onInit();
    oId = getOrderId();

    handelSocket();

    await handelState();

    initHandleWaitingStatus();
  }

  Future<void> initHandleWaitingStatus() async {
    await handleWaitingStatus(true);
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
            // bool isMyOrder = true;
            bool isMyOrder = data.first['order_id'].toString() == oId;
            // if (data["order_id"].toString() == getOrderId()) {
            if (isMyOrder) {
              disconnectSocket();


              // Get.find<BaseMapController>()
              //     .changeState(request[RequestState.driverAcceptState]!);
              ///...
              showTrip(orderId: getOrderId());
              trackDriverLocationOnOrder();
              sendMassage(["user_id", "${user!.id}"]);
              subscribeToEvent("user-notification.${user!.id}", (data) {
                print('data :: $data');
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
              ///...
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
      Future.delayed(const Duration(seconds: 5), () async {
        Get.find<BaseMapController>().key.currentState!.expand();
        Get.find<BaseMapController>()
            .changeState(request[RequestState.findDriverState]!);

        Get.find<BaseMapController>().update();

        // Get.find<BaseMapController>().changeState(request[RequestState.riderDetailsState]!);//riderDetailsState
      });
    }
  }

  ///handle waiting statue


  final List<String> randomTexts = [
    'Sorry_for_waiting_first_alert',
    'Sorry_for_waiting_sec_alert',
    'Sorry_for_waiting_third_alert',
    'Sorry_for_waiting_fourth_alert',
    'Sorry_for_waiting_fifth_alert',
    'Sorry_for_waiting_sixth_alert',
  ];

  printRandom() {
    final random = Random();
    final randomIndex = random.nextInt(randomTexts.length);
    print('randomTexts ::${randomTexts[randomIndex]}');
    OverlayHelper.showDurationAlert(Get.overlayContext!, randomTexts[randomIndex],Images.reloadIcon,'We Still searching for you',);
  }

  handleWaitingStatus(bool stillWaiting) async {
    if (stillWaiting) {
      const Duration intervalTimeout = Duration(minutes: 3);
      Duration initialTimeout = Duration(minutes: 2);

      Future.delayed(initialTimeout, () {
        print('object1');
      });

      _timer = Timer.periodic(intervalTimeout , (Timer timer) async {
        if (!stillWaiting) {
          timer.cancel();
        } else {
          await printRandom();
        }
      });
    }
}
}
