import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/repository/search_service.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/widget/input_field_for_set_route.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/widget/saved_recent_items.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/widget/suggested_route_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

import '../../../enum/view_state.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../choose_from_map/choose_from_map_screen.dart';
import 'controller/where_to_go_controller.dart';

class SetDestinationScreen extends StatelessWidget {
  final String? address;

  const SetDestinationScreen({Key? key, this.address}) : super(key: key);

  // @override
  // void initState() {
  //   super.initState();
  //   fromRouteController.text = widget.address ?? "";
  // }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WhereToGoController(setMapRepo: Get.find()));
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.bodyMedium!.color),
      ),
      body: GetBuilder<WhereToGoController>(builder: (setMapController) {
        return SingleChildScrollView(
            child: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeSmall),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.paddingSizeSmall)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                Dimensions.paddingSizeSmall,
                                Dimensions.paddingSizeLarge,
                                Dimensions.paddingSizeSmall,
                                0),
                            child: Column(
                              children: [
                                SizedBox(
                                    width: Dimensions.iconSizeLarge,
                                    child: Image.asset(
                                      Images.currentLocation,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                          .withOpacity(.75),
                                    )),
                                SizedBox(
                                    height: 70,
                                    width: 10,
                                    child: CustomDivider(
                                      height: 5,
                                      dashWidth: .75,
                                      axis: Axis.vertical,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    )),
                                SizedBox(
                                    width: Dimensions.iconSizeLarge,
                                    child: Image.asset(
                                      Images.activityDirection,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                          .withOpacity(.75),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: K.fixedPadding0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputField(
                                    controller: controller.fromRouteController,
                                    node: controller.fromNode,
                                    hint: Strings.enterCurrentLocationRoute.tr,
                                    onTap: () async => await controller
                                        .checkPermissionBeforeNavigation(
                                            context),
                                    onChange:(v){
                                      controller.searchPlacesFrom(v);
                                      print(v);
                                  }
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical:
                                            Dimensions.paddingSizeExtraSmall),
                                    child: Text(Strings.to.tr,
                                        style: textRegular.copyWith(
                                            color: Colors.white)),
                                  ),
                                  ListView.builder(
                                      itemCount:
                                          setMapController.currentExtraRoute,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: Dimensions
                                                    .paddingSizeDefault),
                                            child: InputField(
                                              controller: controller
                                                  .extraRouteController,
                                              node: controller.extraNode,
                                              hint: Strings.enterExtraRoute.tr,
                                              onTap: () async {
                                                Get.to(() =>
                                                    ChooseFromMapScreen());
                                              },
                                            ));

                                        //                           );
                                      }),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InputField(
                                          controller:
                                              controller.toRouteController,
                                          hint:
                                              Strings.enterDestinationRoute.tr,
                                          node: controller.toRoutNode,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: Dimensions.paddingSizeSmall,
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            setMapController.setExtraRoute(),
                                        child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(.35),
                                              borderRadius: BorderRadius
                                                  .circular(Dimensions
                                                      .paddingSizeExtraSmall),
                                            ),
                                            child: const Icon(Icons.add,
                                                color: Colors.white)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeDefault),
                                  setMapController.addEntrance
                                      ? SizedBox(
                                          width: 200,
                                          child: InputField(
                                            controller:
                                                controller.entranceController,
                                            node: controller.entranceNode,
                                            hint: Strings.enterEntrance.tr,
                                          ))
                                      : GestureDetector(
                                          onTap: () =>
                                              setMapController.setAddEntrance(),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                  height: 25,
                                                  child: Image.asset(
                                                      Images.curvedArrow)),
                                              const SizedBox(
                                                  width: Dimensions
                                                      .paddingSizeSmall),
                                              Container(
                                                transform:
                                                    Matrix4.translationValues(
                                                        0, 10, 0),
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.add,
                                                        color: Colors.white),
                                                    Text(
                                                      Strings.addEntrance.tr,
                                                      style: textMedium.copyWith(
                                                          color: Colors.white
                                                              .withOpacity(.75),
                                                          fontSize: Dimensions
                                                              .fontSizeLarge),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            Dimensions.paddingSizeExtraLarge,
                            Dimensions.paddingSizeSmall,
                            Dimensions.paddingSizeExtraLarge,
                            Dimensions.paddingSizeExtraLarge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.youCanAddMultipleRouteTo.tr,
                              style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Colors.white.withOpacity(.75)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const SuggestedRouteScreen());
                                Get.find<RideController>()
                                    .updateRideCurrentState(RideState.initial);
                              },
                              child: Text(
                                Strings.done.tr,
                                style: textRegular.copyWith(
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary
                                        .withOpacity(.75)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    Dimensions.paddingSizeDefault,
                    0,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeDefault),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius:
                          BorderRadius.circular(Dimensions.paddingSizeSmall)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SavedAndRecentItem(
                        title: Strings.saved.tr,
                        icon: Images.homeOutline,
                        subTitle: '1 Willich St Singapore',
                        isSeeMore: true,
                      ),
                      SavedAndRecentItem(
                        title: 'saved',
                        icon: Images.editProfileLocation,
                        subTitle: 'Bidadari Park Dive Singapore',
                        isSeeMore: true,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.to(ChooseFromMapScreen());
                          },
                          child: SavedAndRecentItem(
                              title: Strings.setFromMap.tr,
                              icon: Images.setFromMap,
                              subTitle: Strings.chooseFromMap.tr)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    Dimensions.paddingSizeDefault,
                    0,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeDefault),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius:
                          BorderRadius.circular(Dimensions.paddingSizeSmall)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Text(
                          Strings.suggestions.tr,
                          style: textMedium.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: K.fixedPadding0,
                                child: Row(
                                  children: [
                                    Container(
                                        padding: K.fixedPadding0,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(.08),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions
                                                    .paddingSizeExtraSmall)),
                                        child: Icon(
                                          Icons.place_outlined,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.5),
                                        )),
                                    const SizedBox(
                                      width: Dimensions.paddingSizeSmall,
                                    ),
                                    const Text('Uttara, Sector 12'),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Text(
                          Strings.setFromMap.tr,
                          style: textMedium.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          //Get.find<RiderMapController>().setStayOnlineTypeIndex(9);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              Dimensions.paddingSizeDefault,
                              0,
                              Dimensions.paddingSizeDefault,
                              Dimensions.paddingSizeDefault),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeExtraSmall),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(.08),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.paddingSizeExtraSmall)),
                                child: SizedBox(
                                    width: Dimensions.iconSizeMedium,
                                    child: Image.asset(Images.setFromMap)),
                              ),
                              const SizedBox(
                                width: Dimensions.paddingSizeSmall,
                              ),
                              Text(
                                Strings.chooseFromMap.tr,
                                style: textRegular.copyWith(
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        Obx(() =>    controller.searchResultsFrom.isNotEmpty?   controller.state == ViewState.busy
                  ? const Center(
                child: CupertinoActivityIndicator(),
              )
                  : Positioned(
              top: 280,
              left: 15,
              right: 15,
              child:
                  // GetBuilder<MapController>(
                  //     init :MapController(),
                  //     builder:(controller) {
                  //       if((controller.searchresultsfrom!=null && controller.searchresultsfrom.length!=0) ) {
                  //         return

                  Container(
                height: 700,
                width: 100,
                padding:  EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    // color: Theme.of(context)
                    //     .colorScheme
                    //     .onSecondary,
                    color:Colors.white,
                    // color:Color(0xffE1EDDB),
        borderRadius: BorderRadius.only(  topLeft: Radius.circular(15.0),topRight:   Radius.circular(15.0),),
                  //   backgroundBlendMode: BlendMode.darken
                ),
                child:  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    // itemCount: 33,
                    padding: EdgeInsets.zero,
                    itemCount: controller.searchResultsFrom.length!=0?controller.searchResultsFrom.length:2,
                    itemBuilder: (context, index) {
                      return   Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular( 10),
                            ),

                            child: ListTile(
                              leading: Icon(Icons.location_on,color: Theme.of(Get.context!).primaryColor,),
                                title: Text(
                                   controller.searchResultsFrom[index].description
                                      .toString(),maxLines: 1,
                                   style: const TextStyle(
                                    color: Colors.black,
                                ),
                                ),
                                subtitle: Text( 'controller.se ', style:   TextStyle(
                                    color: Colors.black.withOpacity(.8),
                                    fontSize: 14
                                ),),
                                 onTap: () async {}),
                          ),
                          const Divider(thickness: 1 ,),
                        ],
                      );
                    })),
              ):SizedBox())
        ]),);
      }),
    );
  }
}
