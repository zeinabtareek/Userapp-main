import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../enum/request_states.dart';
import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/images.dart';
import '../../../../../util/text_style.dart';
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
        builder: (controller) =>
            GetBuilder<BaseMapController>(
          init: BaseMapController(),
          builder: (baseMapController) => Column(children: [
              TollTipWidget(title:

              baseMapController.widgetNumber.value ==request[ RequestState.tripOngoing]//tripOngoing
                  ?Strings.tripIsOngoing.tr:
              Strings.riderDetails.tr),
              K.sizedBoxH0,
            baseMapController.widgetNumber.value ==request[ RequestState.tripOngoing]//tripOngoing
                ?SizedBox():
            ContactWidget(),
              K.sizedBoxH0,

            baseMapController.widgetNumber.value ==request[ RequestState.tripOngoing]//tripOngoing
                ?  Image.asset(Images.car):SizedBox(),
            K.sizedBoxH0,
            baseMapController.widgetNumber.value ==request[ RequestState.tripOngoing]//tripOngoing
                ?                 Padding(
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
            ):SizedBox(),

            K.sizedBoxH0,
              ActivityScreenRiderDetails(
                riderDetails:
                Driver(
                    firstName: controller.orderModel.data?.driver?.firstName??'',
                    rate: 5,
                    img:  controller.orderModel.data?.driver?.img??'',
                    lastName: controller.orderModel.data?.driver?.lastName??'',
                  vehicle: controller.orderModel.data?.driver?.vehicle
                ),
              ),
              K.sizedBoxH0,
              const EstimatedFareAndDistance(),
              K.sizedBoxH0,
            baseMapController.widgetNumber.value ==request[ RequestState.tripOngoing]//tripOngoing
                ?SizedBox(): RouteWidget(),
              K.sizedBoxH0,
       baseMapController.widgetNumber.value ==request[ RequestState.tripOngoing]//tripOngoing
        ?SizedBox():
         GetBuilder<TimerController>(
                init: TimerController(),
                builder: (timerController) =>

                    Row(
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
            ])));
  }
}
