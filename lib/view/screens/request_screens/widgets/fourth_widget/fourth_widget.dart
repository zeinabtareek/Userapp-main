import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../enum/request_states.dart';
import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/images.dart';
import '../../../../../util/text_style.dart';
import '../../../../widgets/custom_button.dart';
import '../../../chat/models/res/msg_chat_res_model_item.dart';
import '../../../history/widgets/rider_details.dart';
import '../../../parcel/widgets/contact_widget.dart';
import '../../../parcel/widgets/route_widget.dart';
import '../../../parcel/widgets/tolltip_widget.dart';
import '../../../ride/widgets/estimated_fare_and_distance.dart';
import '../../../where_to_go/controller/create_trip_controller.dart';
import '../../controller/base_map_controller.dart';
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
      builder: (controller) => GetBuilder<BaseMapController>(
        init: BaseMapController()..listonOnNotificationSocketAfterAccept(),
        builder: (baseMapController) => FutureBuilder<Object>(
            future: Future.delayed(const Duration(seconds: 3), () {
              // controller.update();
              return true;
            }),
            builder: (context, snapshot) {
              return widget(
                baseMapController,
                context,
                controller,
                snapshot.connectionState == ConnectionState.waiting,
              );
            }),
      ),
    );
  }

  Column widget(
    BaseMapController baseMapController,
    BuildContext context,
    CreateATripController controller,
    bool isNotTripOngoing,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TollTipWidget(
          title: isOnGoing(baseMapController) //tripOngoing
              ? Strings.tripIsOngoing.tr
              : "",
        ),
        // K.sizedBoxH0,
        !isOnGoing(baseMapController) //tripOngoing
            ? const SizedBox()
            : ContactWidget(),
        // K.sizedBoxH0,
        isNotTripOngoing //tripOngoing
            ? Image.asset(Images.car)
            : const SizedBox(),
        // K.sizedBoxH0,
        isNotTripOngoing //tripOngoing
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeDefault),
                child: Text.rich(
                  TextSpan(
                    style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.8)),
                    children: [
                      TextSpan(
                          text: Strings.theCarJustArrivedAt.tr,
                          style: textRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault)),
                      TextSpan(text: " ".tr),
                      TextSpan(
                          text: Strings.yourDestination.tr,
                          style: textMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).primaryColor)),
                    ],
                  ),
                ),
              )
            : const SizedBox(),

        K.sizedBoxH0,
        ActivityScreenRiderDetails(
          riderDetails: Driverd(
              firstName: controller.orderModel.data?.driver?.firstName ?? '',
              rate: 5,
              img: controller.orderModel.data?.driver?.img ?? '',
              lastName: controller.orderModel.data?.driver?.lastName ?? '',
              vehicle: controller.orderModel.data?.driver?.vehicle),
        ),
        K.sizedBoxH0,
        EstimatedFareAndDistance(),
        K.sizedBoxH0,
        !isOnGoing(baseMapController) //tripOngoing
            ? const SizedBox()
            : RouteWidget(),
        K.sizedBoxH0,
        isOnGoing(baseMapController) //tripOngoing
            ? const SizedBox()
            : GetBuilder<TimerController>(
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
                              controller.cancelATrip(
                                  orderId: controller.createOrderModel.data?.id
                                      .toString());
                            }
                          : null,
                    )),
                    const TimerWidget(),
                  ],
                ),
              ),
        K.sizedBoxH0,
        K.sizedBoxH0,
      ],
    );
  }

  bool isOnGoing(BaseMapController baseMapController) {
    return baseMapController.widgetNumber.value ==
        request[RequestState.tripOngoing];
  }
}
