





import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

animatedWidget({required Widget widget ,required int limit }) {
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
                widget,

            ],
          ),
        ),
      ),
    ),
  );
}