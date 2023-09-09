


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../util/dimensions.dart';
import '../../../../util/text_style.dart';

class CardItem extends StatelessWidget {
  final String? title;
  final String? value;
  const CardItem({Key? key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall),
      child: Row(
        children: [
          Text('${title!.tr} : ', style: textRegular.copyWith(color:Get.isDarkMode? Theme.of(context).hintColor: Theme.of(context).cardColor)),
          Text(value!, style: textMedium.copyWith(color:Get.isDarkMode? Theme.of(context).hintColor: Theme.of(context).cardColor)),

        ],
      ),
    );
  }
}