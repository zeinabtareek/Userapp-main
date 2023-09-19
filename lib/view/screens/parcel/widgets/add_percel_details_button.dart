import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';

class AddParcelDetailsButton extends StatefulWidget {
  const AddParcelDetailsButton({Key? key}) : super(key: key);

  @override
  State<AddParcelDetailsButton> createState() => _AddParcelDetailsButtonState();
}

class _AddParcelDetailsButtonState extends State<AddParcelDetailsButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<ParcelController>()
            .updateParcelState(ParcelDeliveryState.addOtherParcelDetails);
        Get.find<MapController>().notifyMapController();
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
                color:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.5)),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      Images.parcelDetails,
                      width: Dimensions.iconSizeMedium,
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeSmall,
                    ),
                    Text('add_product_details'.tr)
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
        ],
      ),
    );
  }
}
