import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_loading.dart';

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
import '../../controller/base_map_controller.dart';

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
    bool isKeyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
          return Stack(
                children: [
                  rideController.state == ViewState.busy
                      ? Positioned.fill(
                          child: Center(
                          // color: Colors.grey.withOpacity(.6),
                          child: customLoading()
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
                          '${'your_selected_car_type'.tr}: $title',
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
                        if (!isKeyboardIsOpen) RouteWidget(),
                        if (!isKeyboardIsOpen)
                          const SizedBox(
                            height: Dimensions.paddingSizeDefault,
                          ),
                        if (!isKeyboardIsOpen)
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



                        GetBuilder<BaseMapController>(
                            init: BaseMapController(),
                            builder: (controller)    =>        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('duration'.tr),
                            Text('${controller.duration}'),
                            // Text('${baseMapController.duration}'),
                          ],   ),
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
                        if (!isKeyboardIsOpen)       const SizedBox(
                          height: Dimensions.paddingSizeDefault,
                        ),
                          GetBuilder<BaseMapController>(
          init: BaseMapController(),
          builder: (controller)    => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0).copyWith(
                              bottom: MediaQuery.of(context).viewInsets.bottom), child:

                        Row(
                            children: [

                              Expanded(
                                flex: 2,
                                child: CustomTextField(
                                  onTap: (){
                                    // controller.persistentContentHeightt=900;
                                    // print(controller.persistentContentHeight);
                                    // controller. key.currentState!.expand();
                                    // controller.update();
                                  },
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

                        ),
                        ),


                        // if (!isKeyboardIsOpen)
                          const SizedBox(
                          height: Dimensions.paddingSizeDefault,
                        ),
                        // if (!isKeyboardIsOpen)
                        SizedBox(
                          height: Dimensions.paddingSizeDefault,
                          child: Text(  Get.find<RideController>().initialSelectItem.toString().toUpperCase()),
                        ),
                        // if (!isKeyboardIsOpen)
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
                        // if (!isKeyboardIsOpen)
                        const SizedBox(
                          height: Dimensions.paddingSizeDefault,
                        ),
                        //  if (!isKeyboardIsOpen)
                          GetBuilder<CreateATripController>(
                              init: CreateATripController(),
                              builder: (baseMapController) => Obx(() =>
                                  CustomButton(
                                      buttonText: Strings.findDriver.tr,
                                      radius: 50,
                                      isLoading: baseMapController
                                          .isLoadingCreateATrip.isTrue,
                                      onPressed: () async {
                                        ///zeinab here we will create a trip
                                        // baseMapController.key.currentState
                                        //     ?.contract();
                                        //

                                        if (Get.find<RideController>()
                                                .initialSelectItem ==
                                            'wallet') {
                                          baseMapController.changeState(request[
                                              RequestState.findDriverState]!);
                                        }
                                        // Get.find<BaseMapController>().key.currentState
                                        //     ?.contract();
                                        await Get.find<CreateATripController>()
                                            .createATrip(points);
                                        baseMapController.update();
                                      }))),
                        // if (!isKeyboardIsOpen)
                        // K.sizedBoxH0,
                        K.sizedBoxH0,
                        // if (!isKeyboardIsOpen)    K.sizedBoxH0,
                      ],
                    ),
                  ),
                ],
              )

           ;
        });
  }
}
