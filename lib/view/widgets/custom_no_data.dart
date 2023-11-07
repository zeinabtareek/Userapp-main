


import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../util/images.dart';

Widget customNoDataWidget (){
  return Center(child:
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Lottie.asset(
        Images.noData,
        width: 200.w,
      ),Text("no_data_found".tr)
    ],
  )
  );
}