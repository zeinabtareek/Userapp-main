import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_drop_down.dart';

class WeightAndPackageWidget extends StatelessWidget {
  List listOfItems;
  String initial;
  RxInt counter;
  void Function()? addFun;
  void Function()? minFun;

  WeightAndPackageWidget({
    super.key,
    required this.listOfItems,
    required this.initial,
    required this.counter,
    required this.addFun,
    required this.minFun,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///weight

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.weight.tr,
              style: K.hintMediumTextStyle,
            ),
            K.sizedBoxH2,
            Container(
              padding: K.fixedPadding1,
              width: MediaQuery.of(context).size.width / 4,
              // height: 35,
              decoration: K.lightGreenBoxDecoration,
              // padding:  K.fixedPadding0,
              child: CustomDropDown(
                icon: Icon(
                  Icons.expand_more,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .color!
                      .withOpacity(0.5),
                ),
                maxListHeight: MediaQuery.of(context).size.height / 2,
                items: listOfItems
                    .map((item) => CustomDropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: textRegular.copyWith(
                                color: item != initial
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(0.5)
                                    : Theme.of(context).primaryColor),
                          ),
                        ))
                    .toList(),
                hintText: initial,
                borderRadius: 5,
                onChanged: (selectedItem) {
                  initial = selectedItem ?? Strings.all;
                  if (initial == Strings.custom) {}
                  // controller.update();
                },
              ),
            ),
          ],
        ),
        K.sizedBoxW0,

        ///add or minimize

        Obx(
          () => Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.quantity.tr,
                    style: K.hintMediumTextStyle,
                  ),
                  K.sizedBoxH2,
                  Container(
                    // padding: EdgeInsets.only(left: Dimensions.radiusSmall,right: Dimensions.radiusSmall,top:  Dimensions.radiusSmall),
                    padding: EdgeInsets.all(Dimensions.radiusSmall),
                    // child: Row(),
                    decoration: K.lightGreenBoxDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${counter.value} Package',
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                            onTap: minFun,
                            child: Container(
                              width: Dimensions.iconSizeExtraLarge,
                              height: Dimensions.iconSizeExtraLarge,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Icon(Icons.remove, color: Colors.black),
                            )),
                        K.sizedBoxW0,
                        GestureDetector(
                            onTap: addFun,
                            child: Container(
                              width: Dimensions.iconSizeExtraLarge,
                              height: Dimensions.iconSizeExtraLarge,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor),
                              child: Icon(Icons.add, color: Colors.black),
                            )),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
