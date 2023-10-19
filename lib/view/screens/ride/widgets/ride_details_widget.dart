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
import '../../history/model/history_model.dart';
import '../../history/widgets/rider_details.dart';
import '../../map/controller/map_controller.dart';
import '../../parcel/widgets/contact_widget.dart';
import '../../parcel/widgets/finding_rider_widget.dart';
import '../../parcel/widgets/otp_widget.dart';
import '../../parcel/widgets/route_widget.dart';
import '../../parcel/widgets/tolltip_widget.dart';
import '../../payment/payment_screen.dart';
import '../../where_to_go/controller/create_trip_controller.dart';
import '../controller/ride_controller.dart';
import 'confirmation_trip_dialog.dart';
import 'estimated_fare_and_distance.dart';
import 'get_price_widget.dart';
import 'rider_details_widget.dart';
import 'rise_fare_widget.dart';
import 'trip_fare_summery.dart';

class BikeRideDetailsWidgets extends StatelessWidget {
  String image;
  String title;

  BikeRideDetailsWidgets({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
       builder: (rideController) {
        print(" state ::: ${rideController.currentRideState} ");
        // print(" mounted  BikeRideDetailsWidgets  ");
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: getshetWidget(
              rideController.currentRideState,
              context,
              title,
              image,
              (state) => rideController.updateRideCurrentState(state),
              rideController.isBiddingOn),
        );
      },
    );
  }
}

Widget getshetWidget(RideState state, BuildContext context, String title,
    String image, Function(RideState state) update, bool isBiddingOn) {
  if (state == RideState.initial) {
    return
      GetBuilder<RideController>(//rideController.selectedPackage.value?
        init: RideController(rideRepo: Get.find()),
          builder: (controller)=>

      Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'your selected car type is : ${controller.selectedSubPackage.value!.categoryTitle}',
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
        const TripFareSummery(),
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        CustomTextField(
          prefix: false,
          controller: controller.noteController,
          borderRadius: Dimensions.radiusLarge,
          hintText: Strings.addNote.tr,
        ),
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        isBiddingOn
            ?

            ///TODO :this code zeinab removed it to apply the getPrice screen
            //
            // const FindDriverCustomBtn(fromPage: Strings.ride, whoWillPay: true,)

            CustomButton(
                buttonText: Strings.go.tr,
                // buttonText: Strings.getPrice.tr,
                radius: 50,
                onPressed: () async{
                  // Get.to(()=> RideExpendableBottomSheet(isGetPrice: true,));

                  update(RideState.getPrice);
                  await controller.getOrderPrice();
                  controller.update();
                  // rideController
                  //     .updateRideCurrentState(RideState.acceptingRider);


                })
            : CustomButton(
                buttonText: Strings.findRider.tr,
                onPressed: () {
                  update(RideState.findingRider);
                  // rideController.notifyChildrens();
                }),
        K.sizedBoxH0,
        K.sizedBoxH0,
      ],
    )
    )
          ;
  } else if (state == RideState.riseFare) {
    return Column(children: [
      TollTipWidget(title: Strings.tripDetails.tr),
      K.sizedBoxH0,
      RouteWidget(),
      const SizedBox(
        height: Dimensions.paddingSizeDefault,
      ),
      const RiseFareWidget(fromPage: Strings.ride),
      K.sizedBoxH0,
    ]);
  } else if (state == RideState.findingRider)

  ///
  {
    return Column(
      children: [
        // Flexible(child: Container(color: Colors.transparent,))
          FindingRiderWidget(fromPage: Strings.ride),
      ],
    );
  } else if (state == RideState.getPrice) {
    return

        ///
        Column(children: [
      GetPriceWidget(
        image: Images.car,
        title: 'Suv.',
      ),
    ]);
  } else if (state == RideState.acceptingRider) {
    return const Column(children: [
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
    ]);
  } else if (state == RideState.afterAcceptRider) {
    return GestureDetector(
      onTap: () =>
          Get.find<RideController>().updateRideCurrentState(RideState.otpSent),
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

        const EstimatedFareAndDistance(),

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
            update(RideState.initial);
            Get.find<MapController>().notifyMapController();
          },
        )
      ]),
    );
  } else if (state == RideState.otpSent) {
    return GestureDetector(
      onTap: () async {
        Get.dialog(
            const ConfirmationTripDialog(
              isStartedTrip: true,
            ),
            barrierDismissible: false);
        await Future.delayed(const Duration(seconds: 5));
        update(RideState.ongoingRide);
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
        ActivityScreenRiderDetails(
          riderDetails: Driver(
              firstName: "mostafizur",
              rate: 5,
              img:
                  "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
              lastName: "smith"),

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
        const EstimatedFareAndDistance(),
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
            update(RideState.initial);
            Get.find<MapController>().notifyMapController();
          },
        )
      ]),
    );
  } else if (state == RideState.ongoingRide) {
    return GestureDetector(
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
                  update(RideState.completeRide);
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
        ActivityScreenRiderDetails(
          riderDetails: Driver(
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
    );
  } else {
    return Container();
  }
// }
//   @override
//   Widget build(BuildContext context) {
//     return  GetBuilder<RideController>(builder: (rideController){
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
//         child: Column(children:  [
//
//       //     if(rideController.currentRideState == RideState.initial)
//       //       Column(children:  [
//       //           // RideCategoryWidget(),
//       // Text('your selected car type is : $title',style: textRegular.copyWith(
//       //                 color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600),),
//       //             K.sizedBoxH0,
//       //
//       //             Center(
//       //               child: GestureDetector(
//       //                 onTap: () {},
//       //                 child: CustomCategoryCard(
//       //                   height: MediaQuery.of(context).size.height/7,
//       //                   image: image,
//       //                   title: title,
//       //                   isClicked: false,
//       //                 ),
//       //               ),
//       //             ),
//       //         const SizedBox(height: Dimensions.paddingSizeDefault,),
//       //
//       //           RouteWidget(),
//       //         const SizedBox(height: Dimensions.paddingSizeDefault,),
//       //
//       //         const TripFareSummery(),
//       //         const SizedBox(height: Dimensions.paddingSizeDefault,),
//       //
//       //         CustomTextField(
//       //           prefix: false,
//       //           borderRadius: Dimensions.radiusExtraLarge,
//       //           hintText: "add_note".tr,
//       //         ),
//       //         const SizedBox(height: Dimensions.paddingSizeDefault,),
//       //
//       //         rideController.isBiddingOn ?
//       //         FindDriverCustomBtn(fromPage: 'ride', whoWillPay: true,):
//       //         CustomButton(
//       //             // buttonText: "get price".tr, onPressed: (){
//       //             buttonText: "find_rider".tr, onPressed: (){
//       //           // rideController.updateRideCurrentState(RideState.getPrice);
//       //           rideController.updateRideCurrentState(RideState.findingRider);
//       //         }),
//       //       ],),
//       //
// ///%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//           if (rideController.currentRideState == RideState.initial)
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('your selected car type is : $title',style: textRegular.copyWith(
//                       color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600),),
//                   K.sizedBoxH0,
//
//                   Center(
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: CustomCategoryCard(
//                         height: MediaQuery.of(context).size.height/7,
//                         image: image,
//                         title: title,
//                         isClicked: false,
//                       ),
//                     ),
//                   ),
//                   K.sizedBoxH0,
//                   RouteWidget(),
//                   const SizedBox(
//                     height: Dimensions.paddingSizeDefault,
//                   ),
//                   const TripFareSummery(),
//                   const SizedBox(
//                     height: Dimensions.paddingSizeDefault,
//                   ),
//                   CustomTextField(
//                     prefix: false,
//                     borderRadius: Dimensions.radiusLarge,
//                     hintText: Strings.addNote.tr,
//                   ),
//                   const SizedBox(
//                     height: Dimensions.paddingSizeDefault,
//                   ),
//                   rideController.isBiddingOn
//                       ?
//                   ///TODO :this code zeinab removed it to apply the getPrice screen
//                   //
//                   const FindDriverCustomBtn(fromPage: Strings.ride, whoWillPay: true,)
//
//       //             CustomButton(
//       //             buttonText: Strings.getPrice.tr,
//       // radius: 50,
//       // onPressed: () {
//       //   // Get.to(()=> RideExpendableBottomSheet(isGetPrice: true,));
//       // rideController
//       //     .updateRideCurrentState(RideState.getPrice);
//       // // rideController
//       // //     .updateRideCurrentState(RideState.acceptingRider);
//       // })
//
//
//                       :
//
//                   CustomButton(
//                           buttonText: Strings.findRider.tr,
//                           onPressed: () {
//                            rideController
//                                 .updateRideCurrentState(RideState.findingRider);
//                           }),
//                   K.sizedBoxH0,
//                   K.sizedBoxH0,
//                 ],
//               ),
//           if(rideController.currentRideState == RideState.riseFare)
//             Column(children: [
//               TollTipWidget(title: 'trip_details'.tr),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 RouteWidget(),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               const RiseFareWidget(fromPage: 'ride',),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//             ]),
//
//
//
//           if(rideController.currentRideState == RideState.getPrice)
//             Column(children:   [
//               GetPriceWidget(  image: Images.car, title: 'dd',),
//               // GetPriceWidget(fromPage: 'ride', image: Images.car, title: 'dd',),
//               // FindingRiderWidget(fromPage: 'ride',),
//             ]),
//    if(rideController.currentRideState == RideState.findingRider)
//             Column(children: const [
//               FindingRiderWidget(fromPage: 'ride',),
//             ]),
//
//
//
//           if(rideController.currentRideState == RideState.acceptingRider)
//             Column(children: const [
//               RiderDetailsWidget(fromNotification: false,),
//               SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               RiseFareWidget(fromPage: 'ride',),
//               SizedBox(height: Dimensions.paddingSizeDefault,),
//             ]),
//
//
//           if(rideController.currentRideState == RideState.afterAcceptRider)
//             GestureDetector(
//               onTap: ()=> Get.find<RideController>().updateRideCurrentState(RideState.otpSent),
//               child: Column(children: [
//                 TollTipWidget(title: 'rider_details'.tr),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 ContactWidget(),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 // ActivityScreenRiderDetails(
//                 //   riderDetails: RiderDetails(
//                 //       name: "mostafizur",
//                 //       vehicleNumber: "DH-1234",
//                 //       rating: 5,
//                 //       vehicleType: "bike",
//                 //       vehicleName: "Pulser-150",
//                 //       image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
//                 //   ),
//                 // ),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 const EstimatedFareAndDistance(),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                   RouteWidget(),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 CustomButton(buttonText: 'cancel_ride'.tr,
//                   transparent: true,
//                   borderWidth: 1,
//                   showBorder: true,
//                   radius: Dimensions.paddingSizeSmall,
//                   borderColor: Theme.of(Get.context!).primaryColor,
//                   onPressed: (){
//                     rideController.updateRideCurrentState(RideState.initial);
//                     Get.find<MapController>().notifyMapController();
//                   },
//                 )
//               ]),
//             ),
//
//           if(rideController.currentRideState == RideState.otpSent)
//             GestureDetector(
//               onTap: () async {
//                 Get.dialog(const ConfirmationTripDialog(isStartedTrip: true,), barrierDismissible: false);
//                 await Future.delayed( const Duration(seconds: 5));
//                 rideController.updateRideCurrentState(RideState.ongoingRide);
//                 Get.find<MapController>().notifyMapController();
//                 Get.back();
//
//               },
//               child: Column(children: [
//                 TollTipWidget(title: 'rider_details'.tr),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 const OtpWidget(fromPage: 'bike',),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 ContactWidget(),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 // ActivityScreenRiderDetails(
//                 //   riderDetails: RiderDetails(
//                 //       name: "mostafizur",
//                 //       vehicleNumber: "DH-1234",
//                 //       rating: 5,
//                 //       vehicleType: "bike",
//                 //       vehicleName: "Pulser-150",
//                 //       image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
//                 //   ),
//                 // ),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 const EstimatedFareAndDistance(),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                   RouteWidget(),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//                 CustomButton(buttonText: 'cancel_ride'.tr,
//                   transparent: true,
//                   borderWidth: 1,
//                   showBorder: true,
//                   radius: Dimensions.paddingSizeSmall,
//                   borderColor: Theme.of(Get.context!).primaryColor,
//                   onPressed: (){
//                     rideController.updateRideCurrentState(RideState.initial);
//                     Get.find<MapController>().notifyMapController();
//                   },
//                 )
//               ]),
//             ),
//
//           if(rideController.currentRideState == RideState.ongoingRide)
//             GestureDetector(
//               onTap: () {
//                 showDialog(context: context, builder: (_){
//                   return ConfirmationDialog(icon: Images.endTrip,
//                     description: 'end_this_trip_at_your_destination'.tr, onYesPressed: () async {
//                       Get.back();
//                       Get.dialog(const ConfirmationTripDialog(isStartedTrip: false,), barrierDismissible: false);
//                       await Future.delayed( const Duration(seconds: 5));
//                       rideController.updateRideCurrentState(RideState.completeRide);
//                       //Get.back();
//                       Get.find<MapController>().notifyMapController();
//                       Get.off(()=>const PaymentScreen());
//                     },);
//                 });
//               },
//               child: Column(children: [
//                 TollTipWidget(title: 'trip_is_ongoing'.tr),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
//                   child: Text.rich(TextSpan(
//                     style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
//                         color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)
//                     ),
//                     children:  [
//                       TextSpan(text: "the_car_just_arrived_at".tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
//                       TextSpan(text: " ".tr),
//                       TextSpan(text: "your_destination".tr,style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor)),
//                     ],
//                   ),
//                   ),
//                 ),
//
//                 // ActivityScreenRiderDetails(
//                 //   riderDetails: RiderDetails(
//                 //       name: "mostafizur",
//                 //       vehicleNumber: "DH-1234",
//                 //       rating: 5,
//                 //       vehicleType: "bike",
//                 //       vehicleName: "Pulser-150",
//                 //       image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
//                 //   ),
//                 // ),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//               ]),
//             )
//         ],
//         ),
//       );
//     });
//   }
}
