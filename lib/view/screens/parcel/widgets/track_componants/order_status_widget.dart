import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../widgets/custom_button.dart';

Widget orderStatusWidget(Function()? onPressed,
    {bool? isReturned, required String text, double? width}) {
  return Row(
    children: [
      K.sizedBoxW0,
      TextButton(
          onPressed: () {},
          child: Text(
            Strings.statusOrder.tr,
            style: K.hintMediumTextStyle,
          )),
      K.sizedBoxW0,
      CustomButton(
        backgroundColor: isReturned == true ? Colors.red : K.lightGreen,
        isLoading: false,
        textColor: isReturned != true
            ? Theme.of(Get.context!).primaryColor
            : Colors.white,
        height: 30,
        buttonText: text,
        width: width ?? 88,
        onPressed: onPressed,
        radius: 50,
      ),
    ],
  );
}
