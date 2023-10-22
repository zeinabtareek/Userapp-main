import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/controller/where_to_go_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

import '../../../../util/app_style.dart';
import '../../ride/controller/ride_controller.dart';

class RouteWidget extends StatelessWidget {
  bool? showTotalDistance = true;
  bool? isParcel = false;
  Color? colorText;

  RouteWidget(
      {Key? key, this.showTotalDistance, this.isParcel, this.colorText});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(builder: (parcelController) {
      return GetBuilder<WhereToGoController>(

          init:WhereToGoController() ,
          builder: (whereToGoController) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall),
                  child: Column(
                    children: [
                      SizedBox(
                          width: Dimensions.iconSizeMedium,
                          child: Image.asset(isParcel == true
                              ? Images.package2
                              : Images.currentLocation)),
                      SizedBox(
                          height: 45,
                          width: 10,
                          child: colorText == null
                              ? CustomDivider(
                            height: 2,
                            dashWidth: 1,
                            axis: Axis.vertical,
                            color: Theme
                                .of(context)
                                .primaryColor,
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
                              colorText ?? Theme
                                  .of(context)
                                  .primaryColor)),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          whereToGoController.fromRouteController.text,
                          // parcelController.senderAddressController.text,
                          style:
                          textRegular.copyWith(
                              color: colorText ?? Colors.black),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Text(
                          'to'.tr,
                          style: textRegular.copyWith(
                              color: colorText?.withOpacity(.5) ??
                                  Theme
                                      .of(context)
                                      .primaryColor),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Text(
                          whereToGoController.toRouteController.text,
                          // parcelController.receiverAddressController.text,
                          style:
                          textRegular.copyWith(
                              color: colorText ?? Colors.black),
                        ),
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


                    Text('${whereToGoController.distance} km'),
                    // Text('${whereToGoController.duration} duration'),
                ],
              ),
            )
                : SizedBox()
          ],
        );
      });
    }
    );
  }
}