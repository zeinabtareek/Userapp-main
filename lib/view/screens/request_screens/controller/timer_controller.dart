




import 'dart:async';

import 'package:get/get.dart';

import '../../../../enum/request_states.dart';
import 'base_map_controller.dart';

class TimerController extends GetxController {
  static const maxSeconds = 6  ;
  // static const maxSeconds = 60 * 3;
  var seconds = maxSeconds;
  Timer? timer;

  String get formattedTime {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      startTimer(rest: false);
    });
  }


  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  /// Start Timer

  void startTimer({bool rest = false}) {
    if (rest) {
      resetTimer();
      update();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        update();
      } else {
        /// here handle the new state trip Ongoing
        stopTimer(rest: false);
        resetTimer();

        Get.find<BaseMapController>()
            .  key.currentState!.contract();
        Get.find<BaseMapController>()
            .changeState(request[RequestState.tripOngoing]!);
        Get.find<BaseMapController>()
            .update();
        ///this part  will be removed after socket
        Timer(const Duration(seconds: 7), () {
          Get.find<BaseMapController>().changeState(request[RequestState.tripFinishedState]!);
          Get.find<BaseMapController>().update();
        });



      }
    });
  }

  /// Stop Timer
  void stopTimer({bool rest = true}) {
    if (rest) {
      resetTimer();
      update();
    }
    timer?.cancel();
    update();
  }

  /// Dispose Timer




  /// Reset Timer
  void resetTimer() {
    seconds = maxSeconds;
    update();
  }

  /// is Timer Active?
  bool isTimerRuning() {
    return timer == null ? false : timer!.isActive;
  }

  /// is Timer Completed?
  bool isCompleted() {
    return seconds == maxSeconds || seconds == 0;
  }
}