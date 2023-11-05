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
  BaseMapScreen({
    Key? key,
    required this.points,
  }) : super(key: key);

  final controller = Get.put(BaseMapController());

  final List<LatLng> points;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomBody(
            appBar: CustomAppBar(
                title: Strings.theDeliverymanNeedYou.tr,
                onBackPressed: controller.onBackPressed),
            body: GetBuilder<BaseMapController>(
                init: BaseMapController(),
                builder: (controller) {
                  return ExpandableBottomSheet(
                    key: controller.key,
                    enableToggle: true,
                    background:

                        ///Map background
                        CommonMapWidget(
                      mapId: controller.mapCompleter.future
                          .then<int>((value) => value.mapId),
                      onMapCreated: controller.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: controller.initialPosition,
                        zoom: 16,
                      ),
                    ),

                    expandableContent: Container(
                      // height: 500,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Obx(
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
                                              request[
                                                  RequestState.findDriverState]
                                          ? const ThirdWidget(
                                              whoWillPay: true,
                                            )

                                          ///Find Driver
                                          : (controller.widgetNumber.value ==
                                                      request[RequestState
                                                          .driverAcceptState] ||
                                                  controller
                                                          .widgetNumber.value ==
                                                      request[RequestState
                                                          .tripOngoing]) //tripOngoing
                                              ? const FourthWidget()

                                              ///Ride Details tripFinishedState

                                              : controller.widgetNumber.value ==
                                                      request[RequestState
                                                          .tripFinishedState]
                                                  ?
                                                  //                ///here you paymenmt
                                                  FifthWidget()
                                                  : const SizedBox(),
                            ), // ),
                          ],
                        ),
                      ),
                    ),
                    persistentHeader: fixedHeader(),
                    //optional
                    //This is a widget aligned to the bottom of the screen and stays there.
                    ///footer
                    // persistentFooter: Container(
                    //   color: Colors.red,
                    //   height: 60,
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.max,
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: <Widget>[
                    //       IconButton(
                    //           icon: const Icon(
                    //             Icons.arrow_upward,
                    //             color: Colors.white,
                    //           ),
                    //           onPressed: () {
                    //             // controller.key.currentState!.contract();
                    //             if( controller.key.currentState!.expansionStatus==controller.key.currentState!.expand){
                    //               print('object');
                    //             }
                    //             controller.key.currentState!.expand();
                    //             controller.expansionStatus.value =
                    //                 controller.key.currentState!.expansionStatus;
                    //             controller.widgetNumber.value = request[RequestState.initialState]!;
                    //             // controller.widgetNumber.value = 0;
                    //           }),
                    //       IconButton(
                    //         icon: Icon(
                    //           Icons.cloud,
                    //           color: Colors.white,
                    //         ),
                    //         onPressed: () {
                    //           controller.key.currentState!.contract();
                    //           controller.expansionStatus.value =
                    //               controller.key.currentState!.expansionStatus;
                    //           // controller.widgetNumber.value = 1;
                    //           controller.widgetNumber.value = request[RequestState.getPriceState]!;
                    //         },
                    //       ),
                    //       IconButton(
                    //           icon: const Icon(
                    //             Icons.arrow_downward,
                    //             color: Colors.white,
                    //           ),
                    //           onPressed: () {
                    //             controller.widgetNumber.value = 2;
                    //
                    //             controller.key.currentState!.expand();
                    //           }),
                    //     ],
                    //   ),
                    // ),

                    //optional
                    //The content extend will be at least this height.
                    persistentContentHeight: controller.persistentContentHeight,
                    //optional

                    onIsContractedCallback: () => print('contracted'),
                    onIsExtendedCallback: () => print('expanded'),

                    //optional; default: Duration(milliseconds: 250)
                    //The durations of the animations.
                    animationDurationExtend: const Duration(milliseconds: 500),
                    animationDurationContract:
                        const Duration(milliseconds: 250),

                    //optional; default: Curves.ease
                    //The curves of the animations.
                    animationCurveExpand: Curves.bounceOut,
                    animationCurveContract: Curves.ease,
                  );
                })));
  }
}
