


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/images.dart';

import '../../util/dimensions.dart';

Widget customFloatActionButton({onPressed ,image}){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      FloatingActionButton(
        backgroundColor: const Color(0xffB9E5D1),//0xff41,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(image,color:Theme.of(Get.context!).primaryColor  ),
        ),  ),
      SizedBox(height: Dimensions.identityImageHeight,)
    ],
  );
}