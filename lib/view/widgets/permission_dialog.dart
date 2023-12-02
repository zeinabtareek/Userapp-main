import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

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

                    Get.back(result: true);
                  },
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                  child: CustomButton(
                      buttonText: Strings.yes.tr,
                      onPressed: () async {
                        // await Geolocator.openAppSettings();

                        Get.back(result:!(await requestLocationPermission()));
                      })),
            ]),
          ]),
        ),
      ),
    );
  }

  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      // Location permission granted, you can now access the user's location.
      // Implement your location-related functionality here.
      return Future.value(false);
    } else if (status.isDenied) {
      // Permission request denied by the user.

      return Future.value(true);
    } else if (status.isPermanentlyDenied) {
      // The user opted to never ask for the permission again.
      // You may want to navigate to the app settings so the user can manually grant permission.
      return Future.value(true);
    }else{
      return Future.value(true);
    }
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
