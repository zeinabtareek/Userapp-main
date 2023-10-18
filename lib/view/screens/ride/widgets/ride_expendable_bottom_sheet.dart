import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/get_price.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/ride_details_widget.dart';

import '../../../../util/images.dart';

class RideExpendableBottomSheet extends StatelessWidget {
  final bool isGetPrice;
  const RideExpendableBottomSheet({Key? key ,required this.isGetPrice}) : super(key: key);

 
 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (carRideController) {
      return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.paddingSizeDefault),
              topRight: Radius.circular(Dimensions.paddingSizeDefault)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor,
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(0, 2))
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
              Container(
                height: 7,
                width: 70,
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(
                      Dimensions.paddingSizeExtraSmall),
                ),
              ),
            
              // widget.isGetPrice?
              // GetPrice(image: Images.car,title: 'SUVww',):// const RideExpendableBottomSheet(isGetPrice: null,),
              BikeRideDetailsWidgets(image: Images.car  , title: 'SUV', )
            ])),
      );
    });
  }
}
