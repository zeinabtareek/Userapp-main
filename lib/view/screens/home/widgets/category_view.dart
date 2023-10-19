import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_category_card.dart';
import '../../map/map_screen.dart';
import '../../parcel/controller/parcel_controller.dart';
import '../../parcel/parcel_home_screen.dart';
import '../../ride/controller/ride_controller.dart';
import '../../where_to_go/where_to_go_screen.dart';
import '../controller/category_controller.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      init: CategoryController(),
        initState: (_) => Get.find<CategoryController>().getCategoryList(),
        builder: (categoryController) {
          return
              SizedBox(
            height: 130,
            width: Get.width,
            child: ListView.builder(
                itemCount: categoryController.categoryList.length,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 1) {
                        Get.find<RideController>()
                            .updateSelectedRideType(RideType.parcel);
                        Get.find<ParcelController>()
                            .updateParcelState(ParcelDeliveryState.initial);
                      Get.to(() => ParcelHomeScreen());


                      } else if (index == 2) {
                        Get.to((  MapScreen(
                          fromScreen: 'parcel',
                        )));
                      }
                      else {
                        Get.to(() => SetDestinationScreen());
                      }
                    },
                    child: CustomCategoryCard(
                      image:
                          categoryController.categoryList[index].categoryImage!,
                      title: categoryController
                          .categoryList[index].categoryTitle!.tr,
                      isClicked: false,
                    ),
                  );
                }),
          );

        });
  }
}
