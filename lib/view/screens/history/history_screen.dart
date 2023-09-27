import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/base_controller.dart';
import '../../../util/dimensions.dart';
import '../../../util/text_style.dart';
import 'controller/activity_controller.dart';
import 'controller/history_controller.dart';
import 'widgets/activity_item_view.dart';
import 'widgets/current_trips_page.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_calender.dart';
import '../../widgets/custom_drop_down.dart';

import '../../../enum/view_state.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../widgets/custom_tap_bar.dart';

class HistoryScreen extends StatelessWidget {
  final String fromPage;

  HistoryScreen({Key? key, required this.fromPage}) : super(key: key);

  String initialSelectItem = Get.find<ActivityController>().filterList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
            title: Strings.checkYourAllTrip.tr, showBackButton: false),
        body: Padding(
          padding: K.fixedPadding0,
          child:
              GetBuilder<HistoryController>(
                  init: HistoryController(),
                  builder: (controller) =>  Column(
                        children: [
                          CustomTapBar(
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .radiusOverLarge),
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
                                        child: Center(
                                          child: CustomDropDown(
                                            icon: Icon(
                                              Icons.expand_more,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color!
                                                  .withOpacity(0.5),
                                            ),
                                            maxListHeight: 200,
                                            items: controller.filterList
                                                .map((item) =>
                                                    CustomDropdownMenuItem<
                                                        String>(
                                                      value: item,
                                                      child: Text(
                                                        item.tr,
                                                        style: textRegular.copyWith(
                                                            color: item !=
                                                                    initialSelectItem
                                                                ? Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .color!
                                                                    .withOpacity(
                                                                        0.5)
                                                                : Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                      ),
                                                    ))
                                                .toList(),
                                            hintText: Strings.select.tr,
                                            borderRadius: 5,
                                            onChanged: (selectedItem) {
                                              initialSelectItem =
                                                  selectedItem ?? Strings.all;
                                              if (initialSelectItem ==
                                                  Strings.custom) {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        CustomCalender(
                                                          onChanged: (value) {
                                                            Get.back();
                                                          },
                                                        ));
                                              }
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                              ]),
                          Divider(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                          ),

                BaseStateWidget<HistoryController>(
                  successWidget:    Flexible(
                                  flex: 1,
                                  child: TabBarView(
                                    controller: controller.tabController,
                                    children: [
                                      CurrentTripsPage(model: controller.model),
                                      CurrentTripsPage(model: controller.model),
                                      // CurrentTripsPage(),
                                    ],
                                  ),
                                )





                        ,emptyWord: Strings.noHistory.tr,
                    onPressedRetryButton: () {
                      controller.getAllHistory(status: Strings.finished);
                    },
                      ) ,



                        ],
                  )


        ),
      ),
      ),
    );
  }
}
