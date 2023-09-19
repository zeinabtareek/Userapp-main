



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../widgets/custom_text_field.dart';

class ParcelRouteWidget extends StatelessWidget {
  bool? showTotalDistance = true;
  bool? isParcel = false;
  Color? colorText;

  ParcelRouteWidget(
      {Key? key, this.showTotalDistance, this.isParcel, this.colorText});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(builder: (parcelController) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraSmall),
                child: Column(

                  children: [
                    K.sizedBoxH0,
                    SizedBox(
                        width: Dimensions.iconSizeMedium,
                        child: Image.asset(isParcel == true
                            ? Images.package2
                            : Images.currentLocation)),
                    SizedBox(
                        height: Dimensions.dropDownWidth,
                        width: 10,
                        child: colorText == null
                            ? CustomDivider(
                          height: 2,
                          dashWidth: 1,
                          axis: Axis.vertical,
                          color: Theme.of(context).primaryColor,
                        )
                            : CustomDivider(
                          height: 2,
                          dashWidth: 1,
                          axis: Axis.vertical,
                          color: colorText ?? Colors.black,
                        )),
                    SizedBox(
                        width: Dimensions.iconSizeMedium,
                        child: Image.asset(Images.activityDirection,
                            color:
                            colorText ?? Theme.of(context).primaryColor)),
                  ],
                ),
              ),
              K.sizedBoxW0,
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   parcelController.senderAddressController.text,
                      //   style:
                      //   textRegular.copyWith(color: colorText ?? Colors.black),
                      // ),
                      K.sizedBoxH0,
                      Text(Strings.pickUpPoint.tr,
                        style:
                        textRegular.copyWith(color: colorText ?? Colors.black),
                      ),
                      K.sizedBoxH0,
      const CustomTextField(
                          hintText: '32 East 98th Street, New York, NY 10065 , The United States of America',
                          inputType: TextInputType.name,
                          suffixIcon: Images.close,
                          prefixIcon: Images.search,
                          fillColor: Colors.white,
                          inputAction: TextInputAction.next,

                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      // Text(Strings.dropOffPoint.tr,
                      //   style: textRegular.copyWith(
                      //       color: colorText?.withOpacity(.5) ??
                      //           Theme.of(context).primaryColor),
                      // ),
                      K.sizedBoxH0,
                      Text(Strings.dropOffPoint.tr,
                        style:
                        textRegular.copyWith(color: colorText ?? Colors.black),
                      ),
                      K.sizedBoxH0,
                      const CustomTextField(
                        hintText: '32 East 98th Street, New York, NY 10065 , The United States of America',
                        inputType: TextInputType.name,
                        suffixIcon: Images.close,
                        prefixIcon: Images.search,
                        fillColor: Colors.white,
                        inputAction: TextInputAction.next,

                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                    ],
                  )),
            ],
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          showTotalDistance != false
              ? Padding(
            padding:
            const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: Dimensions.iconSizeMedium,
                        child: Image.asset(Images.distanceCalculated)),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(
                      "total_distance".tr,
                      style: textRegular.copyWith(),
                    ),
                  ],
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                const Text('12 km'),
              ],
            ),
          )
              : SizedBox()
        ],
      );
    });
  }
}
