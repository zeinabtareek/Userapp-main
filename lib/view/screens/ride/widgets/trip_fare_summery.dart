import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';

class TripFareSummery extends StatelessWidget {
  final bool fromPayment;
  final String paymentMethod;

  const TripFareSummery({Key? key, this.fromPayment = false,required this.paymentMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
          color: fromPayment
              ? null
              : Theme.of(context).primaryColor.withOpacity(0.15)),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //   Row(children: [
          //     Image.asset(
          //       Images.profileMyWallet,
          //       height: 15,
          //       width: 15,
          //     ),
          //     const SizedBox(
          //       width: Dimensions.paddingSizeSmall,
          //     ),
          //     Text(
          //       'fare_price'.tr,
          //       style: textRegular.copyWith(
          //           color: Theme.of(context).primaryColor,
          //           fontSize: Dimensions.fontSizeSmall),
          //     ),
          //   ]),
          //   Container(
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          //         color: Theme.of(context).primaryColor.withOpacity(0.2)),
          //     padding: const EdgeInsets.symmetric(
          //         horizontal: Dimensions.paddingSizeSmall,
          //         vertical: Dimensions.paddingSizeExtraSmall),
          //     child: Text(
          //       PriceConverter.convertPrice(context, 150),
          //       style: textBold.copyWith(
          //           fontSize: Dimensions.fontSizeSmall,
          //           color: Theme.of(context).primaryColor),
          //     ),
          //   )
          // ]),
          const SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Image.asset(
                Images.profileMyWallet,
                height: 15,
                width: 15,
              ),
              const SizedBox(
                width: Dimensions.paddingSizeSmall,
              ),
              Text(
                'payment'.tr,
                style: textRegular.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeSmall),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(paymentMethod.tr,
                style: textRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).primaryColor),
              ),
            )
          ])
        ],
      ),
    );
  }
}
