import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ride_sharing_user_app/enum/request_states.dart';
import 'package:ride_sharing_user_app/view/screens/request_screens/widgets/fixed_header.dart';

import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/images.dart';
import '../../../../../util/text_style.dart';
import '../../../../widgets/confirmation_dialog.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_body.dart';
import '../../../../widgets/custom_button.dart';
import '../../../history/model/history_model.dart';
import '../../../history/widgets/rider_details.dart';
import '../../../map/controller/map_controller.dart';
import '../../../parcel/widgets/contact_widget.dart';
import '../../../parcel/widgets/parcel_expendable_bottom_sheet.dart';
import '../../../parcel/widgets/route_widget.dart';
import '../../../parcel/widgets/tolltip_widget.dart';
import '../../../payment/payment_screen.dart';
import '../../../ride/controller/ride_controller.dart';
import '../../../ride/widgets/confirmation_trip_dialog.dart';
import '../../../ride/widgets/estimated_fare_and_distance.dart';
import '../../../ride/widgets/get_price_widget.dart';
import '../../../ride/widgets/ride_details_widget.dart';
import '../../../ride/widgets/rider_details_widget.dart';
import '../../../ride/widgets/rise_fare_widget.dart';
import '../../../where_to_go/controller/create_trip_controller.dart';
import '../../controller/base_map_controller.dart';
import '../../widgets/common_map_widget.dart';
import '../../widgets/fifth_widget/fifth_widget.dart';
import '../../widgets/first_widget/initial_widget.dart';

// import '../../widgets/fourth_widget/fourth_widget.dart';
import '../../widgets/fourth_widget/fourth_widget.dart';
import '../../widgets/second_widget/second_widget.dart';
import '../../widgets/third_widget/third_widget.dart';

class BaseMapScreen extends StatelessWidget {
  const BaseMapScreen({
    Key? key,
    required this.points,
  }) : super(key: key);

  final List<LatLng> points;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BaseMapController());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      //   backgroundColor: Theme.of(context).shadowColor,
      body: CustomBody(
          appBar: CustomAppBar(
            title: Strings.theDeliverymanNeedYou.tr,
            onBackPressed: controller.onBackPressed,
          ),
          body: ExpandableBottomSheet(
            key: controller.key,
            enableToggle: false,

            background: GetBuilder<BaseMapController>(
              init: BaseMapController(),
              builder: (controller) {
                return CommonMapWidget(
                  markers: controller.markers,
                  polylines: controller.polylines,
                  mapId: controller.mapCompleter.future
                      .then<int>((value) => value.mapId),
                  onMapCreated: controller.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: controller.initialPosition!,
                    zoom: 12,
                  ),
                );
              },
            ),

            expandableContent: Container(
              //   height: 500,
              // color: Colors.white,
              color: Theme.of(context).scaffoldBackgroundColor,
              // color: Colors.red,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: SingleChildScrollView(
                child: Obx(
                  () => controller.widgetNumber.value ==
                          request[RequestState.initialState]
                      ? InitialRequestWidget(
                          image: Images.car,
                          title: Get.find<RideController>()
                                  .selectedSubPackage
                                  .value
                                  ?.categoryTitle
                                  .toString() ??
                              '',
                        )
                      //     BikeRideDetailsWidgets(
                      //       image: Images.car  ,
                      //       title: Get.find<RideController>().selectedPackage.value?.categoryTitle.toString()??'',
                      //     )
                      : controller.widgetNumber.value ==
                              request[RequestState.getPriceState]
                          ? SecondWidget(
                              image: Images.car,
                              title: Get.find<RideController>()
                                      .selectedSubPackage
                                      .value
                                      ?.categoryTitle
                                      .toString() ??
                                  '',
                              points: points,
                            )

                          ///Get Price
                          : controller.widgetNumber.value ==
                                  request[RequestState.findDriverState]
                              ? const ThirdWidget(
                                  whoWillPay: true,
                                )

                              ///Find Driver
                              : (controller.widgetNumber.value ==
                                          request[
                                              RequestState.driverAcceptState] ||
                                      controller.widgetNumber.value ==
                                          request[RequestState
                                              .tripOngoing]) //tripOngoing
                                  ? const FourthWidget()

                                  ///Ride Details tripFinishedState

                                  : controller.widgetNumber.value ==
                                          request[
                                              RequestState.tripFinishedState]
                                      ?
                                      //                ///here you paymenmt
                                      FifthWidget()
                                      : const SizedBox(),
                ), // ),
              ),
            ),

            persistentHeader: fixedHeader(),
            persistentContentHeight: controller.persistentContentHeight,

            onIsContractedCallback: () => print('contracted'),
            onIsExtendedCallback: () => print('expanded'),
            animationDurationExtend: const Duration(milliseconds: 500),
            animationDurationContract: const Duration(milliseconds: 250),

            animationCurveExpand: Curves.bounceOut,
            animationCurveContract: Curves.ease,

            // expandableContent: Container(height: 600,color: Colors.green,width: Get.width,),
            // background: Container(height: 600,color: Colors.red,width: Get.width,),
          )),
    );
  }
}
