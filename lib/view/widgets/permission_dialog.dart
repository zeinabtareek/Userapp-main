
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SizedBox(
          width: 300,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.add_location_alt_rounded,
                color: Theme.of(context).primaryColor, size: 100),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Text(
              "you Denied Location Permission",
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
                  child: const Text("No"),
                  onPressed: () async{
                    await Geolocator.openAppSettings();

                    Get.back();
                  },
                ),
              ),
               const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                  child: CustomButton(
                      buttonText: "yes",
                      onPressed: () async {
                        await Geolocator.openAppSettings();

                        Get.back();
                      })),
            ]),
          ]),
        ),
      ),
    );
  }
}
