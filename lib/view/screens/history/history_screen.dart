import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/text_style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_calender.dart';
import '../../widgets/custom_tap_bar.dart';
import 'controller/history_controller.dart';
import 'widgets/current_trips_page.dart';

class HistoryScreen extends StatelessWidget {
  final String fromPage;

  const HistoryScreen({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
      init: HistoryController(),
      initState: (_) {},
      builder: (controller) {
        return Obx(() => DefaultTabController(
              length: 2,
              initialIndex: controller.indexView.value,
              child: Scaffold(
                body: CustomBody(
                  appBar: CustomAppBar(
                    title: Strings.checkYourAllTrip.tr,
                    showBackButton: false,
                  ),
                  body: Padding(
                    padding: K.fixedPadding0,
                    child: Column(
                      children: [
                        CustomTapBar(
                          isUseTapController: true,
                          tabController: controller.tabController,
                          firstTap: Strings.finished.tr,
                          secondTap: Strings.cancel.tr,
                          onTabChanged: controller.onTabChanged,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.yourTrips.tr,
                                style: textSemiBold.copyWith(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                              ),
                              controller.showCustomDate
                                  ? InkWell(
                                      onTap: () => controller
                                          .updateShowCustomDateState(false),
                                      child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.06),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radiusOverLarge),
                                            border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                          padding: K.fixedPadding0,
                                          child: Center(
                                            child: Text(
                                              "${controller.filterStartDate} - ${controller.filterEndDate}",
                                              style: textRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .color!
                                                      .withOpacity(0.5)),
                                            ),
                                          )),
                                    )
                                  : Container(
                                      width: 120,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.06),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radiusOverLarge),
                                        border: Border.all(
                                          width: 1,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                      // padding:  K.fixedPadding0,
                                      child: Obx(() => Center(
                                            child: Row(
                                              children: [
                                                if (controller
                                                    .isDataFilterOn.isTrue)
                                                  IconButton(
                                                      onPressed: controller
                                                          .clearDatesFilter,
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      )),
                                                Expanded(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      if (controller
                                                          .isDataFilterOn
                                                          .isTrue) {
                                                        controller
                                                            .clearDatesFilter();
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                CustomCalender(
                                                                  onChanged:
                                                                      (value) {
                                                                    print(
                                                                        " value::  ");
                                                                    // Get.back();
                                                                  },
                                                                  onPress:
                                                                      controller
                                                                          .addDataFilter,
                                                                ));
                                                      }
                                                    },
                                                    child: Text(controller
                                                            .isDataFilterOn
                                                            .isFalse
                                                        ? "select Date"
                                                        : "Selected"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                            ]),
                        Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                        ),
                        Flexible(
                          flex: 1,
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: controller.tabController,
                            children: [
                              Obx(() {
                                if (controller.isCompleteView.isTrue) {
                                  return CurrentTripsPage(
                                    req: controller.completeReq.value,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                              // const SizedBox(),
                              Obx(() {
                                if (controller.isCancelView.isTrue) {
                                  return CurrentTripsPage(
                                    // refreshController:
                                    //     controller.refreshControllers[1],
                                    // stateValue: StateValue.cancel,
                                    req: controller.cancelReq.value,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
