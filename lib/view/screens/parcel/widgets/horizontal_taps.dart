import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/dimensions.dart';
import '../../../widgets/custom_button.dart';

Widget horizontalTaps() {
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
              9,
              (index) => Padding(
                    padding: EdgeInsets.only(left: Dimensions.iconSizeSmall),
                    child: CustomButton(
                      backgroundColor: index == 0
                          ? Theme.of(Get.context!).primaryColor
                          : Theme.of(Get.context!).hintColor.withOpacity(.1),
                      // backgroundColor: isSelected?Theme.of(context).primaryColor:Theme.of(context).hintColor,
                      isLoading: false,
                      textColor: index == 0
                          ? Theme.of(Get.context!).cardColor
                          : Theme.of(Get.context!).hintColor,

                      buttonText: Strings.sendOtp.tr,
                      width: 88,
                      onPressed: () {},
                      radius: 50,
                    ),
                  ))
        ],
      ));
}
