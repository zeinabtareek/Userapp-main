import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/driver_request_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/tolltip_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../../../util/app_style.dart';
import '../../payment/payment_screen.dart';
import '../../ride/widgets/confirmation_trip_dialog.dart';

class FindingRiderWidget extends StatefulWidget {
  final String fromPage;

  const FindingRiderWidget({Key? key, required this.fromPage})
      : super(key: key);

  @override
  State<FindingRiderWidget> createState() => _FindingRiderWidgetState();
}

class _FindingRiderWidgetState extends State<FindingRiderWidget> {
  bool showRiderRequest = false;
  double percent = 0.0;

  @override
  void initState() {
    Timer? timer;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      setState(() {
        percent += 50;
        if (percent >= 100) {
          timer!.cancel();
          showRiderRequest = true;
        }
      });
    });

    handelState();

    super.initState();
  }

  void handelState() {
    if (Get.find<RideController>().isBiddingOn) {
      Future.delayed(const Duration(seconds: 3), () async {
        print('object is called');

        // showGeneralDialog(
        //   context: context,
        //   barrierDismissible: true,
        //   transitionDuration: const Duration(milliseconds: 500),
        //   barrierLabel: MaterialLocalizations.of(context).dialogLabel,
        //   barrierColor: Colors.black.withOpacity(0.5),
        //   pageBuilder: (context, _, __) {
        //     return DriverRideRequestDialog(
        //       fromPage: widget.fromPage,
        //     );
        //   },
        //   transitionBuilder: (context, animation, secondaryAnimation, child) {
        //     return SlideTransition(
        //       position: CurvedAnimation(
        //         parent: animation,
        //         curve: Curves.easeOut,
        //       ).drive(Tween<Offset>(
        //         begin: const Offset(0, -1.0),
        //         end: Offset.zero,
        //       )),
        //       child: child,
        //     );
        //   },
        // );
        ///
        if (Get.find<RideController>().selectedCategoryTypeEnum !=
            RideType.parcel) {
          Get.find<RideController>()
              .updateRideCurrentState(RideState.afterAcceptRider);
          Get.find<MapController>().notifyMapController();
          await Future.delayed(const Duration(seconds: 2)).then((value) {
            Get.find<RideController>()
                .updateRideCurrentState(RideState.otpSent);
            Get.find<MapController>().notifyMapController();
          });

          await Future.delayed(const Duration(seconds: 2)).then((value) async {
            Get.dialog(
                const ConfirmationTripDialog(
                  isStartedTrip: true,
                ),
                barrierDismissible: false);
            await Future.delayed(const Duration(seconds: 5));
            Get.find<RideController>()
                .updateRideCurrentState(RideState.ongoingRide);
            Get.find<MapController>().notifyMapController();
            Get.back();
          });

          await Future.delayed(const Duration(seconds: 2)).then((value) async {
            Get.dialog(
                const ConfirmationTripDialog(
                  isStartedTrip: false,
                ),
                barrierDismissible: false);
            await Future.delayed(const Duration(seconds: 2));
            Get.find<RideController>()
                .updateRideCurrentState(RideState.completeRide);
            //Get.back();
            Get.find<MapController>().notifyMapController();
            Get.back();
          });
          await Future.delayed(const Duration(seconds: 0)).then((value) async {
            Get.offAll(() => const PaymentScreen());
          });
        } else {
          Get.find<ParcelController>()
              .updateParcelState(ParcelDeliveryState.acceptRider);
          Get.find<MapController>().notifyMapController();
          Future.delayed(const Duration(seconds: 2)).then((value) {
            Get.find<ParcelController>()
                .updateParcelState(ParcelDeliveryState.otpSent);
            Get.find<MapController>().notifyMapController();
          });

          Future.delayed(const Duration(seconds: 2)).then((value) async {
            Get.dialog(
                const ConfirmationTripDialog(
                  isStartedTrip: true,
                ),
                barrierDismissible: false);
            await Future.delayed(const Duration(seconds: 5));
            Get.find<ParcelController>()
                .updateParcelState(ParcelDeliveryState.parcelOngoing);
            Get.find<MapController>().notifyMapController();
            Get.back();
          });

          Future.delayed(const Duration(seconds: 2)).then((value) async {
            Get.dialog(
                const ConfirmationTripDialog(
                  isStartedTrip: false,
                ),
                barrierDismissible: false);
            await Future.delayed(const Duration(seconds: 2));
            Get.find<ParcelController>()
                .updateParcelState(ParcelDeliveryState.parcelComplete);
            //Get.back();
            Get.find<MapController>().notifyMapController();
            Get.back();
          });
          Future.delayed(const Duration(seconds: 0)).then((value) async {
            Get.offAll(() => const PaymentScreen());
          });
        }

        ///

        // } else {
        // Get.find<ParcelController>()
        //     .updateParcelState(ParcelDeliveryState.acceptRider);
        //
        // await Future.delayed(const Duration(seconds: 2))
        //     .then((value) {
        // Get.find<ParcelController>()
        //     .updateParcelState(ParcelDeliveryState.otpSent);
        // Get.find<MapController>().notifyMapController();
        // });
        //
        // await Future.delayed(const Duration(seconds: 2))
        //     .then((value) async {
        // Get.dialog(
        // const ConfirmationTripDialog(
        // isStartedTrip: true,
        // ),
        // barrierDismissible: false);
        // await Future.delayed(const Duration(seconds: 5));
        // Get.find<ParcelController>()
        //     .updateParcelState(ParcelDeliveryState.parcelOngoing);
        // Get.find<MapController>().notifyMapController();
        // Get.back();
        // });
        //
        // await Future.delayed(const Duration(seconds: 2))
        //     .then((value) async {
        // Get.dialog(
        // const ConfirmationTripDialog(
        // isStartedTrip: false,
        // ),
        // barrierDismissible: false);
        // await Future.delayed(const Duration(seconds: 2));
        // Get.find<ParcelController>()
        //     .updateParcelState(ParcelDeliveryState.parcelComplete);
        // //Get.back();
        // Get.find<MapController>().notifyMapController();
        // Get.back();
        // });
        // await Future.delayed(const Duration(seconds: 0))
        //     .then((value) async {
        // Get.offAll(() => const PaymentScreen());
        // });
        // }
        //
      });
      // }
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        if (Get.find<RideController>().currentRideState != RideType.parcel &&
            widget.fromPage == 'ride') {
          Get.find<RideController>()
              .updateRideCurrentState(RideState.afterAcceptRider);
        } else {}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return GetBuilder<ParcelController>(builder: (parcelController) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              TollTipWidget(
                  title: rideController.selectedCategoryTypeEnum ==
                          RideType.parcel
                      ? 'deliveryman'
                      : rideController.selectedCategoryTypeEnum == RideType.bike
                          ? "rider"
                          : "drivccer"),
              K.sizedBoxH0,
              K.sizedBoxH0,
              LinearPercentIndicator(
                padding: EdgeInsets.zero,
                animation: true,
                animationDuration: 1000,
                lineHeight: 4.0,
                percent: percent / 100,
                progressColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).hintColor,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraLarge),
                  child: Image.asset(Images.findinDeliveryman, width: 70)),
              Text(
                  rideController.selectedCategoryTypeEnum == RideType.parcel
                      ? 'finding_deliveryman'.tr
                      : rideController.selectedCategoryTypeEnum == RideType.bike
                          ? "finding_rider".tr
                          : "finding_driver".tr,
                  style: textMedium.copyWith(
                    fontSize: Dimensions.fontSizeOverLarge,
                    color: Theme.of(context).primaryColor,
                  )),
              const SizedBox(
                height: Dimensions.paddingSizeLarge * 2,
              ),
              CustomButton(
                buttonText: 'cancel_searching'.tr,
                radius: Dimensions.radiusOverLarge,
                transparent: true,
                borderWidth: 1,
                showBorder: true,
                // radius: Dimensions.paddingSizeSmall,
                borderColor: Theme.of(Get.context!).primaryColor,
                onPressed: () {
                  if (Get.find<RideController>().currentRideState !=
                          RideType.parcel &&
                      widget.fromPage == 'ride') {
                    rideController.updateRideCurrentState(RideState.initial);
                  } else {
                    Get.find<ParcelController>()
                        .updateParcelState(ParcelDeliveryState.initial);
                  }

                  Get.find<MapController>().notifyMapController();
                },
              )
            ],
          ),
        );
      });
    });
  }
}
