


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/app_style.dart';

Widget fixedHeader(){
  return  Container(
    padding: K.fixedPadding1,
    decoration:   BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(100),
        topRight: Radius.circular(100),
      ),
      color:Theme.of(Get.context!).scaffoldBackgroundColor
    ),
    width: Get.width,
    child: Center(
      child:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey,
        ),
        height: 5,
        width: 80,
        // child:
      ),
    ),
  );
}