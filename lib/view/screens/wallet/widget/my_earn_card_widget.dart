import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/date_converter.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/wallet_model.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

import '../../../../pagination/widgets/paginations_widgets.dart';
import '../../../../util/app_strings.dart';

class MyEarnCardWidget extends PaginationViewItem<WalletData> {
  final Function() onTap;
  const MyEarnCardWidget({required this.onTap, super.key, required super.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0,
          Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(width: Dimensions.iconSizeLarge,
                      //     child: Image.asset(Images.myEarnIcon)),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                '${'XID'}# ${data.transactionNum ?? ''}',
                                style: textSemiBold.copyWith(
                                    color: Theme.of(context).primaryColor),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeExtraSmall),
                            child: Text(
                              DateConverter.dateTimeStringToDateOnly(
                                  data.createdAt!),
                              style: textRegular.copyWith(
                                  color: Theme.of(context).hintColor),
                            ),
                          ),
                          if (data.order != null)
                            Text(
                              '${Strings.tripId.tr} : ${data.order?.id}',
                              style: textSemiBold.copyWith(
                                  color: Theme.of(context).primaryColor),
                            )
                        ],
                      ),
                    ],
                  )),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault,
                      vertical: Dimensions.paddingSizeSeven,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: (
                        data.isCharged
                              ? Theme.of(context).primaryColor
                              : Colors.red)
                          .withOpacity(.15),
                    ),
                    child: Text(
                      PriceConverter.convertPrice(
                          context, double.parse(data.amount.toString())),
                      style: textBold.copyWith(
                        color: (data.isCharged
                            ? Theme.of(context).primaryColor
                            : Colors.red),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          CustomDivider(
            height: .5,
            color: Theme.of(context).hintColor.withOpacity(.75),
          )
        ],
      ),
    );
  }
}
