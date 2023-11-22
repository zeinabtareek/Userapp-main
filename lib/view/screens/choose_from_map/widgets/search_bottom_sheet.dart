import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../widgets/custom_button.dart';
import '../controller/choose_from_map_controller.dart';

class SearchBottom extends StatelessWidget {
  const SearchBottom({super.key});

  // final controller = Get.put(ChooseFromMapController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseFromMapController>(
      init: ChooseFromMapController(),
      builder: (controller) {
        return Container(
          margin: K.fixedPadding0,
          padding: K.fixedPadding0,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              // color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).hintColor,
                  blurRadius: 12,
                )
              ]),
          child: Material(
            // color: Colors.white,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Strings.selectDestination.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Theme.of(context).primaryColor),
                ),
                K.sizedBoxH0,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: controller.isDataLoading.value
                            ? Text(
                                Strings.searchingAddress.tr,
                                style: K.hintSmallTextStyle,
                              )
                            : Text(controller.address.value.tr),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.toggleContainerVisibility,
                      child: Text(
                        Strings.search.tr,
                        style: K.primarySmallTextStyle,
                      ),
                    )
                  ],
                ),
                K.sizedBoxH0,
                Obx(
                  () => AnimatedContainer(
                      height: controller.isContainerVisible.value ? 50 : 0,
                      duration: const Duration(milliseconds: 500),
                      decoration: getBoxShadow(),
                      child: TextFormField(
                        controller: controller.searchController,
                        onFieldSubmitted: (value) {
                          Focus.of(context).unfocus();
                        },
                        onChanged: (value) => controller.debounceFunction(
                            controller.searchPlacesFrom(value)),
                        decoration: getInputDecoration(
                          controller.isContainerVisible.value
                              ? Strings.selectDestination.tr
                              : null,
                          controller.isContainerVisible.value
                              ? const Icon(Icons.location_on)
                              : null,
                          controller.isContainerVisible.value,
                        ),
                      )),
                ),
                K.sizedBoxH0,
                Obx(() => Visibility(
                      visible: controller.isSetDestBtnViable.isTrue ?? false,
                      child: CustomButton(
                        buttonText: Strings.seTDestination.tr,
                        radius: 25,
                        backgroundColor:
                            controller.isSetDestBtnViable.isTrue == true
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                        onPressed: () {
                          controller.searchResultsFrom.clear();
                          Get.back(result: controller.selectedPoint);
                        },
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  getInputDecoration(hint, icon, isContainerVisible) {
    return InputDecoration(
      icon: Container(
        margin: EdgeInsetsDirectional.only(
          start: 20.w,
          bottom: 10.h,
        ),
        width: 10,
        height: 10,
        child: icon,
      ),
      hintText: hint,
      border: InputBorder.none,
      hintStyle: isContainerVisible
          ? K.hintSmallTextStyle
          : const TextStyle(color: Colors.transparent),
      contentPadding: EdgeInsetsDirectional.only(
        start: 0.w,
        bottom: 5.h,
      ),
    );
  }

  getBoxShadow() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Theme.of(Get.context!).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.4),
              offset: const Offset(.50, 1.0),
              blurRadius: 1,
              spreadRadius: 1)
        ]);
  }
}
