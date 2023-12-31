import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/address_model.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';

import '../../ride/model/address_model.dart';
import '../../where_to_go/where_to_go_screen.dart';

class AddressItemCard extends StatelessWidget {
  final AddressData addressModel;
  // final AddressModel addressModel;
  final String fromPage;

  const AddressItemCard(
      {Key? key, required this.addressModel, required this.fromPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (fromPage == "home") {
          Get.to(() => SetDestinationScreen(
                address: addressModel.location,
              ));
        } else {
          Get.find<ParcelController>()
              .setParcelAddress(addressModel.location ?? "");
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeExtraSmall,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.05),
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                width: 0.5),
            borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge)),
        child: Row(
          children: [
            ///Zeinab uncomment this
            // Image.asset(Assets.!, width: 20),
            const SizedBox(
              width: 5,
            ),
            Text(addressModel.name.toString().tr??''),
          ],
        ),
      ),
    );
  }
}
