import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../../../../pagination/typedef/page_typedef.dart';
import '../../../../../pagination/widgets/paginations_widgets.dart';
import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/text_style.dart';
import '../../../../widgets/custom_divider.dart';
import '../../../history/model/history_model.dart';
import '../../screens/order_details_screen.dart';
import '../custom_oval.dart';
import '../item_track_history_card.dart';
import 'order_status_widget.dart';

Widget trackOrderWithStatus({onPressed, text, isReturned}) {
  return Column(
    children: [
      // itemTrackHistory(
      //   icon: const Icon(
      //     Icons.more_horiz,
      //     color: Colors.black,
      //   ),
      //   title: 'New York, NY, 10016, USA',
      //   subTitle: 'Order ID: JB390299191242',
      //   elevated: 0,
      // ),
      orderStatusWidget(onPressed, isReturned: isReturned, text: text),
    ],
  );
}

class TrackOrderWithStatus extends PaginationViewItem<HistoryData> {
  const TrackOrderWithStatus({
    super.key,
    required super.data,
    // required this.onClickOnState,
    required this.onCardPress,
    // required this.isClopped,
  });

  // final Function() onClickOnState;
  final Function() onCardPress;
  // final bool isClopped;

  // final bool isReturned;
  // final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardPress,
      child: Card(
        color: Colors.white,
        elevation: 10,
        // shadowColor: const Color.fromARGB(255, 186, 181, 181),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customOval(
                    Image.asset(Images.package2),
                    color: Colors.grey.withOpacity(.3),
                  ),
                  K.sizedBoxW0,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // TODO: pacge name
                        // title ??
                        data.packageName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.iconSizeSmall),
                      ),
                      Text(
                        "${'order_id'.tr} : ${data.orderNum!}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimensions.fontSizeSmall),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                K.sizedBoxW0,
                Text(
                  Strings.statusOrder.tr,
                  style: K.hintSmallTextStyle,
                ),
                K.sizedBoxW0,
                Text(
                  data.status?.tr ?? "",
                  style: K.hintSmallTextStyle.copyWith(
                    color: !data.isCanceled
                        ? Theme.of(context).primaryColor
                        : Colors.red,
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                CustomButton(
                  buttonText: "view_details".tr,
                  onPressed: () {
                    Get.to(() => OrderDetails(
                          item: data,
                        ));
                  },
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  height: 30,
                  width: 120,
                ),
                K.sizedBoxW0,
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            AnimatedContainer(
              curve: Curves.bounceIn,
              duration: const Duration(seconds: 3),
              height: data.isClipped == true ? 0 : null,
              // height: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            SizedBox(
                                width: Dimensions.iconSizeMedium,
                                height: Dimensions.iconSizeMedium,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: const Icon(
                                    Icons.done,
                                    size: 18,
                                  ),
                                )),
                            K.sizedBoxH3,
                            SizedBox(
                                height: 50.h,
                                width: 20,
                                child: const CustomDivider(
                                  height: 2,
                                  dashWidth: 1,
                                  axis: Axis.vertical,
                                  color: Colors.black,
                                )),
                            K.sizedBoxH3,
                            Container(
                                width: Dimensions.iconSizeMedium,
                                height: Dimensions.iconSizeMedium,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                    )),
                                child: CircleAvatar(
                                  backgroundColor: data.isCompleted
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).canvasColor,
                                  child: Icon(
                                    Icons.done,
                                    color: data.isCompleted
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).canvasColor,
                                    size: 18,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Text(
                              'from'.tr,
                              style: textRegular.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeSmall / 2),
                            Text(
                              "${data.from?.location ?? ""} .",
                              // parcelController.senderAddressController.text,
                              style: textRegular.copyWith(),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Text(
                              'to'.tr,
                              style: textRegular.copyWith(color: Colors.grey),
                            ),

                            ///extra routes

                            const SizedBox(
                              height: Dimensions.paddingSizeSmall / 2,
                            ),
                            Text(
                              "${data.to?.location ?? ""} .",
                              // parcelController.receiverAddressController.text,
                              style: textRegular.copyWith(),
                              // style: textRegular.copyWith(
                              //     color: colorText ?? Theme.of(context).shadowColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final double containerHeight = 5.0;
  final double sizeBetween = 2.0;
  Widget _getSeparateWidget({required int sizeHeight}) {
    double totalHeight = containerHeight + sizeBetween;

    int count = (sizeHeight / totalHeight).round();

    Widget separateWidget() => Column(
          children: [
            const CustomDivider(
              height: 2,
              dashWidth: 1,
              axis: Axis.vertical,
              color: Colors.black,
            ),
            SizedBox(
                width: Dimensions.iconSizeMedium,
                child: Image.asset(Images.activityDirection,
                    color: Theme.of(Get.context!).primaryColor)),
            SizedBox(height: sizeBetween)
          ],
        );

    return Column(
        children: [...List.generate(count, (index) => separateWidget())]);
  }
}
