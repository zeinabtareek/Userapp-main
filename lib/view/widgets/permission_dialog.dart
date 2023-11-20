import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_strings.dart';
import '../../util/dimensions.dart';
import 'custom_button.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SizedBox(
          width: 300,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.add_location_alt_rounded,
                color: Theme.of(context).primaryColor, size: 100),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Text(
              Strings.youDeniedLocationPermission.tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Row(children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
                    minimumSize: const Size(1, 50),
                  ),
                  child: Text(Strings.no.tr),
                  onPressed: () async {
                    // await Geolocator.openAppSettings();

                    Get.back(result: false);
                  },
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                  child: CustomButton(
                      buttonText: Strings.yes.tr,
                      onPressed: () async {
                        // await Geolocator.openAppSettings();

                        Get.back(result: true);
                      })),
            ]),
          ]),
        ),
      ),
    );
  }
}

class ServiceDialog extends StatelessWidget {
  const ServiceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SizedBox(
          width: 300,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.add_location_alt_rounded,
                color: Theme.of(context).primaryColor, size: 100),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Text(
              Strings.locationServicesDisabled.tr,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Row(children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
                    minimumSize: const Size(1, 50),
                  ),
                  child: Text(Strings.no.tr),
                  onPressed: () async {
                    // await Geolocator.openAppSettings();

                    Get.back(result: false);
                  },
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                  child: CustomButton(
                      buttonText: Strings.yes.tr,
                      onPressed: () async {
                        // await Geolocator.openAppSettings();

                        Get.back(result: true);
                      })),
            ]),
          ]),
        ),
      ),
    );
  }
}
