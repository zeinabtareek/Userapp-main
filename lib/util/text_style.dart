import 'package:flutter/material.dart';
import 'package:get/get.dart';

const sfProLight = TextStyle(
  fontFamily: 'SFProText',
  fontWeight: FontWeight.w300,
);

const textRegular = TextStyle(
  fontFamily: 'SFProText',
  fontWeight: FontWeight.w400,
);

const textMedium = TextStyle(
  fontFamily: 'SFProText',
  fontWeight: FontWeight.w500,
);

const textSemiBold = TextStyle(
  fontFamily: 'SFProText',
  fontWeight: FontWeight.w600,
);

const textBold = TextStyle(
  fontFamily: 'SFProText',
  fontWeight: FontWeight.w700,
);

const textHeavy = TextStyle(
  fontFamily: 'SFProText',
  fontWeight: FontWeight.w900,
);

List<BoxShadow>? searchBoxShadow = Get.isDarkMode ? null : [const BoxShadow(
    offset: Offset(0,3),
    color: Color(0x208F94FB), blurRadius: 5, spreadRadius: 2)];


List<BoxShadow>? cardShadow = Get.isDarkMode? null:[BoxShadow(
  offset: const Offset(1, 0),
  blurRadius: 1,spreadRadius: 1,
  color: Colors.black.withOpacity(0.5),
)];


List<BoxShadow>? shadow = Get.isDarkMode ? [BoxShadow(
    offset: const Offset(0,3),
    color: Colors.grey[100]!, blurRadius: 1, spreadRadius: 2)] : [BoxShadow(
    offset: const Offset(0,3),
    color: Colors.grey[100]!, blurRadius: 1, spreadRadius: 2)];


