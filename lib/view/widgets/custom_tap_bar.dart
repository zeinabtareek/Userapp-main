


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/dimensions.dart';
import '../../util/text_style.dart';

// class CustomTapBar extends StatelessWidget {
//   const CustomTapBar({
//     super.key,
//     required this.tabController,
//     required this.firstTap,
//     required this.secondTap,
//   });
//
//   final TabController tabController;
//   final String secondTap;
//   final String firstTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return TabBar(
//       controller: tabController,
//       unselectedLabelColor: Colors.grey,
//       labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
//       labelStyle: textSemiBold.copyWith(),
//       isScrollable: true,
//       indicatorPadding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
//       indicator: UnderlineTabIndicator(
//         borderSide: BorderSide(
//           color: Theme.of(context).primaryColor,
//           width: 2,
//         ),
//       ),
//       padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
//       tabs:  [
//         Tab(text: firstTap),
//         Tab(text: secondTap),
//       ],
//     );
//   }
// }


class CustomTapBar extends StatelessWidget {
  const CustomTapBar({
    Key? key,
    required this.tabController,
    required this.firstTap,
    required this.secondTap,
    required this.onTabChanged,
  }) : super(key: key);

  final TabController tabController;
  final String secondTap;
  final String firstTap;
  final Function(dynamic) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      unselectedLabelColor: Colors.grey,
      labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
      labelStyle: textSemiBold.copyWith(),
      isScrollable: true,
      indicatorPadding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
      tabs: [
        Tab(text: firstTap),
        Tab(text: secondTap),
      ],
      onTap: onTabChanged
    );
  }
}