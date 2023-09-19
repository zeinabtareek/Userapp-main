import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class ChooseEfficientVehicleWidget extends StatefulWidget {
  const ChooseEfficientVehicleWidget({Key? key}) : super(key: key);

  @override
  State<ChooseEfficientVehicleWidget> createState() =>
      _ChooseEfficientVehicleWidgetState();
}

class _ChooseEfficientVehicleWidgetState
    extends State<ChooseEfficientVehicleWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(builder: (parcelController) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeDefault),
              child: Text(
                'find_your_best_parcel_delivery_vehicles'.tr,
                style:
                    textMedium.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            Text(
              'find_your_best_parcel_delivery_vehicles_hint'.tr,
              style: textMedium.copyWith(color: Theme.of(context).hintColor),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeSmall),
              child: Text(
                'or'.tr,
                style: textMedium.copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: Dimensions.fontSizeLarge),
              ),
            ),
            CustomButton(
              buttonText: 'choose_the_efficient_vehicles'.tr,
              fontSize: Dimensions.fontSizeDefault,
              onPressed: () {
                Get.find<ParcelController>()
                    .updateParcelState(ParcelDeliveryState.findingRider);
                Get.find<MapController>().notifyMapController();
              },
            ),
          ],
        ),
      );
    });
  }
}
