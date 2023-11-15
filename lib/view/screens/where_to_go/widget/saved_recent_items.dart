import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/text_style.dart';
import '../../ride/model/address_model.dart';

class SavedAndRecentItem extends StatelessWidget {
  final String icon;
  final String subTitle;
  final bool isSeeMore;
  final Function( AddressData data)? onTap;
  final AddressData addressData;

  const SavedAndRecentItem(
      {Key? key,
      required this.icon,
      required this.subTitle,
      this.isSeeMore = false,
    required  this.addressData,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap:()=> onTap?.call(addressData),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimensions.paddingSizeDefault,
                0,
                Dimensions.paddingSizeDefault,
                Dimensions.paddingSizeExtraSmall),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(.08),
                      borderRadius: BorderRadius.circular(
                          Dimensions.paddingSizeExtraSmall)),
                  child: SizedBox(
                      width: Dimensions.iconSizeMedium,
                      child: Image.asset(
                        icon,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                const SizedBox(
                  width: Dimensions.paddingSizeSmall,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subTitle.tr,
                      style: textRegular.copyWith(
                          color: Theme.of(context).primaryColor),
                    ),
                    // isSeeMore
                    //     ? Padding(
                    //         padding: const EdgeInsets.only(
                    //             top: Dimensions.paddingSizeSmall),
                    //         child: Container(
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: Dimensions.paddingSizeSmall,
                    //               vertical: Dimensions.paddingSizeExtraSmall),
                    //           decoration: BoxDecoration(
                    //               color: Theme.of(context)
                    //                   .hintColor
                    //                   .withOpacity(.125),
                    //               borderRadius: BorderRadius.circular(
                    //                   Dimensions.paddingSizeSeven)),
                    //           child: Text(
                    //             'see_more'.tr,
                    //             style: textRegular.copyWith(
                    //                 color: Theme.of(context).hintColor),
                    //           ),
                    //         ),
                    //       )
                    //     : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
