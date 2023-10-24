
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../util/app_strings.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/images.dart';
import '../../../../../util/text_style.dart';
import '../../../../widgets/confirmation_dialog.dart';
import '../../../history/model/history_model.dart';
import '../../../history/widgets/rider_details.dart';
import '../../../map/controller/map_controller.dart';
import '../../../parcel/widgets/tolltip_widget.dart';
import '../../../payment/payment_screen.dart';
import '../../../ride/widgets/confirmation_trip_dialog.dart';
import '../../../where_to_go/controller/create_trip_controller.dart';
import '../../controller/trip_finish_controller.dart';

class FifthWidget extends StatelessWidget {
    FifthWidget({Key? key}) : super(key: key);

  final controller=Get.put(TripFinishedController());
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return ConfirmationDialog(
                icon: Images.endTrip,
                description: Strings.endThisTripAtYourDestination.tr,
                onYesPressed: () async {
                  Get.back();
                  Get.dialog(
                      const ConfirmationTripDialog(
                        isStartedTrip: false,
                      ),
                      barrierDismissible: false);
                  await Future.delayed(const Duration(seconds: 5));
                  // update(RideState.completeRide);
                  //Get.back();
                  Get.find<MapController>().notifyMapController();
                  Get.off(() => const PaymentScreen());
                },
              );
            });
      },
      child: Column(children: [
        TollTipWidget(title: Strings.tripIsOngoing.tr),
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        Padding(
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
        ),
      GetBuilder<CreateATripController>(
          init: CreateATripController(),
          builder: (controller) => ActivityScreenRiderDetails(
          riderDetails: Driver(
              firstName: controller.orderModel.data?.driver?.firstName??'',
              rate: 5,
              img:  controller.orderModel.data?.driver?.img??'',
              lastName: controller.orderModel.data?.driver?.lastName??'',
              vehicle: controller.orderModel.data?.driver?.vehicle
          ),
        ),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
      ]),
    );
  }
}
