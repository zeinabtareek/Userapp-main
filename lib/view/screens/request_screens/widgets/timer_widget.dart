



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/theme_controller.dart';
import '../../../../util/app_style.dart';
import '../controller/timer_controller.dart';



class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timerController = Get.find<TimerController>();
    return   GetBuilder<TimerController>(
        init: TimerController(),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Center Circle
              Container(
                width:70,
                height:60,
                child: GetBuilder<ThemeController>(
                    id: 1,
                    builder: (context) {
                      return  Stack(
                        fit: StackFit.expand,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation(
                                  timerController.seconds == 60*3
                                  // timerController.seconds == 60
                                      ?Theme.of(Get.context!).primaryColor
                                      : Theme.of(Get.context!).primaryColor),
                              backgroundColor:  const Color.fromARGB(255, 34, 34, 34)

                              , value: timerController.seconds /
                                TimerController.maxSeconds,
                            ),
                          ),
                          Center(
                            child: Text(    timerController.formattedTime,

                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:12,
                                // color: timerController.isCompleted()
                                //     ? Theme.of(Get.context!).primaryColor
                                //     : const Color.fromARGB(255, 178, 14, 2),
                                color:  timerController.seconds == TimerController.maxSeconds
                                    ? Theme.of(Get.context!).primaryColor
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )
                      ;
                    }),
              ),
              // const SizedBox(
              //   height: 50,
              // ),

              /// Buttons
              // timerController.isTimerRuning() ||
              //     !timerController.isCompleted()
              //     ? Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     ButtonWidget(
              //         onTap: () {
              //           timerController.isTimerRuning()
              //               ? timerController.stopTimer(rest: false)
              //               : timerController.startTimer(rest: false);
              //         },
              //         text: timerController.isTimerRuning()
              //             ? "Pause"
              //             : "Resume",
              //         color: timerController.isTimerRuning()
              //             ? Colors.red
              //             : Colors.green,
              //         fontWeight: FontWeight.w400),
              //     ButtonWidget(
              //         onTap: () {
              //           timerController.stopTimer(rest: true);
              //         },
              //         text: "Cancel",
              //         color: Colors.red,
              //         fontWeight: FontWeight.w600)
              //   ],
              // )
              //     :   ButtonWidget(
              //       onTap: () {
              //         timerController.startTimer();
              //       },
              //       text: "Start",
              //       color:  Colors.black,
              //       fontWeight: FontWeight.w400,
              //     )

            ],
          );
        }
    );
  }
}