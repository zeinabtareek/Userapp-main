import 'package:flutter/cupertino.dart';
import '../../../../util/app_style.dart';
import '../../../../util/images.dart';

noChatPlaceHolder() {
  return Expanded(
      child: Padding(
        padding: K.fixedPadding0,
        child: Image.asset(Images.chatGif),
      ));
}