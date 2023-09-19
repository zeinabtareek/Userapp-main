import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';

import '../../../../util/app_style.dart';

class OtpWidget extends StatelessWidget {
  final String fromPage;

  const OtpWidget({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault),
            child: Image.asset(
              fromPage == "parcel"
                  ? Images.findingDeliveryman
                  : fromPage == "bike"
                      ? Images.bike
                      : Images.car,
              width: 70,
            ),
          ),
          Text.rich(
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
                    text: 'the_driver_is_requesting_for_the'.tr,
                    style: textRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.8),
                        fontSize: Dimensions.fontSizeDefault)),
                const TextSpan(text: ' '),
                TextSpan(
                    text: 'pin_to_start_the_trip'.tr,
                    style: textSemiBold.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeDefault)),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault),
            child: Text('67 67 87'.tr,
                style: textBold.copyWith(
                    fontSize: 28,
                    color: Theme.of(context).textTheme.bodyMedium!.color)),
          ),
          Text.rich(
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
                    text: 'please'.tr,
                    style: textRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.8),
                        fontSize: Dimensions.fontSizeDefault)),
                TextSpan(
                    text: 'share_the_pin'.tr,
                    style: textSemiBold.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeDefault)),
                TextSpan(
                    text: 'with_the_driver'.tr,
                    style: textRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.8),
                        fontSize: Dimensions.fontSizeDefault)),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          K.sizedBoxH0,
          K.sizedBoxH0,
        ],
      ),
    );
  }
}
