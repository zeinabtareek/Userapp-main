

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import 'custom_oval.dart';

class TodayNotificationWidget extends StatelessWidget {
  List list;
  String title;
  TodayNotificationWidget({super.key , required this.list, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
          child: Text(title,
              style: K.semiBoldBlackTextStyle),
        ),   ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

            itemBuilder: (context, index){
              return Row(
                children: [  K.sizedBoxW0, K.sizedBoxW0,
                  CustomOvel(Image.asset(Images.package2),color: Theme.of(Get.context!).hintColor.withOpacity(.2),),

                  K.sizedBoxW0,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(
                        '2 Feb 2023 • 7:40 pm',
                        style: K.hintSmallTextStyle,
                      ),
                        Text('Cristofer George',
                            style: K.semiBoldBlackTextStyle),

                        K.sizedBoxH0,
                        Text('Our package has been delivered and left at your designated delivery location.',
                            style: K.hintMediumTextStyle),

                        K.sizedBoxH0,
                      ],
                    ),
                  ),
                ],
              );
            }),
      ],
    );
  }
}