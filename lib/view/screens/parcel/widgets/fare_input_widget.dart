import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../../../util/app_style.dart';

class FareInputWidget extends StatelessWidget {
  final String fromPage;
  const FareInputWidget({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController){
      return Row(children: [
        // Expanded(child: GestureDetector(
        //   onTap: (){
        //     if(fromPage=='ride'){
        //       Get.find<RideController>().updateRideCurrentState(RideState.riseFare);
        //     }else{
        //       Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.riseFare);
        //     }
        //     Get.find<MapController>().notifyMapController();
        //   },
        //   child: Container(height: 45,decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        //     border: Border.all(color: Theme.of(context).primaryColor,width: 1),
        //   ),
        //       child: Center(child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
        //         Expanded(
        //           child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        //             child: Text('your_fare'.tr,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
        //
        //                 color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.9)),
        //             ),
        //           ),
        //         ),
        //
        //         Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        //           child: Text(PriceConverter.convertPrice(context, double.tryParse( Get.find<RideController>().inputFarePriceController.text)!,),
        //             style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.9)),),),
        //
        //       ]))),
        // )),
        //
        Expanded(child: CustomButton(
          radius: 25,
          buttonText: Get.find<RideController>().selectedCategory==RideType.bike?"find_rider".tr:
          Get.find<RideController>().selectedCategory==RideType.car||Get.find<RideController>().selectedCategory==RideType.luxury?"find_driver".tr
              : "find_deliveryman".tr,
          onPressed: (){
            if(fromPage=='ride'){
              Get.find<RideController>().updateRideCurrentState(RideState.findingRider);
            }else{
              Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.suggestVehicle);
            }
            Get.find<MapController>().notifyMapController();
          },
          fontSize: Dimensions.fontSizeDefault,)
        ),

      ],
      );
    });
  }
}
