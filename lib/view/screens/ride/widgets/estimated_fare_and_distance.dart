import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';

import '../../../../util/app_style.dart';
import '../../request_screens/controller/base_map_controller.dart';
import '../../where_to_go/controller/create_trip_controller.dart';

class EstimatedFareAndDistance extends StatelessWidget {
  String? finalprice;
  String? distance;

  EstimatedFareAndDistance({
    Key? key,
    this.distance,
    this.finalprice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateATripController>(
      init: CreateATripController(),
      builder: (controller) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
            color: Theme.of(context).primaryColor.withOpacity(0.15)),
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customDistanceItem(
                context,
                false,
                "${distance ?? controller.orderModel.data?.distance.toString()} km",
                "distance_away"),
            customDistanceItem(
                context,
                false,
                "${Get.find<BaseMapController>().duration ?? 0.0} ",
                "estimated_time"),
            customDistanceItem(
                context,
                true,
               "${finalprice ?? controller.orderModel.data?.finalPrice .toStringAsFixed(2)} ",
                "price"),

            // customDistanceItem(context, false, "${controller.orderModel.data?.distance.toString()??'0.0'} km", "distance_away"),
            //      customDistanceItem(context, false, "${Get.find<RideController>().duration??0.0} min", "estimated_time"),
            //      customDistanceItem(context, true, "${controller.orderModel.data?.finalPrice.toString()??'0.0'} ", "fare_price"),
            //
          ],
        ),
      ),
    );
  }

  Widget customDistanceItem(
      BuildContext context, bool isAmount, String title, String subTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isAmount
              ? PriceConverter.convertPrice(context, double.tryParse(title)!)
              : title,
          style: textBold.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: Dimensions.fontSizeLarge),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeThree,
        ),
        Text(
          subTitle.tr,
          style: K.hintMediumTextStyle,
        )
      ],
    );
  }
}
