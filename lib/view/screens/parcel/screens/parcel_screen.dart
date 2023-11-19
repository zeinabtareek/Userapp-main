import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/custom_oval.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/custom_shipment_card.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/delivery_parcel_option.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_text_field.dart';

class ParcelScreen extends StatelessWidget {
  const ParcelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBody(
            appBar: CustomAppBar(
              title: Strings.addShipment.tr,
              showBackButton: true,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: K.fixedPadding0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    K.sizedBoxH0,
                    RouteWidget(
                      showTotalDistance: false,
                      isParcel: true,
                    ),
                    K.sizedBoxH0,
                    K.sizedBoxH0,
                    Text(
                      Strings.shipmentType.tr,
                      style: K.hintMediumTextStyle,
                    ),
                    K.sizedBoxH0,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButton(
                            backgroundColor: Color(0xffFAFAFA),
                            isLoading: false,
                            textColor: Theme.of(Get.context!).hintColor,
                            height: Dimensions.paddingSizeSignUp,
                            buttonText: '  Letter',
                            icon: Icons.mail_outline_rounded,
                            iconColor: Colors.grey,
                            onPressed: () {},
                            radius: 50,
                          ),
                        ),
                        K.sizedBoxW0,
                        Expanded(
                          child: CustomButton(
                            backgroundColor:
                                Theme.of(Get.context!).primaryColor,
                            isLoading: false,
                            textColor: Theme.of(Get.context!).cardColor,
                            height: Dimensions.paddingSizeSignUp,
                            buttonText: '  Parcel',
                            image: Image.asset(
                              Images.parcelIcon,
                              width: Dimensions.iconSizeMedium,
                              height: Dimensions.iconSizeMedium,
                              fit: BoxFit.fill,
                            ),
                            iconColor: Colors.grey,
                            // width: Dimensions.identityImageWidth,
                            onPressed: () {},
                            radius: 50,
                          ),
                        ),
                      ],
                    ),
                    K.sizedBoxH0,
                    Text(
                      Strings.packageName.tr,
                      style: K.hintMediumTextStyle,
                    ),
                    K.sizedBoxH0,
                    const CustomTextField(
                      hintText: '3john smith',
                      inputType: TextInputType.name,
                      // suffixIcon: Images.close,
                      prefixIcon: Images.location,
                      prefix: false,
                      fillColor: Color(0xffEDF7F6),
                      inputAction: TextInputAction.next,
                    ),
                    K.sizedBoxH0,
                    // K.sizedBoxH0,

                    GetBuilder<ParcelController>(builder: (controller) {
                      return Row(
                        children: [
                          ///weight

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.weight.tr,
                                style: K.hintMediumTextStyle,
                              ),
                              K.sizedBoxH2,
                              Container(
                                padding: K.fixedPadding1,
                                width: MediaQuery.of(context).size.width / 4,
                                // height: 35,
                                decoration: K.lightGreenBoxDecoration,
                                // padding:  K.fixedPadding0,
                                child: CustomDropDown(
                                  icon: Icon(
                                    Icons.expand_more,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(0.5),
                                  ),
                                  maxListHeight:
                                      MediaQuery.of(context).size.height / 2,
                                  items: controller.kilosList
                                      .map((item) =>
                                          CustomDropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: textRegular.copyWith(
                                                  color: item !=
                                                          controller
                                                              .kilosList.first
                                                      ? Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .color!
                                                          .withOpacity(0.5)
                                                      : Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          ))
                                      .toList(),
                                  hintText: controller.kilosList.first,
                                  borderRadius: 5,
                                  onChanged: (selectedItem) {
                                    controller.kilosList.first =
                                        selectedItem ?? Strings.all;
                                    if (controller.kilosList.first ==
                                        Strings.custom) {}
                                    controller.update();
                                  }, initialSelectedValue: '',
                                ),
                              ),
                            ],
                          ),
                          K.sizedBoxW0,

                          ///add or minimize

                          Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                  Strings.quantity.tr,
                                  style: K.hintMediumTextStyle,
                                ),
                                K.sizedBoxH2,
                                Container(
                                  // padding: EdgeInsets.only(left: Dimensions.radiusSmall,right: Dimensions.radiusSmall,top:  Dimensions.radiusSmall),
                                  padding:
                                      EdgeInsets.all(Dimensions.radiusSmall),
                                  // child: Row(),
                                  decoration: K.lightGreenBoxDecoration,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        '${controller.counter} Package',
                                      ),
                                      Expanded(child: SizedBox()),
                                      GestureDetector(
                                        child: Container(
                                          width: Dimensions.iconSizeExtraLarge,
                                          height: Dimensions.iconSizeExtraLarge,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Icon(Icons.remove,
                                              color: Colors.black),
                                        ),
                                        onTap: () {
                                          controller.minimize();
                                        },
                                      ),
                                      K.sizedBoxW0,
                                      GestureDetector(
                                        child: Container(
                                          width: Dimensions.iconSizeExtraLarge,
                                          height: Dimensions.iconSizeExtraLarge,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          child: Icon(Icons.add,
                                              color: Colors.black),
                                        ),
                                        onTap: () {
                                          controller.add();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ]))
                        ],
                      );
                    }),
                    K.sizedBoxH0,

                    Text(
                      Strings.deliveryOptions.tr,
                      style: K.hintMediumTextStyle,
                    ),
                    K.sizedBoxH0,
                    GetBuilder<ParcelController>(
                      builder: (controller) {
                        return DeliveryParcelOptions(
                          height: 88,
                          onPressed: controller.isTapped,
                          isTapped: controller.isBtnTapped.value,
                          isSelected: controller.isSelected.value,
                        );
                      },
                    ),

                    K.sizedBoxH0,
                    CustomShipmentCard(leftButtonText: Strings.sameDay.tr, rightButtonText: '\$222', desc: 'Luctus nam arcu est venenatis semper velit. Lectus enim ut tristique nunc.',)
                  ],
                ),
              ),
            )));
  }
}




