



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ride_sharing_user_app/util/ui/overlay_helper.dart';

import '../../../../../enum/request_states.dart';
import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/images.dart';
import '../../../../../util/text_style.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_calender.dart';
import '../../../../widgets/custom_category_card.dart';
import '../../../../widgets/custom_drop_down.dart';
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
            // const TripFareSummery(),
            K.sizedBoxH0,
            ///Previous before i try the tocheck wallet
            // Container(
            //      decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
            //         color: Theme.of(context).primaryColor.withOpacity(0.15)),
            //     padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            //     child: Center(
            //     child: CustomDropDown(
            //
            //       icon: Icon(
            //         Icons.expand_more,
            //         color: Theme.of(context).primaryColor.withOpacity(0.5),
            //       ),
            //       maxListHeight: 200,
            //       items: controller.paymentOptions
            //           .map((item) =>
            //           CustomDropdownMenuItem<
            //               String>(
            //             value: item,
            //             child:SizedBox(
            //               width: 200,
            //               child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                   Image.asset(
            //                   Images.profileMyWallet,
            //                   height: 15,
            //                   width: 15,
            //                 ), K.sizedBoxW0,
            //               Text(
            //                   item.tr,
            //                   style: textRegular.copyWith(
            //                       color: item !=
            //                           controller.initialSelectItem
            //                           ? Theme.of(
            //                           context)
            //                           .textTheme
            //                           .bodyMedium!
            //                           .color!
            //                           .withOpacity(
            //                           0.5)
            //                           : Theme.of(
            //                           context)
            //                           .primaryColor),
            //                 ),
            //                 ]),
            //             ),
            //
            //           ))
            //
            //           .toList(),
            //       // hintText: Strings.select.tr,
            //       isRowHint: true,
            //       rowWidget:Row(
            //         children: [
            //           Image.asset(
            //             Images.profileMyWallet,
            //             height: 15,
            //             width: 15,
            //           ), K.sizedBoxW0,
            //           Text(
            //             Strings.selectAPaymentMethod.tr,
            //             maxLines: 1,
            //             overflow: TextOverflow.clip,
            //           ),
            //         ],
            //       ),
            //       borderRadius: 5,
            //       onChanged: (selectedItem) {
            //         controller.initialSelectItem =
            //             selectedItem ?? Strings.all;
            //         if (controller.initialSelectItem ==
            //             Strings.custom) {
            //           showDialog(
            //               context: context,
            //               builder: (_) =>
            //                   CustomCalender(
            //                     onChanged: (value) {
            //                       Get.back();
            //                     },
            //                   ));
            //         }
            //         controller.update();
            //       },
            //     ),
            //   ),
            // ),

            // Text(controller.user?.wallet.toString()??''),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                color: Theme.of(context).primaryColor.withOpacity(0.15),
              ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Center(
                child: CustomDropDown(
                  icon: Icon(
                    Icons.expand_more,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  maxListHeight: 200,
                  items: controller.paymentOptions
                      .where((item) =>
                  !((item == 'wallet') && (controller.user?.wallet == 0)))
                      .map(
                        (item) => CustomDropdownMenuItem<String>(
                      value: item,
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.profileMyWallet,
                              height: 15,
                              width: 15,
                              color: (item == 'wallet' && controller.user?.wallet == 0)
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor,
                            ),
                            K.sizedBoxW0,
                            Text(
                              item.tr,
                              style: textRegular.copyWith(
                                color: item != controller.initialSelectItem
                                    ? Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(0.5)
                                    : (item == 'wallet' &&
                                    controller.user?.wallet == 0)
                                    ? Theme.of(context).disabledColor
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      .toList(),
                  isRowHint: true,
                  rowWidget: Row(
                    children: [
                      Image.asset(
                        Images.profileMyWallet,
                        height: 15,
                        width: 15,
                      ),
                      K.sizedBoxW0,
                      Text(
                        Strings.selectAPaymentMethod.tr,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                  borderRadius: 5,
                  onChanged: (selectedItem) {
                    if (selectedItem == 'wallet' && (controller.user?.wallet == 0)) {
                      // Do nothing or show a message indicating that the wallet balance is zero
                      print('Wallet balance is zero. Cannot select "wallet" option.');
                    } else {
                      // Execute only if the selected item is not 'wallet' with zero balance
                      controller.initialSelectItem = selectedItem!;
                      if (controller.initialSelectItem == Strings.custom) {
                        showDialog(
                          context: context,
                          builder: (_) => CustomCalender(
                            onChanged: (value) {
                              Get.back();
                            },
                          ),
                        );
                      }
                      controller.update();
                    }
                  },
                ),
              ),
            ),


            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                prefix: false,
                controller: controller.noteController,
                borderRadius: Dimensions.radiusLarge,
                hintText: Strings.addNote.tr,
              ),
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
                  print('controller.initialSelectItem ${controller.initialSelectItem}');

                  if( controller.selectedSubPackage.value !=null&&controller.initialSelectItem!=null){
                    baseMapController.   key.currentState!.contract();
                  baseMapController.changeState(request[RequestState.getPriceState]!);
                  await controller.getOrderPrice();
                  controller.update();
                  print( baseMapController.widgetNumber.value );
                }
                  else if(controller.selectedSubPackage.value ==null){

                    OverlayHelper.showWarningToast(context, Strings.selectACarType.tr);
                  }
                  else if(controller.initialSelectItem==null){
                    OverlayHelper.showWarningToast(context, Strings.selectAPaymentMethod.tr);
                    // print('select a type');
                  }
                }
                    )
                 ),
         K.sizedBoxH0,
            K.sizedBoxH0,
          ],
        ));
  }
}
