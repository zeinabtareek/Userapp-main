import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';

import '../../../../../enum/request_states.dart';
import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/text_style.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_category_card.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../parcel/widgets/route_widget.dart';
import '../../../ride/controller/ride_controller.dart';
import '../../../where_to_go/controller/create_trip_controller.dart';

class SecondWidget extends StatelessWidget {
  String image;
  String title;
  List<LatLng> points;

  SecondWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
        init: RideController(rideRepo: Get.find()),
        builder: (rideController) {
          return Stack(
            children: [
              rideController.state == ViewState.busy
                  ? Positioned.fill(
                      child: Center(
                      // color: Colors.grey.withOpacity(.6),
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    ))
                  : const SizedBox(),
              IgnorePointer(
                ignoring: rideController.state == ViewState.busy
                    ? true
                    : false, // <-- Ignore only when selecting something.
                child: Column(
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
                    // K.sizedBoxH0,
                    RouteWidget(),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.paddingSizeExtraSmall),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.price.tr,
                            style: textRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge),
                          ),

                          ///zeinab get price
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          rideController.priceData.priceBeforeDiscount == null
                              ? const Text('0.0')
                              : Text(
                                  '${rideController.priceData.priceBeforeDiscount} ',
                                  style: textSemiBold.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color!
                                          .withOpacity(0.8),
                                      fontSize: Dimensions.fontSizeLarge),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8),
                      child: Text(
                        Strings.doYouHaveAnyPromoCode.tr,
                        style: textSemiBold.copyWith(
                            color: Theme.of(context).hintColor.withOpacity(0.8),
                            fontSize: Dimensions.fontSizeDefault),
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            prefix: false,
                            controller: rideController.promoCodeController,
                            borderRadius: Dimensions.radiusLarge,
                            hintText: Strings.promoCode.tr,
                          ),
                        ),
                        K.sizedBoxW0,
                        Obx(() => Expanded(
                              child: CustomButton(
                                  isLoading: rideController.loading.value,
                                  radius: 50,
                                  buttonText: Strings.apply.tr,
                                  onPressed: () {
                                    // rideController.calculateDistance();
                                    rideController.getPromoCodeDiscount();
                                    //
                                    // rideController
                                    //     .updateRideCurrentState(RideState.findingRider);
                                  }),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.yourPriceAfterDiscount.tr,
                          style: textRegular.copyWith(
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                        GetBuilder<RideController>(
                          builder: (rideController) =>
                              rideController.priceData.finalPrice == null ||
                                      rideController.priceData.finalPrice ==
                                          rideController
                                              .priceData.priceBeforeDiscount
                                  ? const SizedBox()
                                  : Text(
                                      '${rideController.priceData.finalPrice}',
                                      style: textSemiBold.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color!
                                              .withOpacity(0.8),
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge),
                                    ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    //   baseMapController.changeState(request[RequestState.getPriceState]!);

                    GetBuilder<CreateATripController>(
                        init: CreateATripController(),
                        builder: (baseMapController) => Obx(() => CustomButton(
                            buttonText: Strings.findDriver.tr,
                            radius: 50,
                            isLoading:
                                baseMapController.isLoadingCreateATrip.isTrue,
                            onPressed: () async {
                              ///zeinab here we will create a trip
                              baseMapController.key.currentState?.contract();
                              if (Get.find<RideController>()
                                      .initialSelectItem ==
                                  'wallet') {
                                baseMapController.changeState(
                                    request[RequestState.findDriverState]!);
                              }
                              await Get.find<CreateATripController>()
                                  .createATrip(points);
                              baseMapController.update();
                            }))),
                    K.sizedBoxH0,
                    K.sizedBoxH0,
                  ],
                ),
              ),
            ],
          );
        });
  }
}
