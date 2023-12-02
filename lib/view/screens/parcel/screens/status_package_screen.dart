import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/history_model.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/screens/order_details_screen.dart';

import '../../../../pagination/typedef/page_typedef.dart';
import '../../../../pagination/widgets/paginations_widgets.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/images.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../page-use-case/get_parcel_list_package_use_case.dart';
import '../page-use-case/model/req/get_parcel_list_package_req_model.dart';
import '../widgets/horizontal_taps.dart';
import '../widgets/track_componants/track_order_with_status.dart';

class StatusPackageScreen extends GetView<ParcelController> {
  const StatusPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.reSetFilter();
        Get.back();
        return Future.value(true);
      },
      child: Scaffold(
          body: CustomBody(
        appBar: CustomAppBar(
          title: Strings.statusPackage.tr,
          showBackButton: true,
          centerTitle: true,
          onBackPressed: () {
            controller.reSetFilter();
            Get.back();
            return Future.value(true);
          },
        ),
        body: GetBuilder<ParcelController>(
          builder: (controller) {
            return Column(
              children: [
                K.sizedBoxH0,
                Padding(
                  padding: K.fixedPadding0,
                  child: CustomTextField(
                    hintText: "prompt_message".tr,
                    inputType: TextInputType.name,
                    suffixIcon: Images.close,
                    controller: controller.searchOrderController,
                    prefixIcon: Images.search,
                    fillColor: const Color(0xffEDF7F6),
                    onChanged: (text) => controller.filterSearch(text),
                    onPressedSuffix: () {
                      controller.filterSearch("");
                      controller.searchOrderController.clear();
                    },
                    inputAction: TextInputAction.next,
                  ),
                ),
                const _HorizontalTaps(),
                K.sizedBoxH2,
                Obx(() => Expanded(
                      child: GetBuilder<PaginateParcelListPackageController>(
                          // initState: (state) => controller.reSetFilter(),
                          init: PaginateParcelListPackageController(
                            GetParcelListPackageUseCase(
                              controller.getParcelListPackageReqModel.value,
                            ),
                          ),
                          builder: (con) {
                            return PaginateParcelListPackageView(
                              listPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: (entity) => TrackOrderWithStatus(
                                data: entity,
                                onCardPress: () {
                                  controller.onClickCard(entity);
                                },
                              ),
                              paginatedLst: (list) {
                                return SmartRefresherApp(
                                  controller: con,
                                  list: list,
                                );
                              },
                            );
                          }),
                    ))
              ],
            );
          },
        ),
      )),
    );
  }
}

class _HorizontalTaps extends StatelessWidget {
  const _HorizontalTaps();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(
      builder: (controller) {
        return SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: ParcelStateValue.values.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 5);
            },
            itemBuilder: (BuildContext context, int index) {
              var item = ParcelStateValue.values[index];
              bool isSelected = item == controller.initHTap;
              return CustomButton(
                backgroundColor: isSelected
                    ? Theme.of(Get.context!).primaryColor
                    : Theme.of(Get.context!).hintColor.withOpacity(.1),
                // backgroundColor: isSelected?Theme.of(context).primaryColor:Theme.of(context).hintColor,

                textColor: isSelected
                    ? Theme.of(Get.context!).cardColor
                    : Theme.of(Get.context!).hintColor,

                buttonText: ParcelStateValue.values[index].name.tr,
                width: 88,
                onPressed: () {
                  controller.onClickHTap(item);
                },
                radius: 50,
              );
            },
          ),
        );
      },
    );
  }
}
