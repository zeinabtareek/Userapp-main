import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/dimensions.dart';
import '../../../../util/text_style.dart';
import '../../ride/model/address_model.dart';
import '../controller/address_controller.dart';
import '../screens/add_or_update_address_screen.dart';

class AddressItemCard extends StatelessWidget {
  final AddressData item;
  // final AddressModel addressModel;
  final String fromPage;

  const AddressItemCard({Key? key, required this.item, required this.fromPage})
      : super(key: key);

/*

  if (fromPage == "home") {
          Get.to(() => SetDestinationScreen(
                address: item.location,
                fromCat: false,
              ));
        } else {
          Get.find<ParcelController>().setParcelAddress(item.location ?? "");
        }
 */
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ignore: avoid_single_cascade_in_expression_statements
        Get.find<AddressController>()..initAddOrEditScreen(item);
        Get.to(() => AddOrUpdateAddressScreen(
              address: item,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeExtraSmall,
        ),
        decoration: BoxDecoration(
            color: !item.isHaveData
                ? Theme.of(context).primaryColor.withOpacity(0.05)
                : Theme.of(context).primaryColor,
            border: Border.all(
              color: !item.isHaveData
                  ? Theme.of(context).primaryColor.withOpacity(0.4)
                  : Theme.of(context).primaryColor,
              width: !item.isHaveData ? 0.5 : 1,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge)),
        child: Row(
          children: [
            ///Zeinab uncomment this
            Image.asset(
              item.icon!,
              width: 20,
              color: !item.isHaveData ? null : Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              item.name.toString().tr ?? '',
              style: !item.isHaveData
                  ? const TextStyle()
                  : textMedium.copyWith(
                      color: Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
