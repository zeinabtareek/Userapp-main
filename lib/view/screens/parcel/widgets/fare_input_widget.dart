import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/controller/create_trip_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../payment/payment_screen.dart';
import '../../payment/widget/review_screen.dart';
import '../../ride/widgets/confirmation_trip_dialog.dart';

class FindDriverCustomBtn2 extends StatelessWidget {
  final String fromPage;
  final bool whoWillPay;

  const FindDriverCustomBtn2(
      {Key? key, required this.fromPage, required this.whoWillPay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return Row(
        children: [
          Expanded(
              child: CustomButton(
            radius: 25,
            buttonText: Get.find<RideController>().selectedCategoryTypeEnum ==
                    RideType.bike
                ? Strings.findRider.tr
                : Get.find<RideController>().selectedCategoryTypeEnum ==
                            RideType.car ||
                        Get.find<RideController>().selectedCategoryTypeEnum ==
                            RideType.luxury
                    ? Strings.findDriver.tr
                    : Strings.findDeliveryMan.tr,
            onPressed: () async {
              if (fromPage == 'ride') {

                Get.find<CreateATripController>().createATrip();
                // Get.find<CreateATripController>().state==ViewState.busy?
                Get.find<RideController>()
                    .updateRideCurrentState(RideState.findingRider);
              //

              } else {
                print('555555');

                ///previous code

                if (Get.find<RideController>().selectedCategoryTypeEnum !=
                    RideType.parcel) {
                  Get.find<RideController>()
                      .updateRideCurrentState(RideState.afterAcceptRider);

                  Get.find<MapController>().notifyMapController();

                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) {
                    print('####first');
                    Get.find<RideController>()
                        .updateRideCurrentState(RideState.otpSent);
                    Get.find<MapController>().notifyMapController();
                  });

                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) async {
                    print('####second');

                    Get.dialog(
                        const ConfirmationTripDialog(
                          isStartedTrip: true,
                        ),
                        barrierDismissible: false);
                    await Future.delayed(const Duration(seconds: 5));
                    print('####third');
                    Get.find<RideController>()
                        .updateRideCurrentState(RideState.ongoingRide);
                    Get.find<MapController>().notifyMapController();
                    Get.back();
                  });

                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) async {
                    print('####forth');
                    Get.dialog(
                        const ConfirmationTripDialog(
                          isStartedTrip: false,
                        ),
                        barrierDismissible: false);
                    await Future.delayed(const Duration(seconds: 2));
                    print('####fifth');
                    Get.find<RideController>()
                        .updateRideCurrentState(RideState.completeRide);
                    //Get.back();
                    Get.find<MapController>().notifyMapController();
                    Get.back();
                  });
                  await Future.delayed(const Duration(seconds: 0))
                      .then((value) async {
                    print('####six');
                    Get.off(() => const PaymentScreen());
                  });
                } else {
                  Get.find<ParcelController>()
                      .updateParcelState(ParcelDeliveryState.acceptRider);

                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) {
                    print('####seven');
                    Get.find<ParcelController>()
                        .updateParcelState(ParcelDeliveryState.otpSent);
                    Get.find<MapController>().notifyMapController();
                  });
                  if (whoWillPay == false) //parcelController.payReceiver
                  {
                    await Future.delayed(const Duration(seconds: 2))
                        .then((value) async {
                      print('####eight');
                      Get.dialog(
                          const ConfirmationTripDialog(
                            //calculation ConfirmationTripDialog
                            isStartedTrip: true,
                          ),
                          barrierDismissible: false);
                      await Future.delayed(const Duration(seconds: 5));
                      Get.find<ParcelController>()
                          .updateParcelState(ParcelDeliveryState.parcelOngoing);
                      Get.find<MapController>().notifyMapController();
                      Get.back();
                    });
                  }

                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) async {
                    print('####nine');
                    Get.dialog(
                        const ConfirmationTripDialog(
                          isStartedTrip: false,
                        ),
                        barrierDismissible: false);
                    await Future.delayed(const Duration(seconds: 2));
                    print('####ten');
                    Get.find<ParcelController>()
                        .updateParcelState(ParcelDeliveryState.parcelComplete);
                    //Get.back();
                    Get.find<MapController>().notifyMapController();
                    Get.back();
                  });
                  await Future.delayed(const Duration(seconds: 0))
                      .then((value) async {
                    print('####eleven');

                    if (whoWillPay == true) //parcelController.payReceiver
                    {
                      Get.off(() => const ReviewScreen());
                    } else if (whoWillPay == false) {
                      Get.off(() => const PaymentScreen());
                    }
                  });
                }
              }
              Get.find<MapController>().notifyMapController();
            },
            fontSize: Dimensions.fontSizeDefault,
          )),
        ],
      );
    });
  }
}

class FindDriverCustomBtn extends StatelessWidget {
  final String fromPage;
  final bool whoWillPay;

  const FindDriverCustomBtn(
      {Key? key, required this.fromPage, required this.whoWillPay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return Row(
        children: [
          Expanded(
              child: CustomButton(
            radius: 25,
            buttonText: Get.find<RideController>().selectedCategoryTypeEnum ==
                    RideType.bike
                ? Strings.findRider.tr
                : Get.find<RideController>().selectedCategoryTypeEnum ==
                            RideType.car ||
                        Get.find<RideController>().selectedCategoryTypeEnum ==
                            RideType.luxury
                    ? Strings.getPrice.tr
                    : Strings.findDeliveryMan.tr,
            onPressed: () async {
              if (fromPage == 'ride') {
                Get.find<RideController>()
                    .updateRideCurrentState(RideState.getPrice);

                // Get.find<RideController>()
                //     .updateRideCurrentState(RideState.findingRider);
              } else {
                print('555555');

                ///previous code

                if (Get.find<RideController>().selectedCategoryTypeEnum !=
                    RideType.parcel) {
                  Get.find<RideController>()
                      .updateRideCurrentState(RideState.getPrice);
                  Get.find<RideController>()
                      .updateRideCurrentState(RideState.afterAcceptRider);

                  Get.find<MapController>().notifyMapController();

                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) {
                    print('####first');
                    Get.find<RideController>()
                        .updateRideCurrentState(RideState.otpSent);
                    Get.find<MapController>().notifyMapController();
                  });

                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) async {
                    print('####second');

                    Get.dialog(
                        const ConfirmationTripDialog(
                          isStartedTrip: true,
                        ),
                        barrierDismissible: false);
                    await Future.delayed(const Duration(seconds: 5));
                    print('####third');
                    Get.find<RideController>()
                        .updateRideCurrentState(RideState.ongoingRide);
                    Get.find<MapController>().notifyMapController();
                    Get.back();
                  });

                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) async {
                    print('####forth');
                    Get.dialog(
                        const ConfirmationTripDialog(
                          isStartedTrip: false,
                        ),
                        barrierDismissible: false);
                    await Future.delayed(const Duration(seconds: 2));
                    print('####fifth');
                    Get.find<RideController>()
                        .updateRideCurrentState(RideState.completeRide);
                    //Get.back();
                    Get.find<MapController>().notifyMapController();
                    Get.back();
                  });
                  await Future.delayed(const Duration(seconds: 0))
                      .then((value) async {
                    print('####six');
                    Get.off(() => const PaymentScreen());
                  });
                } else {
                  Get.find<ParcelController>()
                      .updateParcelState(ParcelDeliveryState.acceptRider);

                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) {
                    print('####seven');
                    Get.find<ParcelController>()
                        .updateParcelState(ParcelDeliveryState.otpSent);
                    Get.find<MapController>().notifyMapController();
                  });
                  if (whoWillPay == false) //parcelController.payReceiver
                  {
                    await Future.delayed(const Duration(seconds: 2))
                        .then((value) async {
                      print('####eight');
                      Get.dialog(
                          const ConfirmationTripDialog(
                            //calculation ConfirmationTripDialog
                            isStartedTrip: true,
                          ),
                          barrierDismissible: false);
                      await Future.delayed(const Duration(seconds: 5));
                      Get.find<ParcelController>()
                          .updateParcelState(ParcelDeliveryState.parcelOngoing);
                      Get.find<MapController>().notifyMapController();
                      Get.back();
                    });
                  }

                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) async {
                    print('####nine');
                    Get.dialog(
                        const ConfirmationTripDialog(
                          isStartedTrip: false,
                        ),
                        barrierDismissible: false);
                    await Future.delayed(const Duration(seconds: 2));
                    print('####ten');
                    Get.find<ParcelController>()
                        .updateParcelState(ParcelDeliveryState.parcelComplete);
                    //Get.back();
                    Get.find<MapController>().notifyMapController();
                    Get.back();
                  });
                  await Future.delayed(const Duration(seconds: 0))
                      .then((value) async {
                    print('####eleven');

                    if (whoWillPay == true) //parcelController.payReceiver
                    {
                      Get.off(() => const ReviewScreen());
                    } else if (whoWillPay == false) {
                      Get.off(() => const PaymentScreen());
                    }
                  });
                }
              }
              Get.find<MapController>().notifyMapController();
            },
            fontSize: Dimensions.fontSizeDefault,
          )),
        ],
      );
    });
  }
}
