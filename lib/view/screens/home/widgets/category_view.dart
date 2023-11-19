import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_category_card.dart';
import '../../map/map_screen.dart';
import '../../parcel/controller/parcel_controller.dart';
 import '../../ride/controller/ride_controller.dart';
import '../../where_to_go/where_to_go_screen.dart';
// import '../controller/category_controller.dart';

// class CategoryView extends StatelessWidget {
//   const CategoryView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CategoryController>(
//         init: CategoryController()..getCategoryList(),
//         // initState: (_) => Get.find<CategoryController>()..getCategoryList(),
//         builder: (controller) {
//           return Obx(() {
//             if (controller.canShowList) {
//               return SizedBox(
//                 height: 130,
//                 width: Get.width,
//                 child: ListView.builder(
//                     itemCount: controller.categoryList.length,
//                     padding: EdgeInsets.zero,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           if (index == 1) {
//                             Get.find<RideController>()
//                                 .updateSelectedRideType(RideType.parcel);
//                             Get.find<ParcelController>()
//                                 .updateParcelState(ParcelDeliveryState.initial);
//                             Get.to(() => const ParcelHomeScreen());
//                           } else if (index == 2) {
//                             Get.to((MapScreen(
//                               fromScreen: 'parcel',
//                             )));
//                           } else {
//                             Get.to(() => SetDestinationScreen());
//                           }
//                         },
//                         child: CustomCategoryCard(
//                           image: controller.categoryList[index].categoryImage!,
//                           title:
//                               controller.categoryList[index].categoryTitle!.tr,
//                           isClicked: false,
//                         ),
//                       );
//                     }),
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           });
//         });
//   }
// }
