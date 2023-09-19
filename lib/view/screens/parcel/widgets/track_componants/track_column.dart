import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_divider.dart';
import 'checked_icon.dart';

trackColumn(List x) {
  return Column(
      children: List.generate(
    x.length,
    (index) => Column(
      children: [
        checkedIcon(isChecked: index != x.length - 1 ? true : false),
        !(index == x.length - 1)
            ? SizedBox(
                height: 45,
                width: 10,
                child: CustomDivider(
                  height: 2,
                  dashWidth: 1,
                  axis: Axis.vertical,
                  color: Theme.of(Get.context!).primaryColor,
                ))
            : SizedBox()
      ],
    ),
  ));
}
