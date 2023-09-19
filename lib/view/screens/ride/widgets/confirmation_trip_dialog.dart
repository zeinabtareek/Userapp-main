import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class ConfirmationTripDialog extends StatelessWidget {
  final bool isStartedTrip;

  const ConfirmationTripDialog({Key? key, required this.isStartedTrip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        isStartedTrip
            ? Text('on_the_way_to_your_destination'.tr,
                textAlign: TextAlign.center,
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeOverLarge,
                  color: Theme.of(context).cardColor,
                ))
            : Text('calculating_fare'.tr,
                style: textMedium.copyWith(
                    fontSize: Dimensions.fontSizeOverLarge,
                    color: Theme.of(context).cardColor)),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        const LoadingOverlayPro(
          isLoading: true,
          backgroundColor: Colors.transparent,
          child: SizedBox(),
        )
      ])),
    );
  }
}
