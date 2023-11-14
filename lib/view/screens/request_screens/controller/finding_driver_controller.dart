import 'dart:async';
import 'dart:math';

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


  ///handle waiting statue

handleWaitingStatus(bool stillWaiting )async{
  // Set the initial timeout to 2 minutes
  const Duration initialTimeout = Duration(minutes: 2);

  // Set the interval timeout to 50 seconds
  const Duration intervalTimeout = Duration(seconds: 50);
  // A list of 5 static strings
  final List<String> randomTexts = [
    'Text::: 1',
    'Text 2',
    'Text 3',
    'Text 4',
    'Text 5',
  ];

  // Function to print a random text from the list
  void printRandom() {
    final random = Random();
    final randomIndex = random.nextInt(randomTexts.length);
    print(randomTexts[randomIndex]);
  }

  // Start the initial timer
  Timer(initialTimeout, () {
    // Check if the parameter is still false after 2 minutes
    if (!stillWaiting) {
      // If still false, print a random text
      printRandom();

      // Set up a repeating timer with a 50-second interval
      Timer.periodic(intervalTimeout, (Timer timer) {
        // Check if the parameter is still false
        if (!stillWaiting) {
          // If still false, print another random text
          printRandom();
        } else {
          // If the parameter becomes true, cancel the timer
          timer.cancel();
        }
      });
    }
  });
}
}
