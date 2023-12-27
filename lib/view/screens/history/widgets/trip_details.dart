import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

import '../../../../util/app_strings.dart';
import '../controller/activity_controller.dart';
import '../model/history_model.dart';

class ActivityScreenTripDetails extends StatelessWidget {
  final HistoryData tripDetails;
  final Completer<GoogleMapController> mapCompleter;

  ActivityScreenTripDetails({Key? key,    required this.mapCompleter,
       required this.tripDetails}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

    GetBuilder<ActivityController>(
    init: ActivityController(),
    builder: (activityController) {
      return Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(Strings.tripDetails.tr,style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor),),
           const SizedBox(height: Dimensions.paddingSizeSmall,),

          Row(children: [

            tripDetails.extraRoutes!=null&&tripDetails.extraRoutes!.isNotEmpty ?

            Column(children: [
              Image.asset(Images.currentLocation,height: 15,),
                SizedBox(height:60.h ,width: 10,
                  child: CustomDivider(height: 5.h,dashWidth: 1,axis: Axis.vertical,)),
              Image.asset(Images.activityDirection,height: 15,),
            ])
                :

            Column(children: [
              Image.asset(Images.currentLocation,height: 15,),
              const SizedBox(height:30 ,width: 10,
                  child: CustomDivider(height: 2,dashWidth: 1,axis: Axis.vertical,)),
              Image.asset(Images.activityDirection,height: 15,),
            ])
            ,

            const SizedBox(width: Dimensions.paddingSizeSmall,),
            Flexible(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
               InkWell(
                  child: Text(tripDetails.from?.location??'',
                    style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: ()async{


                    await activityController.goToPlace(mapCompleter,lat:  0.0, lng:  0.0,  );

                    },
                ),
                  SizedBox(height:20.h),
                  tripDetails .extraRoutes!=null&&tripDetails .extraRoutes!.isNotEmpty ?
                Padding(
                  padding:
                  const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                  child: Text(  tripDetails .extraRoutes?.first.location?? ''     ,

                      style: textMedium.copyWith(
                          color: Theme.of(Get.context!).primaryColor,
                          fontSize: Dimensions.fontSizeDefault)),
                )
                    :const SizedBox(),
                tripDetails .extraRoutes!=null&&tripDetails .extraRoutes!.isNotEmpty ?
                SizedBox(height:20.h) :const SizedBox(),
                GestureDetector(
                  child: Text(tripDetails.to?.location??'',
                    style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: ()async{

                    await activityController.goToPlace(mapCompleter,lat:  0.0, lng: 0.0,  );

                  },
                ),
              ]),
            )
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Image.asset(Images.profileMyWallet,height: 15,width: 15,),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Text(Strings.totalDistance.tr,
                  style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
              ]),
              Text(tripDetails.distance!.toString(),
                style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
                  fontSize: Dimensions.fontSizeSmall,
                ),
              )]
            ),
          )
          ],
        ),
      );}),

      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
          color: Theme.of(context).primaryColor.withOpacity(0.15)
        ),
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(children: [

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Image.asset(Images.profileMyWallet,height: 15,width: 15,),
              const SizedBox(width: Dimensions.paddingSizeSmall,),
              Text(Strings.price.tr,style: textRegular.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeSmall),),
            ]),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                color: Theme.of(context).primaryColor.withOpacity(0.2)
              ),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeExtraSmall),
           ///TODO zeinab add the price here
              child: Text('${tripDetails.finalPrice!.toString()}',style: textBold.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).primaryColor),),
            )]
          ),

          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Image.asset(Images.profileMyWallet,height: 15,width: 15,),
              const SizedBox(width: Dimensions.paddingSizeSmall,),
              Text(Strings.payment.tr,style: textRegular.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeSmall),),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(tripDetails.paymentType!.tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).primaryColor),),
            )]
          )     ],
        ),
      )
      ],
    );
  }
}
