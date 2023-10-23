import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../widgets/custom_button.dart';
import '../../../history/model/history_model.dart';
import '../../../history/widgets/rider_details.dart';
import '../../../map/controller/map_controller.dart';
import '../../../parcel/widgets/contact_widget.dart';
import '../../../parcel/widgets/route_widget.dart';
import '../../../parcel/widgets/tolltip_widget.dart';
import '../../../ride/widgets/estimated_fare_and_distance.dart';
import '../../../ride/widgets/rider_details_widget.dart';
import '../../../where_to_go/controller/create_trip_controller.dart';
import '../../controller/timer_controller.dart';
import '../timer_widget.dart';

class FourthWidget extends StatelessWidget {
  // VoidCallback cancelFunction;
  const FourthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateATripController>(
        init: CreateATripController(),
        // initState: Get.find<CreateATripController>().showTrip(),
        builder: (controller) => Column(children: [
              TollTipWidget(title: Strings.riderDetails.tr),
              K.sizedBoxH0,
              ContactWidget(),
              K.sizedBoxH0,
              K.sizedBoxH0,
              Text(controller.orderModel.data?.id.toString()??''),
              Text(controller.orderModel.data?.driver.toString()??''),
              ActivityScreenRiderDetails(
                riderDetails: Driver(
                    firstName: controller.orderModel.data?.driver?.firstName??'',
                    rate: 5,
                    img:
                        "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
                    lastName: controller.orderModel.data?.driver?.lastName??'',),
              ),
              K.sizedBoxH0,
              const EstimatedFareAndDistance(),
              K.sizedBoxH0,
              RouteWidget(),
              K.sizedBoxH0,
              GetBuilder<TimerController>(
                init: TimerController(),
                builder: (timerController) => Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      buttonText: 'cancel'.tr,
                      transparent: true,
                      borderWidth: 1,
                      textColor: timerController.isTimerRuning()
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(Get.context!).hintColor,
                      borderColor: timerController.isTimerRuning()
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(Get.context!).hintColor,
                      showBorder: true,
                      radius: Dimensions.radiusExtraLarge,
                      height: 40,
                      onPressed: timerController.isTimerRuning()
                          ? () {
                              timerController.stopTimer(rest: true);
                              controller.cancelATrip(orderId: controller.createOrderModel.data?.id.toString());
                            }
                          : null,
                    )),
                    TimerWidget(),
                  ],
                ),
              ),
              K.sizedBoxH0,
              K.sizedBoxH0,
            ]));
  }
}
