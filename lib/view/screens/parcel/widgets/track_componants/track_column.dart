import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_divider.dart';
import '../../../history/model/history_model.dart';
import 'checked_icon.dart';

trackColumn(List<OrderStep> x) {
  return Column(
      children: List.generate(
    x.length,
    (index) => Column(
      children: [
        checkedIcon(isChecked: true),
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
            : const SizedBox()
      ],
    ),
  ));
}
