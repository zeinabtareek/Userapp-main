import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
   Get.find<BaseMapController>(). listonOnNotificationSocketAfterAccept();

    //  handleInitialState();
  }
  // Future<void> handleInitialState() async {
  //   final baseMapController = Get.find<BaseMapController>();
  //
  //   if (baseMapController.widgetNumber.value == request[RequestState.findDriverState]) {
  //     await handleWaitingStatus(true);
  //
  //     // Delay and update state
  //     Future.delayed(const Duration(seconds: 5), () async {
  //       baseMapController.key.currentState!.expand();
  //       baseMapController.changeState(request[RequestState.findDriverState]!);
  //       baseMapController.update();
  //       // baseMapController.changeState(request[RequestState.riderDetailsState]!); // Uncomment if needed
  //     });
  //   } else {
  //     await handleWaitingStatus(false);
  //   }
  // }
  // Future<void> initHandleWaitingStatus() async {
  //   if (Get.find<BaseMapController>().widgetNumber.value ==  request[RequestState.findDriverState]) {
  //     await handleWaitingStatus(true);
  //   } else {
  //   await  handleWaitingStatus(false);
  //     return;
  //   }
  // }
  //
  // handelState() async {
  //   if (Get.find<BaseMapController>().widgetNumber.value ==
  //       request[RequestState.findDriverState]) {
  //     Future.delayed(const Duration(seconds: 5), () async {
  //       Get.find<BaseMapController>().key.currentState!.expand();
  //       Get.find<BaseMapController>()  .changeState(request[RequestState.findDriverState]!);
  //
  //       Get.find<BaseMapController>().update();
  //
  //       // Get.find<BaseMapController>().changeState(request[RequestState.riderDetailsState]!);//riderDetailsState
  //     });
  //   }
  // }


  //                  await Get.find<FindingDriverController>().   handleWaitingStatus(false);



    void handleInitialState() async {
      final baseMapController = Get.find<BaseMapController>();

      if (baseMapController.widgetNumber.value != request[RequestState.findDriverState]) {
        await handleWaitingStatus(false);
      } else {
        await handleWaitingStatus(true);

        // Additional logic when status is "finding driver"
        // You can add more code here if needed
      }

      // Common logic after the condition
      // This code will be executed regardless of the condition
      Future.delayed(const Duration(seconds: 5), () async {
        baseMapController.key.currentState!.expand();
        baseMapController.changeState(request[RequestState.findDriverState]!);
        baseMapController.update();
        // baseMapController.changeState(request[RequestState.riderDetailsState]!); // Uncomment if needed
      });

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
    if (kDebugMode) {
      print('randomTexts ::${randomTexts[randomIndex]}');
    }
    OverlayHelper.showDurationAlert(
      Get.overlayContext!,
      randomTexts[randomIndex],
      Images.reloadIcon,
      'We Still searching for you',
    );
  }

  handleWaitingStatus(bool stillWaiting) async {
    print('handleWaitingStatus called with stillWaiting: $stillWaiting');

    if (stillWaiting) {
      const Duration intervalTimeout = Duration(minutes: 3);
      Duration initialTimeout = const Duration(minutes: 2);

      Future.delayed(initialTimeout, () {
        print('Initial timeout reached');
      });

      _timer = Timer.periodic(intervalTimeout, (Timer timer) async {
        if (!stillWaiting) {
          print('Timer cancelled');
          timer.cancel();
          // Clean up resources or perform any necessary actions
        } else {
          await printRandom();
        }
      });
    } else {
      _timer?.cancel();
      print('Timer cancelled outside the loop');
      // Clean up resources or perform any necessary actions
    }
  }

}
