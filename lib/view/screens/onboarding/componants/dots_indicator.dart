


// import 'package:flutter/material.dart';
// import 'package:ride_sharing_user_app/util/dimensions.dart';
//
// class DotIndicator extends StatelessWidget {
//   final bool isSelected;
//
//   const DotIndicator({Key? key, required this.isSelected}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Padding(
//         padding:   EdgeInsets.symmetric(horizontal: 0,vertical: Dimensions.paddingSizeOverLarge),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           height: isSelected ?7.0:3.0,
//           width: Dimensions.paddingSizeLarge,
//
//           decoration: BoxDecoration(
//             // shape: BoxShape.circle,
//             borderRadius:  BorderRadius.circular(50),
//             color: isSelected ? Colors.white : Colors.white38,
//           ),
//         ),
//       );
//   }
// }