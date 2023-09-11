import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/history_model.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/rider_details.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/contact_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/fare_input_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/finding_rider_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/otp_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/tolltip_widget.dart';
import 'package:ride_sharing_user_app/view/screens/payment/payment_screen.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/confirmation_trip_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/estimated_fare_and_distance.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/ride_category.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/rider_details_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/rise_fare_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/trip_fare_summery.dart';
import 'package:ride_sharing_user_app/view/widgets/confirmation_dialog.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';

class BikeRideDetailsWidgets extends StatelessWidget {
  const BikeRideDetailsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<RideController>(builder: (rideController){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: Column(children:  [

          if(rideController.currentRideState == RideState.initial)
            Column(children:  [
              const RideCategoryWidget(),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              const RouteWidget(),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              const TripFareSummery(),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              CustomTextField(
                prefix: false,
                borderRadius: Dimensions.radiusSmall,
                hintText: Strings.addNote.tr,
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              rideController.isBiddingOn ? const FareInputWidget(fromPage:  Strings.ride): CustomButton(
                buttonText: Strings.findRider.tr, onPressed: (){
                  rideController.updateRideCurrentState(RideState.findingRider);
              }),
              K.sizedBoxH0,
              K.sizedBoxH0,
            ],),



          if(rideController.currentRideState == RideState.riseFare)
            Column(children: [
              TollTipWidget(title: Strings.tripDetails.tr),
              K.sizedBoxH0,

              const RouteWidget(),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              const RiseFareWidget(fromPage: Strings.ride),
              K.sizedBoxH0,

            ]),



          if(rideController.currentRideState == RideState.findingRider)
            Column(children: const [
              FindingRiderWidget(fromPage: Strings.ride),
            ]),



          if(rideController.currentRideState == RideState.acceptingRider)
            const Column(children: [
              RiderDetailsWidget(fromNotification: false,),
              SizedBox(height: Dimensions.paddingSizeDefault,),

               RiseFareWidget(fromPage: Strings.ride),
               SizedBox(height: Dimensions.paddingSizeDefault,),
            ]),


          if(rideController.currentRideState == RideState.afterAcceptRider)
            GestureDetector(
              onTap: ()=> Get.find<RideController>().updateRideCurrentState(RideState.otpSent),
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

                const RouteWidget(),
            K.sizedBoxH0,

                CustomButton(buttonText: Strings.cancelRide.tr,
                  transparent: true,
                  borderWidth: 1,
                  showBorder: true,
                  radius: Dimensions.paddingSizeSmall,
                  borderColor: Theme.of(Get.context!).primaryColor,
                  onPressed: (){
                    rideController.updateRideCurrentState(RideState.initial);
                    Get.find<MapController>().notifyMapController();
                  },
                )
              ]),
            ),

          if(rideController.currentRideState == RideState.otpSent)
            GestureDetector(
              onTap: () async {
                Get.dialog(const ConfirmationTripDialog(isStartedTrip: true,), barrierDismissible: false);
                await Future.delayed( const Duration(seconds: 5));
                rideController.updateRideCurrentState(RideState.ongoingRide);
                Get.find<MapController>().notifyMapController();
                Get.back();

              },
              child: Column(children: [
                TollTipWidget(title: Strings.riderDetails.tr),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                const OtpWidget(fromPage: Strings.bike,),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                ContactWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                ActivityScreenRiderDetails(
                  riderDetails:Driver(
                    firstName: "mostafizur",
                    rate: 5,
                    img: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
                    lastName: "smith"

                  ),


                  // RiderDetails(
                  //     f: "mostafizur",
                  //     vehicleNumber: "DH-1234",
                  //     rating: 5,
                  //     vehicleType: "bike",
                  //     vehicleName: "Pulser-150",
                  //     image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
                  // ),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                const EstimatedFareAndDistance(),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                const RouteWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                CustomButton(buttonText: Strings.cancelRide.tr,
                  transparent: true,
                  borderWidth: 1,
                  showBorder: true,
                  radius: Dimensions.paddingSizeSmall,
                  borderColor: Theme.of(Get.context!).primaryColor,
                  onPressed: (){
                    rideController.updateRideCurrentState(RideState.initial);
                    Get.find<MapController>().notifyMapController();
                  },
                )
              ]),
            ),

          if(rideController.currentRideState == RideState.ongoingRide)
            GestureDetector(
              onTap: () {
                showDialog(context: context, builder: (_){
                  return ConfirmationDialog(icon: Images.endTrip,
                    description: Strings.endThisTripAtYourDestination.tr, onYesPressed: () async {
                      Get.back();
                      Get.dialog(const ConfirmationTripDialog(isStartedTrip: false,), barrierDismissible: false);
                      await Future.delayed( const Duration(seconds: 5));
                      rideController.updateRideCurrentState(RideState.completeRide);
                      //Get.back();
                      Get.find<MapController>().notifyMapController();
                      Get.off(()=>const PaymentScreen());
                    },);
                });
              },
              child: Column(children: [
                TollTipWidget(title: Strings.tripIsOngoing.tr),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: Text.rich(TextSpan(
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)
                    ),
                    children:  [
                      TextSpan(text: Strings.theCarJustArrivedAt.tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                      TextSpan(text: " ".tr),
                      TextSpan(text: Strings.yourDestination.tr,style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor)),
                    ],
                  ),
                  ),
                ),

                ActivityScreenRiderDetails(
                  riderDetails: Driver(
                      firstName: "mostafizur",
                      rate: 5,
                      img: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
                      lastName: "smith"

                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
              ]),
            )
          ],
        ),
      );
    });
  }
}
