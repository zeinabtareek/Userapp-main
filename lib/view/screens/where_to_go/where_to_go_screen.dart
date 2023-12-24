import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/ride/model/address_model.dart';

import '../../../enum/view_state.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/text_style.dart';
import '../../widgets/custom_divider.dart';
import '../home/controller/address_controller.dart';
import '../home/model/categoty_model.dart';
import 'controller/create_trip_controller.dart';
import 'controller/where_to_go_controller.dart';
import 'widget/input_field_for_set_route.dart';
import 'widget/saved_recent_items.dart';
import 'widget/search_list_widget.dart';

class SetDestinationScreen extends StatelessWidget {
  String? address;
  final CategoryModel? categoryModel;

  final bool fromCat;
  SetDestinationScreen(
      {Key? key, this.address, this.categoryModel, required this.fromCat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(WhereToGoController(setMapRepo: Get.find()));
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.bodyMedium!.color),
      ),
      body: GetBuilder<WhereToGoController>(
          init: WhereToGoController(),
          id: "WhereToGoController",
          builder: (whereToGoController) {
            // return const SizedBox();
            return SingleChildScrollView(
              controller: whereToGoController.scrollController,
              child: Stack(children: [
                Padding(
                  padding: K.fixedPadding0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeSmall)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FromToDividerVertical(),
                                Expanded(
                                  child: Padding(
                                    padding: K.fixedPadding0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("from".tr,
                                            style: textRegular.copyWith(
                                                color: Colors.white)),
                                        const FromTextField(),
                                        Text(Strings.to.tr,
                                            style: textRegular.copyWith(
                                                color: Colors.white)),
                                        ListView.builder(
                                          itemCount: whereToGoController
                                              .currentExtraRouteLength,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.paddingSizeSmall),
                                          itemBuilder: (context, index) {
                                            TextEditingController
                                                itemController =
                                                whereToGoController
                                                        .extraTextEditingControllers[
                                                    index];
                                            FocusNode itemFocusNode =
                                                whereToGoController
                                                    .extraFocusNodes[index];
                                            return InputField(
                                              enabled: true,
                                              readOnly: true,
                                              controller: itemController,
                                              node: itemFocusNode,
                                              hint: Strings.enterExtraRoute.tr,
                                              onTap: () async =>
                                                  await whereToGoController
                                                      .checkPermissionBeforeNavigation(
                                                          PointType.extra,
                                                          context,
                                                          index: index),
                                              onClear: () {
                                                whereToGoController.extraPoints
                                                    .removeAt(index);
                                                whereToGoController
                                                    .extraTextEditingControllers
                                                    .removeAt(index);
                                                // itemController.text = '';
                                                whereToGoController
                                                    .extraFocusNodes
                                                    .removeAt(index);
                                                whereToGoController.update(
                                                    ['WhereToGoController']);
                                              },
                                            );
                                          },
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: InputField(
                                                enabled: true,
                                                readOnly: true,
                                                controller: whereToGoController
                                                    .toRouteController,
                                                hint: Strings
                                                    .enterDestinationRoute.tr,
                                                node: whereToGoController
                                                    .toRoutNode,
                                                onClear: () {
                                                  whereToGoController
                                                      .destination = null;
                                                  whereToGoController
                                                      .toRouteController
                                                      .clear();
                                                  whereToGoController.update(
                                                      ['WhereToGoController']);
                                                },
                                                onTap: () async =>
                                                    await whereToGoController
                                                        .checkPermissionBeforeNavigation(
                                                  PointType.to,
                                                  context,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width:
                                                  Dimensions.paddingSizeSmall,
                                            ),
                                            const AddOrMinIconBtn()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const DoneBtn()
                          ],
                        ),
                      ),
                      K.sizedBoxH0,
                      SavedPlaces(
                        onItemTap: (item) {
                          _showSelectPointByPressBottomSheet(context, (type) {
                            whereToGoController.selectPointByPress(type, item);
                          });
                        },
                      ),
                      K.sizedBoxH0,
                      Container(
                        decoration: K.boxDecorationWithPrimaryBorder,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: K.fixedPadding0,
                              child: Text(
                                Strings.suggestions.tr,
                                style: textMedium.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimensions.fontSizeLarge),
                              ),
                            ),

                            ///suggestions

                            GetBuilder<AddressController>(
                              autoRemove: false,
                              builder: (addressController) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: addressController
                                      .suggestionAddressModel.data?.length,
                                  // itemCount:  setMapController.listOfSuggestedPlaces.length,
                                  itemBuilder: (context, index) {
                                    var item = addressController
                                        .suggestionAddressModel.data?[index];
                                    return InkWell(
                                      child: Padding(
                                        padding: K.fixedPadding1,
                                        child: Row(
                                          children: [
                                            Container(
                                                // padding: K.fixedPadding0,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .hintColor
                                                        .withOpacity(.08),
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .paddingSizeExtraSmall)),
                                                child: Icon(
                                                  Icons.place_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(.5),
                                                )),
                                            const SizedBox(
                                              width:
                                                  Dimensions.paddingSizeSmall,
                                            ),
                                            Flexible(
                                              child: Text(
                                                '${item?.location}',
                                                style: textMedium,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        _showSelectPointByPressBottomSheet(
                                            context, (type) {
                                          whereToGoController
                                              .selectPointByPress(type, item!);
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          }),
    );
  }
}

_showSelectPointByPressBottomSheet(
  context,
  Function(PointType pointType) onTap,
) {
  // TODO: tr
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('Set as Source'),
            onTap: () {
              Navigator.pop(context);
              onTap(PointType.from);
            },
          ),
          ListTile(
            title: const Text('Set as Destination'),
            onTap: () {
              Navigator.pop(context);
              onTap(PointType.to);
            },
          ),
          ListTile(
            title: const Text('Set as Extra Route'),
            onTap: () {
              Navigator.pop(context);
              onTap(PointType.extra);
            },
          ),
        ],
      );
    },
  );
}

/*

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Set as Source'),
                onTap: () {
                  _selectAddress('Source');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Set as Destination'),
                onTap: () {
                  _selectAddress('Destination');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Set as Extra Route'),
                onTap: () {
                  _selectAddress('Extra Route');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectAddress(String type) {
    setState(() {
      selectedAddress = '$type: $selectedAddress'; // Update the selected address
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bottom Sheet Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _showBottomSheet,
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.blue,
                child: Text(
                  'Select Address: $selectedAddress',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */
class FromToDividerVertical extends StatelessWidget {
  const FromToDividerVertical({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,
          Dimensions.paddingSizeLarge, Dimensions.paddingSizeSmall, 0),
      child: Column(
        children: [
          SizedBox(
              width: Dimensions.iconSizeLarge,
              child: Image.asset(
                Images.currentLocation,
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(.75),
              )),
          SizedBox(
              height: 70,
              width: 10,
              child: CustomDivider(
                height: 5,
                dashWidth: .75,
                axis: Axis.vertical,
                color: Theme.of(context).colorScheme.onSecondary,
              )),
          SizedBox(
              width: Dimensions.iconSizeLarge,
              child: Image.asset(
                Images.activityDirection,
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(.75),
              )),
        ],
      ),
    );
  }
}

class FromTextField extends StatelessWidget {
  const FromTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhereToGoController>(
      id: 'WhereToGoController',
      builder: (whereToGoController) => InputField(
        enabled: true,
        readOnly: true,
        controller: whereToGoController.fromRouteController,
        node: whereToGoController.fromNode,
        hint: Strings.enterCurrentLocationRoute.tr,
        onClear: () {
          whereToGoController.source = null;

          whereToGoController.fromRouteController.clear();
          whereToGoController.update(['WhereToGoController']);
        },
        onTap: () async {
          await whereToGoController.checkPermissionBeforeNavigation(
            PointType.from,
            context,
          );
        },
      ),
    );
  }
}

class DoneBtn extends StatelessWidget {
  const DoneBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhereToGoController>(
      builder: (controller) {
        return Padding(
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

              ///Done
              GestureDetector(
                onTap:

                    ///Zeinab uncomment this

                    controller.validateData,
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
        );
      },
    );
  }
}

class AddOrMinIconBtn extends StatelessWidget {
  const AddOrMinIconBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhereToGoController>(
      id: 'WhereToGoController',
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            if (controller.isExtraPointsIsLengthIsOne) {
              controller.removeExtraRoute();
            } else {
              controller.addExtraRoute();
            }
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(.35),
              borderRadius:
                  BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
            ),
            child: controller.extraPoints.isEmpty
                ? const Icon(Icons.add, color: Colors.white)
                : const Icon(Icons.clear, color: Colors.white),
          ),
        );
      },
    );
  }
}

class SavedPlaces extends StatelessWidget {
  const SavedPlaces({
    super.key,
    required this.onItemTap,
  });

  final Function(AddressData data)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      autoRemove: false,
      // initState: (state) => Get.find<AddressController>()..getAddressList(),
      builder: (controller) {
        if (controller.addressModel.data != null &&
            (controller.addressModel.data?.isNotEmpty ?? false)) {
          return Container(
            decoration: K.boxDecorationWithPrimaryBorder,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: K.fixedPadding0,
                  child: Text(
                    Strings.saved.tr,
                    style: textMedium.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                ),
                if (controller.addressModel.data != null &&
                    controller.addressModel.data!.isNotEmpty) ...{
                  ...controller.addressModel.data!
                      .where((element) => element.isHaveData)
                      .toList()
                      .map(
                        (e) => SavedAndRecentItem(
                          icon: e.icon!,
                          subTitle: e.name!,
                          isSeeMore: true,
                          addressData: e,
                          onTap: onItemTap,
                        ),
                      )
                      .toList(),
                },
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}


/*
alaa screen 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../enum/view_state.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/text_style.dart';
import '../../widgets/custom_divider.dart';
import '../map/map_screen.dart';
import '../ride/controller/ride_controller.dart';
import 'controller/where_to_go_controller.dart';
import 'widget/input_field_for_set_route.dart';
import 'widget/saved_recent_items.dart';
import 'widget/search_list_widget.dart';

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
    // final controller = Get.put(WhereToGoController(setMapRepo: Get.find()));

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.bodyMedium!.color),
      ),
      body: GetBuilder<WhereToGoController>(
          init: WhereToGoController(),
          builder: (setMapController) {
            return SingleChildScrollView(
              child: Stack(children: [
                Padding(
                  padding: K.fixedPadding0,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeSmall)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ///First Text Field
                                        FocusScope(
                                          child: Focus(
                                            onFocusChange: (focus) {
                                              if (focus) {
                                                setMapController
                                                        .searchController
                                                        .value =
                                                    setMapController
                                                        .fromRouteController;
                                              }
                                            },
                                            child: InputField(
                                              controller: setMapController
                                                  .fromRouteController,
                                              node: setMapController.fromNode,
                                              hint: Strings
                                                  .enterCurrentLocationRoute.tr,
                                              onTap: () async {
                                                await setMapController
                                                    .checkPermissionBeforeNavigation(
                                                        context);
                                              },
                                              onClear: () {
                                                setMapController
                                                    .fromRouteController
                                                    .clear();
                                                setMapController.selectedPoints
                                                    .remove(setMapController
                                                        .selectedPoints.first);
                                              },
                                              onChange: (v) {
                                                setMapController
                                                    .searchPlacesFrom(v);
                                                print(v);
                                              },
                                            ),
                                          ),
                                        ),
                                        Text(Strings.to.tr,
                                            style: textRegular.copyWith(
                                                color: Colors.white)),

                                        ListView.builder(
                                          itemCount: setMapController
                                              .currentExtraRoute,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.paddingSizeSmall),
                                          itemBuilder: (context, index) {
                                            List<TextEditingController>
                                                itemControllers = [
                                              setMapController
                                                  .extraRouteController,
                                              setMapController
                                                  .extraRouteController2,
                                              // controller.  extraRouteController3,
                                            ];
                                            List<FocusNode> itemFocusNodes = [
                                              setMapController.extraNode,
                                              setMapController.extraNode2,
                                              // controller.  extraNode3,
                                            ];
                                            TextEditingController
                                                itemController =
                                                itemControllers[index];
                                            FocusNode itemFocusNode =
                                                itemFocusNodes[index];

                                            return FocusScope(
                                              child: Focus(
                                                onFocusChange: (focus) {
                                                  if (focus) {
                                                    setMapController
                                                        .searchController
                                                        .value = itemController;
                                                  }
                                                },
                                                child: InputField(
                                                  controller: itemController,
                                                  node: itemFocusNode,
                                                  hint: Strings
                                                      .enterExtraRoute.tr,
                                                  onTap: () async =>
                                                      await setMapController
                                                          .checkPermissionBeforeNavigation(
                                                              context),
                                                  onClear: () {
                                                    itemController.clear();
                                                    setMapController
                                                        .selectedPoints
                                                        .removeAt(1);
                                                  },
                                                  onChange: (v) {
                                                    setMapController
                                                        .searchPlacesFrom(v);
                                                    print(v);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: FocusScope(
                                                child: Focus(
                                                  onFocusChange: (focus) {
                                                    if (focus) {
                                                      setMapController
                                                              .searchController
                                                              .value =
                                                          setMapController
                                                              .toRouteController;
                                                    }
                                                  },
                                                  child: InputField(
                                                      controller:
                                                          setMapController
                                                              .toRouteController,
                                                      hint: Strings
                                                          .enterDestinationRoute
                                                          .tr,
                                                      node: setMapController
                                                          .toRoutNode,
                                                      onClear: () {
                                                        setMapController
                                                            .toRouteController
                                                            .clear();
                                                        setMapController
                                                            .selectedPoints
                                                            .removeLast();
                                                      },
                                                      onTap: () async =>
                                                          await setMapController
                                                              .checkPermissionBeforeNavigation(
                                                                  context),
                                                      onChange: (v) {
                                                        setMapController
                                                            .searchPlacesFrom(
                                                                v);
                                                        print(v);
                                                      }),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width:
                                                  Dimensions.paddingSizeSmall,
                                            ),
                                            GestureDetector(
                                              onTap: () => setMapController
                                                  .setExtraRoute(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Strings.youCanAddMultipleRouteTo.tr,
                                    style: textRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Colors.white.withOpacity(.75)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const MapScreen(
                                            fromScreen: 'ride',
                                          ));
                                      // Get.to(() => const SuggestedRouteScreen());
                                      Get.find<RideController>()
                                          .updateRideCurrentState(
                                              RideState.initial);
                                    },
                                    child: Text(
                                      Strings.done.tr,
                                      style: textRegular.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge,
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
                      K.sizedBoxH0,
                      Container(
                        decoration: K.boxDecorationWithPrimaryBorder,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SavedAndRecentItem(
                              title: Strings.saved.tr,
                              icon: Images.homeOutline,
                              subTitle: '1 Willich St Singapore',
                              isSeeMore: true,
                            ),
                            const SavedAndRecentItem(
                              title: 'saved',
                              icon: Images.editProfileLocation,
                              subTitle: 'Bidadari Park Dive Singapore',
                              isSeeMore: true,
                            ),
                            GestureDetector(
                              onTap: setMapController.goToScreenAndRecodeSelect,
                              child: SavedAndRecentItem(
                                  title: Strings.setFromMap.tr,
                                  icon: Images.setFromMap,
                                  subTitle: Strings.chooseFromMap.tr),
                            ),
                          ],
                        ),
                      ),
                      K.sizedBoxH0,
                      Container(
                        decoration: K.boxDecorationWithPrimaryBorder,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: K.fixedPadding0,
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
                                      padding: K.fixedPadding1,
                                      child: Row(
                                        children: [
                                          Container(
                                              // padding: K.fixedPadding0,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .hintColor
                                                      .withOpacity(.08),
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
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
                            // Padding(
                            //   padding: const EdgeInsets.all(
                            //       Dimensions.paddingSizeDefault),
                            //   child: Text(
                            //     Strings.setFromMap.tr,
                            //     style: textMedium.copyWith(
                            //         color: Theme.of(context).primaryColor,
                            //         fontSize: Dimensions.fontSizeLarge),
                            //   ),
                            // ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Get.back();
                            //   },
                            //   child: Padding(
                            //     padding: K.fixedPadding0,
                            //     child: Row(
                            //       children: [
                            //         Container(
                            //           decoration: BoxDecoration(
                            //               color: Theme.of(context)
                            //                   .hintColor
                            //                   .withOpacity(.08),
                            //               borderRadius: BorderRadius.circular(
                            //                   Dimensions.paddingSizeExtraSmall)),
                            //           child: SizedBox(
                            //               width: Dimensions.iconSizeMedium,
                            //               child: Image.asset(Images.setFromMap)),
                            //         ),
                            //         K.sizedBoxW0,
                            //         Text(
                            //           Strings.chooseFromMap.tr,
                            //           style: textRegular.copyWith(
                            //               color: Theme.of(context).primaryColor),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => setMapController.searchResultsFrom.isNotEmpty
                    ? setMapController.state == ViewState.busy
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : Positioned(
                            top: 280,
                            left: 15,
                            right: 15,
                            child: SearchListWidget(
                              listOfSearchedPlaces:
                                  setMapController.searchResultsFrom,
                              onTap: (item) {
                                setMapController
                                    .getLocationOfSelectedSearchItem(item);
                                    
                                setMapController.handlePlaceSelection(
                                    item
                                        .description
                                        .toString(),
                                    setMapController.searchController.value);
                               setMapController.searchResultsFrom.clear();
                              },
                              inputTextField:
                                  setMapController.searchController.value,
                            ),
                          )
                    : const SizedBox())
              ]),
            );
          }),
    );
  }
}


 */