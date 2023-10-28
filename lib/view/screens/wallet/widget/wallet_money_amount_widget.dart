import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';

class WalletMoneyAmountWidget extends StatelessWidget {
  void Function()? onTap;
    WalletMoneyAmountWidget({
    Key? key,
    bool ?isWithDraw,
  required this.onTap
  }) : super(key: key, );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
        init: WalletController(),
        builder: (controller) {
          return InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeDefault,
                  0,
                  Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault),
              child: DottedBorder(
                dashPattern: const [1, 1],
                borderType: BorderType.RRect,
                color: Theme.of(context).primaryColor,
                radius: const Radius.circular(Dimensions.paddingSizeDefault),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Dimensions.paddingSizeDefault),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius:
                          BorderRadius.circular(Dimensions.paddingSizeDefault),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeExtraLarge,
                          vertical: Dimensions.paddingSizeExtraLarge),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Images.walletMoney,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                  width: Dimensions.paddingSizeDefault),
                              Obx(
                                () => Text(
                                  PriceConverter.convertPrice(
                                    context,
                                    double.parse(
                                      controller.amount.value.toString(),
                                    ),
                                  ),
                                  style: textBold.copyWith(
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: Dimensions.paddingSizeDefault),
                            ],
                          ),
                          const SizedBox(),
                          IconButton(
                            onPressed:  onTap,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: Dimensions.iconSizeMedium,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
