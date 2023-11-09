






import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../util/images.dart';

Widget customLoading({width}){
  return  Center(
    child:Lottie.asset(
      Images.loading,
      width:width?? 130.w,
    ),
  );
}