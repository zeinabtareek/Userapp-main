import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/category_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/parcel_home_screen.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/controller/where_to_go_controller.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/where_to_go_screen.dart';

import '../../../../util/app_style.dart';
import '../../../widgets/animated_widget.dart';
import '../../map/map_screen.dart';

class RideSubCategoryWidget extends StatelessWidget {
  List listOfSubCategory;
  RideType  categoryName;
  RideSubCategoryWidget({Key? key, required this.listOfSubCategory, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
        initState: (_) => Get.find<CategoryController>().getCategoryList(),
        builder: (rideController) {
          return SizedBox(
            height: 110,
            width: Get.width,
            child: ListView.builder(
                itemCount: listOfSubCategory.length,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100,
                    width: 100,
                    child: InkWell(
                      onTap: () {

    if (categoryName == RideType.car) {
    Get.to(SetDestinationScreen());
    }
      else {
      Get.to(ParcelHomeScreen());


    }                        // if (index == 0) {
                        //   rideController.updateSelectedRideType(RideType.car);
                        //   // ...
                        // } else if (index == 1) {
                        //   rideController.updateSelectedRideType(RideType.bike);
                        // } else if (index == 2) {
                        //   rideController
                        //       .updateSelectedRideType(RideType.parcel);
                        // } else if (index == 3) {
                        //   rideController
                        //       .updateSelectedRideType(RideType.luxury);

                        // rideController.setRideCategoryIndex(index);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusDefault),
                              color: rideController.rideCategoryIndex == index
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.8)
                                  : Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.1),
                            ),
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeDefault),
                            child: Image.network(listOfSubCategory[index]['image'].toString(),
                              errorBuilder: (context, error, stackTrace) {
                                print(error); //do something
                                return Text('error');
                              },
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: Padding(
                                    padding: K.fixedPadding1,
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!.toInt()
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall,
                          ),
                          Text(listOfSubCategory[index]['type'].toString(),
                            style: textSemiBold.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(0.8),
                                fontSize: Dimensions.fontSizeSmall),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        });
  }
}


class RideCategoryWidget extends StatelessWidget {
   RideCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
        initState: (_) => Get.find<CategoryController>().getCategoryList(),
        builder: (rideController) {
          return    Column(
            children: [
              SizedBox(
                    height: 110,
                    width: Get.width,
                    child: ListView.builder(
                        itemCount: Get.find<CategoryController>().categoryList.length,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: Dimensions.iconSizeOnline-10,
                            width: Dimensions.iconSizeOnline,
                            child: InkWell(
                              onTap: () {
                                if(index!=2 &&index !=3){
                                if (index == 0) {
                                  rideController.updateSelectedRideType(RideType.car);
                                  rideController.vehicleToggle(RideType.car);



                                } else if (index == 1) {

                                  rideController
                                      .updateSelectedRideType(RideType.parcel);
                                  rideController.vehicleToggle(RideType.parcel);
                                  null;
                                } else if (index == 2) {

                                  rideController
                                      .updateSelectedRideType(RideType.bike);
                                  rideController.vehicleToggle(RideType.bike);
                                } else if (index == 3) {
                                  // rideController
                                  //     .updateSelectedRideType(RideType.luxury);

                                }
                                rideController.setRideCategoryIndex(index);
                              }else{
                                  rideController.resetControllerValue();
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Container(
                                    height: 80,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusDefault),
                                      color: rideController.rideCategoryIndex == index
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.8)
                                          : Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.1),
                                    ),
                                    padding: index == 2 ||index==3?null:const EdgeInsets.all(
                                        Dimensions.paddingSizeDefault),
                                  //   child:   Image.asset(Get.find<CategoryController>()
                                  //       .categoryList[index]
                                  //       .categoryImage!),
                                  // ),
                                child:Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      Get.find<CategoryController>()
                                          .categoryList[index]
                                          .categoryImage!,
                                    ),
                                    if (index == 2 ||index==3) Positioned.fill(
                                      child: Container(
                                       decoration: BoxDecoration(
                                           color:Colors.black.withOpacity(.8),
                          borderRadius: BorderRadius.circular(
                          Dimensions.radiusDefault)),
                                        child: const Center(
                                          child: Text(
                                            'Coming Soon',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                ),
                                  const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall,
                                  ),
                                  Text(
                                    Get.find<CategoryController>()
                                        .categoryList[index]
                                        .categoryTitle!
                                        .tr,
                                    style: textSemiBold.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color!
                                            .withOpacity(0.8),
                                        fontSize: Dimensions.fontSizeSmall),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
              // rideController.heightOfTypes

              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: 200,
                height: rideController.heightOfTypes,
                // color: Colors.blue,
                child:  rideController.isExpanded?animatedWidget(onTap: (){   },
                    widget:RideSubCategoryWidget(
                      listOfSubCategory: rideController.selectedCategory == RideType.car
                          ? listOfCarsType
                          : listOfParcel, categoryName: rideController.selectedCategory,
                    ),
                     limit: 1):SizedBox(),
              ),
            ],
          );

        });
  }
}
List listOfCarsType=[
  {
    'image':'https://www.freepnglogos.com/uploads/car-png/car-transparent-png-pictures-icons-and-png-backgrounds-15.png',
    "type":'SUV'
  }, {
    'image':'https://www.freepnglogos.com/uploads/car-png/car-transparent-png-pictures-icons-and-png-backgrounds-15.png',
    "type":'hatchback'
  },
];
List listOfParcel=[
  {
    'image':'https://www.freepnglogos.com/uploads/box-png/box-rsc-boxes-benefit-shipping-and-retail-cactus-containers-12.png',
     "type":'Box'
  }, {
    'image':'https://cdn-icons-png.flaticon.com/512/176/176040.png',
    "type":'Documents'
  },
];