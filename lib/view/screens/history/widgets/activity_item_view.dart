import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/date_converter.dart';
import '../../../../helper/price_converter.dart';
import '../../../../pagination/widgets/paginations_widgets.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_image.dart';
import '../history_details_screen.dart';
import '../model/history_model.dart';

class ActivityItemView extends PaginationViewItem<HistoryData> {
  const ActivityItemView( {required this.isDetailsScreen ,super.key, required super.data});

  final bool? isDetailsScreen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => HistoryDetailsScreen(
            activityItemModel: data,
          )),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Dimensions.orderStatusIconHeight,
              width: Dimensions.orderStatusIconHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withOpacity(0.02),
              ),
              child: Center(
                child: Column(
                  children: [
                    K.sizedBoxH2,
                    Expanded(
                      child: ClipRRect(
                        // borderRadius: BorderRadius.circular(50),
                        child: CustomImage(
                          image: data.driver?.vehicle?.img ?? '',
                          // height: Dimensions.iconSizeExtraLarge,
                          // width: Dimensions.dropDownWidth,

                          placeholder: Images.car, fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // Image.network(CustomImage(),height: 40,width: 40,),
                    // Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPKO1snoUiaUnFPzAd21Sf-8imAd1J_Li24fKwHSyItg&s',height: 40,width: 40,),
                    Text(data.driver?.vehicle?.type ?? '',
                        style: K.hintSmallTextStyle),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: Dimensions.paddingSizeExtraLarge,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.to?.location ?? '',
                    style: textMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraSmall,
                  ),
                  // Text(data.createdAt.toString() ?? '',
                  //     // Text(DateConverter.localToIsoString(DateTime.parse(activityItemModel.date!)),
                  //     style: K.hintSmallTextStyle),
                  Text(
                    DateConverter.isoStringToLocalString(//_onSelectionChanged
                      data.createdAt?.toString() ?? "",
                    ),
                    style: textRegular.copyWith(
                        color: Theme.of(context).hintColor.withOpacity(.85),
                        fontSize: Dimensions.fontSizeSmall),
                  ),
                  /// just removed 27.sep
                  if (data.status != 'cancel')
                    // if(activityItemModel.status !='cancel' &&activityItemModel.userFarePrice!=null)
                    // if(activityItemModel.userFarePrice!=null)
                    Text(
                      PriceConverter.convertPrice(context, 330),
                      // Text(PriceConverter.convertPrice(context, activityItemModel.userFarePrice?.toDouble()??0),
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (data.status == 'cancel')
                    Text(
                      Strings.canceled.tr,
                      style: textMedium.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Colors.red.withOpacity(0.8)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                isDetailsScreen!

                // false
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.arrow_forward_ios_outlined,
                size: 
                // false
                     isDetailsScreen!

                    ? 30
                    : 18,
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withOpacity(0.2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
