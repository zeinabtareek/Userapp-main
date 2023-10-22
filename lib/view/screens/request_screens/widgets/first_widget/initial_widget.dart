



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../../enum/request_states.dart';
import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/text_style.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_category_card.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../home/controller/category_controller.dart';
import '../../../parcel/widgets/route_widget.dart';
import '../../../ride/controller/ride_controller.dart';
import '../../../ride/widgets/ride_category.dart';
import '../../../ride/widgets/trip_fare_summery.dart';
import '../../controller/base_map_controller.dart';

class InitialRequestWidget extends StatelessWidget {
  String image;
  String title;
    InitialRequestWidget({super.key,
    required this.image,
    required this.title,

  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
        init: RideController(rideRepo: Get.find()),
        builder: (controller) =>
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.selectedSubPackage.value == null
                  ? 'please_choose_a_car_type'.tr
                  : '${'your_selected_car_type'.tr} : ${controller.selectedSubPackage.value?.categoryTitle}',
              style: textRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600),
            ),
            K.sizedBoxH0,
            controller.selectedSubPackage.value == null
                ? GetBuilder<CategoryController>(
                initState: (_) =>
                    Get.find<CategoryController>().getCategoryList(),
                builder: (categoryController) {
                  return const RideCategoryWidget();
                })
                : Center(
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
            // isBiddingOn
            //     ?

            ///TODO :this code zeinab removed it to apply the getPrice screen


            GetBuilder<BaseMapController>(
              init: BaseMapController( ),
              builder: (baseMapController) =>  CustomButton(
                buttonText: Strings.getPrice.tr,
                radius: 50,
                onPressed: () async {
                  // baseMapController.  key.currentState!.contract();
                  baseMapController.changeState(request[RequestState.getPriceState]!);
                  await controller.getOrderPrice();
                  controller.update();
                  print( baseMapController.widgetNumber.value );
                }
                    )
                // : CustomButton(
                // buttonText: Strings.findRider.tr,
                // onPressed: () {
                //   update(RideState.findingRider);
                 ),
         K.sizedBoxH0,
            K.sizedBoxH0,
          ],
        ));
  }
}
