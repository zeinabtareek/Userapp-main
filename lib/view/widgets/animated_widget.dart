





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'custom_category_card.dart';

animatedWidget({required Widget widget ,required int limit,List ?list ,void Function()? onTap}) {
  return Container(
    width: MediaQuery.of(Get.context!).size.width,
    // color: Colors.red,
    child:  Center(
      child:AnimationLimiter(
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 10,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: MediaQuery.of(Get.context!).size.width / 2,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              for (var i = 0; i <  limit;i++)
               list!=null?GestureDetector(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Card(
                     shape:   RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
      ),
                     elevation: 4,
                     child: CustomCategoryCard(
                       width: MediaQuery.of(Get.context!).size.width/3,
                       height: 140,
                       color: Colors.white,
                       image:list[i]['image'],
                       title:list[i]['title'],
                       isClicked: false,
                     ),
                   ),
                 ),
                 onTap: onTap
               ): widget,

            ],
          ),
        ),
      ),
    ),
  );
}