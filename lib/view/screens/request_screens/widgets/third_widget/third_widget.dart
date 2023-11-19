import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/controller/where_to_go_controller.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/where_to_go_screen.dart';

import '../../../../../enum/request_states.dart';
import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/images.dart';
import '../../../../../util/text_style.dart';
import '../../../../widgets/custom_button.dart';
import '../../../map/controller/map_controller.dart';
import '../../../parcel/widgets/tolltip_widget.dart';
import '../../../ride/controller/ride_controller.dart';
import '../../../where_to_go/controller/create_trip_controller.dart';
import '../../controller/base_map_controller.dart';
import '../../controller/finding_driver_controller.dart';

class ThirdWidget extends StatelessWidget {
  //
  final bool whoWillPay;

  const ThirdWidget({Key? key, required this.whoWillPay}) : super(key: key);
  // final
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindingDriverController>(
        init: FindingDriverController()..handelSocket(),
        builder: (findingDriverController) {
          return Column(
            children: [
              const TollTipWidget(title: "driver3"),
              K.sizedBoxH0,
              K.sizedBoxH0,
              GetBuilder<BaseMapController>(
                init: BaseMapController(),
                builder: (baseMapController) => LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  animation: true,
                  animationDuration: 1000,
                  restartAnimation: true,
                  lineHeight: 4.0,
                  percent: baseMapController.percent / 100,
                  progressColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).hintColor,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraLarge),
                  child: Image.asset(Images.findinDeliveryman, width: 70)),
              Text("finding_driver".tr,
                  style: textMedium.copyWith(
                    fontSize: Dimensions.fontSizeOverLarge,
                    color: Theme.of(context).primaryColor,
                  )),
              const SizedBox(
                height: Dimensions.paddingSizeLarge * 2,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    buttonText: 'cancel_searching'.tr,
                    radius: Dimensions.radiusOverLarge,
                    transparent: true,
                    borderWidth: 1,
                    showBorder: true,
                    borderColor: Theme.of(Get.context!).primaryColor,
                    onPressed: () async {
                      Get.find<MapController>().notifyMapController();
                      Get.find<WhereToGoController>().clearData;
                      // Get.find<BaseMapController>().checkRideStateToFindingDriver();
                      Get.find<CreateATripController>().cancelATrip();
                      // ...

                      Get.find<BaseMapController>().update();
                      // Get.back();

                      // Get.offUntil(SetDestinationScreen, (route) => false);
                    },
                    fontSize: Dimensions.fontSizeDefault,
                  )),
                ],
              ),
              K.sizedBoxH2,
            ],
          );
        });
  }
}
