import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../util/app_style.dart';

Widget customOval(Widget image,
    {Color? color, Color? borderColor, void Function()? onTap, height, width}) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: borderColor ?? Colors.transparent,
        width: 1, // Border width
      ),
    ),
    child: ClipOval(
      child: Material(
        color: color ?? Color(0xff3b9a8b).withOpacity(.5), // button color
        child: InkWell(
            // splashColor: Colors.red, // inkwell color
            onTap: onTap,
            // splashColor: Colors.red, // inkwell color
            child: SizedBox(
              width: width ?? 46,
              height: height ?? 46,
              child: Padding(padding: K.fixedPadding1, child:  image),
            )),
      ),
    ),
  );
}
