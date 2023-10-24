import 'dart:async';

import 'package:get/get.dart';

import '../../map/controller/map_controller.dart';
import '../../payment/payment_screen.dart';
import '../../ride/widgets/confirmation_trip_dialog.dart';

class TripFinishedController extends GetxController{





  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // TODO: this will be removed after socket if the trip is is finished

    Timer(const Duration(seconds: 7), () async {

    Get.dialog(
        const ConfirmationTripDialog(
          isStartedTrip: false,
        ),
        barrierDismissible: false);
    await Future.delayed(const Duration(seconds: 5));
    // update(RideState.completeRide);
    //Get.back();
    Get.find<MapController>().notifyMapController();
    Get.off(() => const PaymentScreen());
  });
  }
}