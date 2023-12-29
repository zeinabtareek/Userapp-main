import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/confirmation_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_category_card.dart';
import '../../../widgets/custom_text_field.dart';
import '../../chat/models/res/msg_chat_res_model_item.dart';
import '../../history/widgets/rider_details.dart';
import '../../map/controller/map_controller.dart';
import '../../payment/payment_screen.dart';
import '../../ride/controller/ride_controller.dart';
import '../../ride/widgets/confirmation_trip_dialog.dart';
import '../../ride/widgets/estimated_fare_and_distance.dart';
import '../../ride/widgets/rider_details_widget.dart';
import '../../ride/widgets/rise_fare_widget.dart';
import '../../ride/widgets/trip_fare_summery.dart';
import 'contact_widget.dart';
import 'finding_rider_widget.dart';
import 'otp_widget.dart';
import 'route_widget.dart';
import 'tolltip_widget.dart';

class GetPrice extends StatelessWidget {
  String image;
  String title;

  GetPrice({Key? key, required this.image, required this.title})
      : super(key: key);
  //
  // @override
  // Widget build(BuildContext context) {
  //   return GetBuilder<RideController>(builder: (rideController) {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(
  //           horizontal: Dimensions.paddingSizeDefault),
  //      // child: Text('dfff'),
  //       child: Column(
  //         children: [
  //           if (rideController.currentRideState == RideState.initial)
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 // RideCategoryWidget(),
  //                 // const SizedBox(
  //                 //   height: Dimensions.paddingSizeDefault,
  //                 // ),
  //
  //                 Text('your selected car type is : $title',style: textRegular.copyWith(
  //                     color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600),),
  //                 K.sizedBoxH0,
  //
  //                 Center(
  //                   child: GestureDetector(
  //                     onTap: () {},
  //                     child: CustomCategoryCard(
  //                       height: MediaQuery.of(context).size.height/7,
  //                       image: image,
  //                       title: title,
  //                       isClicked: false,
  //                     ),
  //                   ),
  //                 ),
  //                 K.sizedBoxH0,
  //                 RouteWidget(),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //                 const TripFareSummery(),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //                 CustomTextField(
  //                   prefix: false,
  //                   borderRadius: Dimensions.radiusLarge,
  //                   hintText: Strings.addNote.tr,
  //                 ),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //                 rideController.isBiddingOn
  //                     ?   const FindDriverCustomBtn(fromPage: Strings.ride, whoWillPay: true,)
  //                     : CustomButton(
  //                     buttonText: Strings.findRider.tr,
  //                     onPressed: () {
  //                       rideController
  //                           .updateRideCurrentState(RideState.findingRider);
  //                     }),
  //                 K.sizedBoxH0,
  //                 K.sizedBoxH0,
  //               ],
  //             ),
  //           if (rideController.currentRideState == RideState.riseFare)
  //             Column(children: [
  //               TollTipWidget(title: Strings.tripDetails.tr),
  //               K.sizedBoxH0,
  //               RouteWidget(),
  //               const SizedBox(
  //                 height: Dimensions.paddingSizeDefault,
  //               ),
  //               const RiseFareWidget(fromPage: Strings.ride),
  //               K.sizedBoxH0,
  //             ]),
  //           if (rideController.currentRideState == RideState.findingRider)
  //             Column(children: const [
  //               FindingRiderWidget(fromPage: Strings.ride),
  //             ]),
  //           if (rideController.currentRideState == RideState.acceptingRider)
  //             const Column(children: [
  //               RiderDetailsWidget(
  //                 fromNotification: false,
  //               ),
  //               SizedBox(
  //                 height: Dimensions.paddingSizeDefault,
  //               ),
  //               RiseFareWidget(fromPage: Strings.ride),
  //               SizedBox(
  //                 height: Dimensions.paddingSizeDefault,
  //               ),
  //             ]),
  //           if (rideController.currentRideState == RideState.afterAcceptRider)
  //             GestureDetector(
  //               onTap: () => Get.find<RideController>()
  //                   .updateRideCurrentState(RideState.otpSent),
  //               child: Column(children: [
  //                 TollTipWidget(title: Strings.riderDetails.tr),
  //                 K.sizedBoxH0,
  //
  //                 ContactWidget(),
  //                 K.sizedBoxH0,
  //
  //                 // ActivityScreenRiderDetails(
  //                 // riderDetails: RiderDetails(
  //                 //     name: "mostafizur",
  //                 //     vehicleNumber: "DH-1234",
  //                 //     rating: 5,
  //                 //     vehicleType: "bike",
  //                 //     vehicleName: "Pulser-150",
  //                 //     image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
  //                 // ),
  //                 // ),
  //                 K.sizedBoxH0,
  //
  //                 const EstimatedFareAndDistance(),
  //
  //                 K.sizedBoxH0,
  //
  //                 RouteWidget(),
  //                 K.sizedBoxH0,
  //
  //                 CustomButton(
  //                   buttonText: Strings.cancelRide.tr,
  //                   transparent: true,
  //                   borderWidth: 1,
  //                   showBorder: true,
  //                   radius: Dimensions.paddingSizeSmall,
  //                   borderColor: Theme.of(Get.context!).primaryColor,
  //                   onPressed: () {
  //                     rideController.updateRideCurrentState(RideState.initial);
  //                     Get.find<MapController>().notifyMapController();
  //                   },
  //                 )
  //               ]),
  //             ),
  //           if (rideController.currentRideState == RideState.otpSent)
  //             GestureDetector(
  //               onTap: () async {
  //                 Get.dialog(
  //                     const ConfirmationTripDialog(
  //                       isStartedTrip: true,
  //                     ),
  //                     barrierDismissible: false);
  //                 await Future.delayed(const Duration(seconds: 5));
  //                 rideController.updateRideCurrentState(RideState.ongoingRide);
  //                 Get.find<MapController>().notifyMapController();
  //                 Get.back();
  //               },
  //               child: Column(children: [
  //                 TollTipWidget(title: Strings.riderDetails.tr),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //                 const OtpWidget(
  //                   fromPage: Strings.bike,
  //                 ),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //                 ContactWidget(),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //                 ActivityScreenRiderDetails(
  //                   riderDetails: Driver(
  //                       firstName: "mostafizur",
  //                       rate: 5,
  //                       img:
  //                       "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
  //                       lastName: "smith"),
  //
  //                   // RiderDetails(
  //                   //     f: "mostafizur",
  //                   //     vehicleNumber: "DH-1234",
  //                   //     rating: 5,
  //                   //     vehicleType: "bike",
  //                   //     vehicleName: "Pulser-150",
  //                   //     image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
  //                   // ),
  //                 ),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //                 const EstimatedFareAndDistance(),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //                 RouteWidget(),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //                 CustomButton(
  //                   buttonText: Strings.cancelRide.tr,
  //                   transparent: true,
  //                   borderWidth: 1,
  //                   showBorder: true,
  //                   radius: Dimensions.paddingSizeSmall,
  //                   borderColor: Theme.of(Get.context!).primaryColor,
  //                   onPressed: () {
  //                     rideController.updateRideCurrentState(RideState.initial);
  //                     Get.find<MapController>().notifyMapController();
  //                   },
  //                 )
  //               ]),
  //             ),
  //           if (rideController.currentRideState == RideState.ongoingRide)
  //             GestureDetector(
  //               onTap: () {
  //                 showDialog(
  //                     context: context,
  //                     builder: (_) {
  //                       return ConfirmationDialog(
  //                         icon: Images.endTrip,
  //                         description: Strings.endThisTripAtYourDestination.tr,
  //                         onYesPressed: () async {
  //                           Get.back();
  //                           Get.dialog(
  //                               const ConfirmationTripDialog(
  //                                 isStartedTrip: false,
  //                               ),
  //                               barrierDismissible: false);
  //                           await Future.delayed(const Duration(seconds: 5));
  //                           rideController
  //                               .updateRideCurrentState(RideState.completeRide);
  //                           //Get.back();
  //                           Get.find<MapController>().notifyMapController();
  //                           Get.off(() => const PaymentScreen());
  //                         },
  //                       );
  //                     });
  //               },
  //               child: Column(children: [
  //                 TollTipWidget(title: Strings.tripIsOngoing.tr),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(
  //                       vertical: Dimensions.paddingSizeDefault),
  //                   child: Text.rich(
  //                     TextSpan(
  //                       style: textRegular.copyWith(
  //                           fontSize: Dimensions.fontSizeLarge,
  //                           color: Theme.of(context)
  //                               .textTheme
  //                               .bodyMedium!
  //                               .color!
  //                               .withOpacity(0.8)),
  //                       children: [
  //                         TextSpan(
  //                             text: Strings.theCarJustArrivedAt.tr,
  //                             style: textRegular.copyWith(
  //                                 fontSize: Dimensions.fontSizeDefault)),
  //                         TextSpan(text: " ".tr),
  //                         TextSpan(
  //                             text: Strings.yourDestination.tr,
  //                             style: textMedium.copyWith(
  //                                 fontSize: Dimensions.fontSizeDefault,
  //                                 color: Theme.of(context).primaryColor)),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 ActivityScreenRiderDetails(
  //                   riderDetails: Driver(
  //                       firstName: "mostafizur",
  //                       rate: 5,
  //                       img:
  //                       "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
  //                       lastName: "smith"),
  //                 ),
  //                 const SizedBox(
  //                   height: Dimensions.paddingSizeDefault,
  //                 ),
  //               ]),
  //             )
  //         ],
  //       ),
  //     );
  //   });
  // }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (rideController.currentRideState == RideState.initial)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'your selected car type is : $title',
                    style: textRegular.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  K.sizedBoxH0,
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: CustomCategoryCard(
                        height: MediaQuery.of(context).size.height / 7,
                        image: image,
                        title: title,
                        isClicked: false,
                      ),
                    ),
                  ),
                  K.sizedBoxH0,
                  RouteWidget(),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  TripFareSummery(
                    paymentMethod: 'cash',
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  CustomTextField(
                    prefix: false,
                    borderRadius: Dimensions.radiusLarge,
                    hintText: Strings.addNote.tr,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  rideController.isBiddingOn
                      ?

                      ///TODO :this code zeinab removed it to apply the getPrice screen
                      //
                      // const FindDriverCustomBtn(fromPage: Strings.ride, whoWillPay: true,)

                      CustomButton(
                          buttonText: Strings.getPrice.tr,
                          radius: 50,
                          onPressed: () {
                            print('object');
                            rideController.updateRideCurrentState(
                                RideState.acceptingRider);
                          })
                      : CustomButton(
                          buttonText: Strings.findRider.tr,
                          onPressed: () {
                            rideController
                                .updateRideCurrentState(RideState.findingRider);
                          }),
                  K.sizedBoxH0,
                  K.sizedBoxH0,
                ],
              ),
            if (rideController.currentRideState == RideState.riseFare)
              Column(children: [
                TollTipWidget(title: Strings.tripDetails.tr),
                K.sizedBoxH0,
                RouteWidget(),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                const RiseFareWidget(fromPage: Strings.ride),
                K.sizedBoxH0,
              ]),
            if (rideController.currentRideState == RideState.findingRider)

              ///
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///hna kda zeinab

                    FindingRiderWidget(fromPage: Strings.ride),
                  ]),
            if (rideController.currentRideState == RideState.getPrice)

              ///
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GetPrice(
                      image: Images.car,
                      title: 'Suv.',
                    ),
                  ]),
            if (rideController.currentRideState == RideState.acceptingRider)
              const Column(children: [
                RiderDetailsWidget(
                  fromNotification: false,
                ),
                SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                RiseFareWidget(fromPage: Strings.ride),
                SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
              ]),
            if (rideController.currentRideState == RideState.afterAcceptRider)
              GestureDetector(
                onTap: () => Get.find<RideController>()
                    .updateRideCurrentState(RideState.otpSent),
                child: Column(children: [
                  TollTipWidget(title: Strings.riderDetails.tr),
                  K.sizedBoxH0,

                  ContactWidget(),
                  K.sizedBoxH0,

                  // ActivityScreenRiderDetails(
                  // riderDetails: RiderDetails(
                  //     name: "mostafizur",
                  //     vehicleNumber: "DH-1234",
                  //     rating: 5,
                  //     vehicleType: "bike",
                  //     vehicleName: "Pulser-150",
                  //     image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
                  // ),
                  // ),
                  K.sizedBoxH0,

                  EstimatedFareAndDistance(),

                  K.sizedBoxH0,

                  RouteWidget(),
                  K.sizedBoxH0,

                  CustomButton(
                    buttonText: Strings.cancelRide.tr,
                    transparent: true,
                    borderWidth: 1,
                    showBorder: true,
                    radius: Dimensions.paddingSizeSmall,
                    borderColor: Theme.of(Get.context!).primaryColor,
                    onPressed: () {
                      rideController.updateRideCurrentState(RideState.initial);
                      Get.find<MapController>().notifyMapController();
                    },
                  )
                ]),
              ),
            if (rideController.currentRideState == RideState.otpSent)
              GestureDetector(
                onTap: () async {
                  Get.dialog(
                      const ConfirmationTripDialog(
                        isStartedTrip: true,
                      ),
                      barrierDismissible: false);
                  await Future.delayed(const Duration(seconds: 5));
                  rideController.updateRideCurrentState(RideState.ongoingRide);
                  Get.find<MapController>().notifyMapController();
                  Get.back();
                },
                child: Column(children: [
                  TollTipWidget(title: Strings.riderDetails.tr),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  const OtpWidget(
                    fromPage: Strings.bike,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  ContactWidget(),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),

                  ///Zeinab Uncomment this
                  ActivityScreenRiderDetails(
                    riderDetails: Driverd(
                        firstName: "mostafizur",
                        rate: 5,
                        img:
                            "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
                        lastName: "smith"),

                    ///till here
                    // RiderDetails(
                    //     f: "mostafizur",
                    //     vehicleNumber: "DH-1234",
                    //     rating: 5,
                    //     vehicleType: "bike",
                    //     vehicleName: "Pulser-150",
                    //     image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
                    // ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  EstimatedFareAndDistance(),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  RouteWidget(),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  CustomButton(
                    buttonText: Strings.cancelRide.tr,
                    transparent: true,
                    borderWidth: 1,
                    showBorder: true,
                    radius: Dimensions.paddingSizeSmall,
                    borderColor: Theme.of(Get.context!).primaryColor,
                    onPressed: () {
                      rideController.updateRideCurrentState(RideState.initial);
                      Get.find<MapController>().notifyMapController();
                    },
                  )
                ]),
              ),
            if (rideController.currentRideState == RideState.ongoingRide)
              GestureDetector(
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
                            rideController
                                .updateRideCurrentState(RideState.completeRide);
                            //Get.back();
                            Get.find<MapController>().notifyMapController();
                            Get.off(() => PaymentScreen());
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
                  ActivityScreenRiderDetails(
                    riderDetails: Driverd(
                        firstName: "mostafizur",
                        rate: 5,
                        img:
                            "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
                        lastName: "smith"),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                ]),
              )
          ],
        ),
      );
    });
  }
}
