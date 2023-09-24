import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/date_converter.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/history/history_details_screen.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/activity_item_model.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../model/history_model.dart';

class ActivityItemView extends StatelessWidget {
  // final ActivityItemModel activityItemModel;
  final HistoryData activityItemModel;
  // final HistoryModel activityItemModel;
  final bool? isDetailsScreen;
  const ActivityItemView({Key? key, required this.activityItemModel, this.isDetailsScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Get.to(()=>  HistoryDetailsScreen(activityItemModel: activityItemModel,)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.02),
              ),
              child: Center(
                child: Column(
                  children: [
                    Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPKO1snoUiaUnFPzAd21Sf-8imAd1J_Li24fKwHSyItg&s',height: 40,width: 40,),
                    Text('type',
                      style: K.hintSmallTextStyle ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeExtraLarge,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activityItemModel.to?.location??'',
                    style: textMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                  Text(activityItemModel.createdAt.toString()??'',
                  // Text(DateConverter.localToIsoString(DateTime.parse(activityItemModel.date!)),
                    style:K.hintSmallTextStyle
                  ),
               // K.sizedBoxH0,
                  if(activityItemModel.status !='cancel' &&activityItemModel.userFarePrice!=null)
                  // if(activityItemModel.userFarePrice!=null)
                    Text(PriceConverter.convertPrice(context, activityItemModel.userFarePrice?.toDouble()??0),
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if(activityItemModel.status =='cancel')
                  Text(Strings.canceled.tr,
                    style: textMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: (){},
              icon: Icon(
                isDetailsScreen!? Icons.keyboard_arrow_down_rounded:Icons.arrow_forward_ios_outlined,
                size: isDetailsScreen!? 30:18,
                color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
