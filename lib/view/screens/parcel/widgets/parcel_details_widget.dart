import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/rider_details.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/add_percel_details_button.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/choose_effificent_vehicle_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/contact_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/distance_caculated_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/fare_input_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/finding_rider_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/get_price.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/otp_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_details_input_view.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/product_details_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/sender_receiver_info_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/who_will_pay_button.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/tolltip_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/confirmation_trip_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/estimated_fare_and_distance.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/rise_fare_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../../../util/images.dart';
import '../../history/model/history_model.dart';

class ParcelDetailsWidgets extends StatefulWidget {
  const ParcelDetailsWidgets({Key? key}) : super(key: key);

  @override
  State<ParcelDetailsWidgets> createState() => _ParcelDetailsWidgetsState();
}

class _ParcelDetailsWidgetsState extends State<ParcelDetailsWidgets> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(builder: (parcelController) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (parcelController.currentParcelState ==
                ParcelDeliveryState.initial)
              Column(children: const [SenderReceiverInfoWidget()]),
            if (parcelController.currentParcelState ==
                ParcelDeliveryState.parcelInfoDetails)
              Column(children: [
                const TollTipWidget(
                  title: "delivery_details",
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                RouteWidget(),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                const DistanceCalculatedWidget(),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                parcelController.parcelDetailsAvailable == false
                    ? const AddParcelDetailsButton()
                    : const ProductDetailsWidget(),
                ///update
                const WhoWillPayButton(),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                const TollTipWidget(
                  title: "terms_and_policy",
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                FindDriverCustomBtn(
                  fromPage: 'parcel',
                  whoWillPay: parcelController.payReceiver
                )
              ]),
            if (parcelController.currentParcelState ==
                ParcelDeliveryState.addOtherParcelDetails)
              Column(
                children: const [ParcelDetailInputView()],
              ),
            if (parcelController.currentParcelState ==
                ParcelDeliveryState.riseFare)
              Column(
                children: [
                  const TollTipWidget(
                    title: "delivery_details",
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  RouteWidget(),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  const DistanceCalculatedWidget(),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  parcelController.parcelDetailsAvailable == false
                      ? const AddParcelDetailsButton()
                      : const ProductDetailsWidget(),
                  const WhoWillPayButton(),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  const TollTipWidget(
                    title: "terms_and_policy",
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  const RiseFareWidget(fromPage: 'parcel'),
                ],
              ),
            if (parcelController.currentParcelState ==
                ParcelDeliveryState.suggestVehicle)
              Column(
                children: const [ChooseEfficientVehicleWidget()],
              ),
            if (parcelController.currentParcelState ==
                ParcelDeliveryState.findingRider)
                Column(
                children: [
                  FindingRiderWidget(
                    fromPage: 'parcel',
                  )
                ],
              ),

             if (parcelController.currentParcelState ==
                ParcelDeliveryState.findingRider)
              Column(
                children:   [
                  GetPrice(image: Images.car, title: 'Suv',
                   )
                ],
              ),






            if (parcelController.currentParcelState ==
                ParcelDeliveryState.acceptRider)
              GestureDetector(
                onTap: () {
                  Get.find<ParcelController>()
                      .updateParcelState(ParcelDeliveryState.otpSent);
                },
                child: Column(
                  children: [
                    const TollTipWidget(
                      title: "rider_details",
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    ContactWidget(),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
            // TODO: 
                    // ActivityScreenRiderDetails(
                    //   riderDetails: Driver(
                    //       firstName: "mostafizur",
                    //       rate: 5,
                    //       img:
                    //           "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
                    //       lastName: "smith"),
                    // ),
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
                      buttonText: 'cancel_ride'.tr,
                      transparent: true,
                      borderWidth: 1,
                      showBorder: true,
                      radius: Dimensions.paddingSizeSmall,
                      borderColor: Theme.of(Get.context!).primaryColor,
                      onPressed: () {
                        parcelController
                            .updateParcelState(ParcelDeliveryState.initial);
                        Get.find<MapController>().notifyMapController();
                      },
                    )
                  ],
                ),
              ),
            if (parcelController.currentParcelState ==
                ParcelDeliveryState.otpSent)
              GestureDetector(
                onTap: () async {
                  Get.dialog(
                      const ConfirmationTripDialog(
                        isStartedTrip: true,
                      ),
                      barrierDismissible: false);
                  await Future.delayed(const Duration(seconds: 5));
                  parcelController
                      .updateParcelState(ParcelDeliveryState.parcelOngoing);
                  Get.find<MapController>().notifyMapController();
                  Get.back();
                },
                child: Column(children: [
                  TollTipWidget(title: 'rider_details'.tr),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  const OtpWidget(
                    fromPage: 'bike',
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  ContactWidget(),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),

                  // ActivityScreenRiderDetails(
                  //   riderDetails: Driver(
                  //       firstName: "mostafizur",
                  //       rate: 5,
                  //       img:
                  //           "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
                  //       lastName: "smith"),
                  // ),
                
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
                    buttonText: 'cancel_ride'.tr,
                    transparent: true,
                    borderWidth: 1,
                    showBorder: true,
                    radius: Dimensions.paddingSizeSmall,
                    borderColor: Theme.of(Get.context!).primaryColor,
                    onPressed: () {
                      parcelController
                          .updateParcelState(ParcelDeliveryState.initial);
                      Get.find<MapController>().notifyMapController();
                    },
                  )
                ]),
              ),
            if (parcelController.currentParcelState ==
                ParcelDeliveryState.parcelOngoing)
              Column(children: [
                TollTipWidget(title: 'trip_is_ongoing'.tr),
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
                            text: "the_car_just_arrived_at".tr,
                            style: textRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault)),
                        TextSpan(text: " ".tr),
                        TextSpan(
                            text: "your_destination".tr,
                            style: textMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  ),
                ),
                // ActivityScreenRiderDetails(
                //   riderDetails: Driver(
                //       firstName: "mostafizur",
                //       rate: 5,
                //       img:
                //           "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
                //       lastName: "smith"),
                // ),
            
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
              ])
          ],
        ),
      );
    });
  }
}
