import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/chat/chat_screen.dart';
import 'package:ride_sharing_user_app/view/screens/chat/repository/chat_repo.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/repository/parcel_repo.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/custom_oval.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/images.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/custom_image.dart';
import '../../chat/controller/chat_controller.dart';
import '../../chat/message_screen.dart';
import '../../history/model/history_model.dart';
import '../../home/widgets/home_map_view.dart';
import '../../ride/widgets/rider_details_widget.dart';
import '../controller/parcel_controller.dart';

class LiveTrackingScreenForParcel extends GetView<ParcelController> {
  final HistoryData item;

  LiveTrackingScreenForParcel({
    super.key,
    required this.item,
  }) {
    // controller.showOrderById(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
          appBar: CustomAppBar(
            title: Strings.liveTracking.tr,
            showBackButton: true,
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () {
              return controller.showOrderById(item);
            },
            child: GetBuilder<ParcelController>(
              init: ParcelController(parcelRepo: ParcelRepo())
                ..showOrderById(item),
              builder: (controller) {
                return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: Dimensions.fontSizeSmall,
                        right: Dimensions.fontSizeExtraLarge,
                        left: Dimensions.fontSizeExtraLarge,
                      ),
                      child: Column(
                        children: [
                          GetBuilder<ParcelController>(
                            builder: (controller) {
                              return Stack(
                                children: [
                                  Container(
                                      decoration: K.shadowBoxDecoration,
                                      height: 400,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.paddingSizeSmall),
                                        child: GoogleMap(
                                            mapType: MapType.normal,
                                            myLocationEnabled: true,
                                            zoomControlsEnabled: true,
                                            myLocationButtonEnabled: true,
                                            markers: controller.markers,
                                            polylines: controller.polylines,
                                            onTap: (p) {
                                              print(p);
                                            },
                                            onCameraMove: (poistion) {
                                              print(poistion);
                                            },
                                            initialCameraPosition:
                                                CameraPosition(
                                                    target: controller
                                                        .pickedPoints.first,
                                                    zoom: 15),
                                            onMapCreated: (gController) async {
                                              controller.controller =
                                                  gController;
                                              // controller
                                              //         .mapViewHelperMapCompleter =
                                              gController;
                                              controller.pickedPoints = [
                                                LatLng(
                                                  double.parse(item.from!.lat
                                                      .toString()),
                                                  double.parse(
                                                    item.from!.lng.toString(),
                                                  ),
                                                ),
                                                LatLng(
                                                  double.parse(
                                                      item.to!.lat.toString()),
                                                  double.parse(
                                                    item.to!.lng.toString(),
                                                  ),
                                                )
                                              ];
                                              controller
                                                  .drawMarkersIfHavePickedPoints();
                                              controller
                                                  .drawPolylineIfHavePickedPoints();
                                              // controller.zoomToFit(
                                              //     points:
                                              //         controller.pickedPoints);
                                            }),
                                      )),
                                  // Positioned(
                                  //     bottom: Dimensions.iconSizeSmall,
                                  //     right: Dimensions.iconSizeSmall,
                                  //     child: Row(
                                  //       children: [
                                  //         FloatingActionButton(
                                  //             onPressed: () {},
                                  //             backgroundColor: K.lightGreen2,
                                  //             child: const Icon(
                                  //               Icons.add,
                                  //               color: Colors.black,
                                  //             )),
                                  //         K.sizedBoxW0,
                                  //         FloatingActionButton(
                                  //             onPressed: () {},
                                  //             backgroundColor: K.lightGreen2,
                                  //             child: const Icon(
                                  //               Icons.remove,
                                  //               color: Colors.black,
                                  //             )),
                                  //       ],
                                  //     ))
                                ],
                              );
                            },
                          ),
                          K.sizedBoxH0,
                          K.sizedBoxH0,
                          Container(
                            decoration:
                                K.shadowBoxDecorationWithPrimary.copyWith(),
                            padding: K.fixedPadding0,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeExtraSmall),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              width: Dimensions.iconSizeMedium,
                                              child: Image.asset(
                                                Images.currentLocation,
                                              )),
                                          SizedBox(
                                              height: 45.h,
                                              width: 20,
                                              child: const CustomDivider(
                                                height: 2,
                                                dashWidth: 1,
                                                axis: Axis.vertical,
                                                color: Colors.white,
                                              )),
                                          SizedBox(
                                              width: Dimensions.iconSizeMedium,
                                              child: Image.asset(
                                                  Images.activityDirection,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'from'.tr,
                                          style: textRegular.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          item.from?.location ?? "",
                                          // parcelController.senderAddressController.text,
                                          style: textRegular.copyWith(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                            height:
                                                Dimensions.paddingSizeSmall),
                                        Text(
                                          'to'.tr,
                                          style: textRegular.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),

                                        ///extra routes

                                        const SizedBox(
                                            height:
                                                Dimensions.paddingSizeSmall),
                                        Text(
                                          item.to?.location ?? "",

                                          // parcelController.receiverAddressController.text,
                                          style: textRegular.copyWith(
                                              color: Colors.white),
                                          // style: textRegular.copyWith(
                                          //     color: colorText ?? Theme.of(context).shadowColor),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          /////////
                          K.sizedBoxH0,
                          K.sizedBoxH0,
                          Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CustomImage(
                                    height: Dimensions.orderStatusIconHeight,
                                    width: Dimensions.orderStatusIconHeight,
                                    image: item.driver?.img ?? "",
                                  )),
                              K.sizedBoxW0,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ("${item.driver?.firstName ?? ""} ${item.driver?.lastName ?? ""}") ??
                                        "",
                                    style: K.semiBoldBlackTextStyle,
                                  ),
                                  Text(
                                    ("${item.driver?.vehicle?.brand ?? ""} ${item.driver?.vehicle?.model ?? ""}") ??
                                        "",
                                    style: K.hintSmallTextStyle,
                                  ),
                                  K.sizedBoxH0,
                                ],
                              ),
                              const Spacer(),
                              customOval(
                                Icon(Icons.message_outlined,
                                    color: Theme.of(context).primaryColor),
                                color: Theme.of(context).cardColor,
                                borderColor: Theme.of(context).primaryColor,
                                onTap: () {
                                  print('*************** TAG LiveTrackingScreen');

                                  Get.to(() => const MessageScreen(),
                                      binding: BindingsBuilder(() {
                                    // ignore: avoid_single_cascade_in_expression_statements
                                    if (Get.isRegistered<ChatController>()) {
                                      Get.find<ChatController>()
                                        ..initChat()
                                        ..toNewChat(item.id!);
                                    } else {
                                      Get.put(
                                          ChatController(chatRepo: ChatRepo()))
                                        ..initChat()
                                        ..toNewChat(item.id!);
                                    }
                                  }));
                                },
                              ),
                              K.sizedBoxW0,
                              customOval(
                                const Icon(Icons.phone, color: Colors.white),
                                color: Theme.of(context).primaryColor,
                                borderColor: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // K.sizedBoxW0,
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    Strings.statusOrder.tr,
                                    style: K.hintMediumTextStyle,
                                  )),
                              K.sizedBoxW0,
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    Strings.packageWeight.tr,
                                    style: K.hintMediumTextStyle,
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                backgroundColor: K.lightGreen,
                                isLoading: false,
                                textColor: Theme.of(Get.context!).primaryColor,
                                height: 30,
                                buttonText: item.status?.tr ?? "",
                                width: 200,
                                onPressed: () {},
                                radius: 50,
                              ),
                              Text(
                                item.parcelDetails?.parcelWeight ?? "",
                                style: K.semiBoldBlackTextStyle,
                              ),
                              K.sizedBoxW0,
                            ],
                          ),
                          K.sizedBoxH0,
                          K.sizedBoxH0,
                        ],
                      ),
                    ));
              },
            ),
          )),
    );
  }
}
