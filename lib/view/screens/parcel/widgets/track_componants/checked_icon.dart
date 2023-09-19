import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../util/dimensions.dart';

Widget checkedIcon({isChecked}) {
  return SizedBox(
      width: Dimensions.iconSizeMedium,
      child: Container(
          width: Dimensions.fontSizeExtraLarge,
          height: Dimensions.fontSizeExtraLarge,
          decoration: BoxDecoration(
            color: isChecked
                ? Theme.of(Get.context!).primaryColor
                : Theme.of(Get.context!).cardColor,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Theme.of(Get.context!).primaryColor,
              width: 2,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: Dimensions.iconSizeSmall,
            ),
          )));
}
