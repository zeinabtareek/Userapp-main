import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/animated_widget.dart';
import '../../home/controller/category_controller.dart';
import '../../home/model/categoty_model.dart';
import '../../parcel/parcel_home_screen.dart';
import '../../request_screens/controller/base_map_controller.dart';
import '../../where_to_go/where_to_go_screen.dart';
import '../controller/ride_controller.dart';

class RideSubCategoryWidget extends StatelessWidget {
  List<CategoryModel> listOfSubCategory;
  RideType categoryName;
  CategoryModel selectedCategoryModel;
  RideSubCategoryWidget({
    Key? key,
    required this.listOfSubCategory,
    required this.selectedCategoryModel,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var con = Get.find<CategoryController>();
    return GetBuilder<RideController>(
        initState: (_) => con.getCategoryList(),
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
                          rideController
                              .updateSelectedSubRideType(RideType.car);

                          // rideController
                          //     .selectedSubPackage(listOfSubCategory[index]);
                          print(
                              'sub package ${listOfSubCategory[index].categoryTitle}');

                          ///zeinab this is the sub package
                          if( rideController.isFromCat.value==true) {
                            rideController
                                .selectedSubPackage(listOfSubCategory[index]);
                            Get.to(
                                  () =>
                                  SetDestinationScreen(
                                      fromCat: rideController.isFromCat.value,
                                      // fromCat: true,
                                      categoryModel: listOfSubCategory[index]),
                            );
                          }
                          else{
                            rideController
                                .selectedSubPackage(listOfSubCategory[index]);


                            Get.find<BaseMapController>().key.currentState!.contract();
                            Get.find<BaseMapController>().update();
                            print('you are choosing the car type from where to go${rideController.selectedSubPackage.value?.id} ');

                          }

                        } else {
                          rideController
                              .updateSelectedSubRideType(RideType.parcel);
                          Get.to(() => const ParcelHomeScreen());
                        } // if (index == 0) {
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

                        rideController.setSubRideCategoryIndex(index);
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
                              color:
                                  rideController.rideSubCategoryIndex == index
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8)
                                      : Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.1),
                            ),
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeDefault),
                            child: Image.network(
                              listOfSubCategory[index].categoryImage.toString(),
                              errorBuilder: (context, error, stackTrace) {
                                print(error); //do something
                                return const Text('error');
                              },
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: Padding(
                                    padding: K.fixedPadding1,
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                                      .toInt()
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
                          Text(
                            listOfSubCategory[index].categoryTitle.toString(),
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
  const RideCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.find<CategoryController>();

    return GetBuilder<RideController>(
      initState: (_) {
        categoryController.getCategoryList().then((value) {
          if (categoryController.categoryList.isNotEmpty) {
            if (Get.isRegistered<RideController>()) {
              var con = Get.find<RideController>();
              con.selectedPackage(
                categoryController.categoryList.first,
              );
              con.updateSelectedRideType(RideType.car);
              con.vehicleToggle();
            } else {
              var con = Get.put(RideController(rideRepo: Get.find()));
              con.selectedPackage(
                categoryController.categoryList.first,
              );
              con.updateSelectedRideType(RideType.car);
              con.vehicleToggle();
            }
          }
        });
      },
      builder: (rideController) {
     if (categoryController.categoryList.isNotEmpty) {
      return     Column(
          children: [
            SizedBox(
              height: 110.h,
              width: Get.width,
              child: ListView.builder(
                  itemCount: categoryController.categoryList.length,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var item = categoryController.categoryList[index];
                    return SizedBox(
                      height: Dimensions.iconSizeOnline - 10,
                      width: Dimensions.iconSizeOnline,
                      child: InkWell(
                        onTap: () {
                          rideController.selectedPackage(item);
                          if (index != 2 && index != 3) {
                            if (index == 0) {
                              rideController
                                  .updateSelectedRideType(RideType.car);
                              rideController.vehicleToggle();
                            } else if (index == 1) {
                              rideController
                                  .updateSelectedRideType(RideType.parcel);
                              rideController.vehicleToggle();
                              null;
                            } else if (index == 2) {
                              rideController
                                  .updateSelectedRideType(RideType.bike);
                              rideController.vehicleToggle();
                            } else if (index == 3) {
                              // rideController
                              //     .updateSelectedRideType(RideType.luxury);
                            }
                            rideController.setRideCategoryIndex(index);
                          } else {
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
                              padding: index == 2 || index == 3
                                  ? null
                                  : const EdgeInsets.all(
                                      Dimensions.paddingSizeDefault),
                              //   child:   Image.asset(Get.find<CategoryController>()
                              //       .categoryList[index]
                              //       .categoryImage!),
                              // ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    item.categoryImage!,
                                  ),
                                  if (index == 2 || index == 3)
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(.8),
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
                              item.categoryTitle!.tr,
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
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              // width: 200,
              height: rideController.heightOfTypes,
              padding: EdgeInsetsDirectional.only(start: 60.w),
              // color: Colors.blue,
              child: rideController.isExpanded
                  ? Obx(() => animatedWidget(
                      onTap: () {},
                      widget: RideSubCategoryWidget(
                        listOfSubCategory: rideController
                                .selectedPackage.value?.sub
                                ?.toList() ??
                            [],
                        categoryName: rideController.selectedCategoryTypeEnum,
                        selectedCategoryModel:
                            rideController.selectedPackage.value!,
                      ),
                      limit: 1))
                  : const SizedBox(),
            ),
          ],
        );
       
     }else{
     return Center(child: CupertinoActivityIndicator(),);
     }

        
      },
    );
  }
}
/*
class NewWidget extends StatelessWidget {
  final RideController rideController;
  const NewWidget(
    this.rideController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 110,
            width: Get.width,
            child: ListView.builder(
                itemCount: Get.find<CategoryController>().categoryList.length,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var item = Get.find<CategoryController>().categoryList[index];
                  return SizedBox(
                    height: Dimensions.iconSizeOnline - 10,
                    width: Dimensions.iconSizeOnline,
                    child: InkWell(
                      onTap: () {
                        rideController.selectedPackage(item);
                        if (index != 2 && index != 3) {
                          if (index == 0) {
                            rideController.updateSelectedRideType(RideType.car);
                            rideController.vehicleToggle();
                          } else if (index == 1) {
                            rideController
                                .updateSelectedRideType(RideType.parcel);
                            rideController.vehicleToggle();
                            null;
                          } else if (index == 2) {
                            rideController
                                .updateSelectedRideType(RideType.bike);
                            rideController.vehicleToggle();
                          } else if (index == 3) {
                            // rideController
                            //     .updateSelectedRideType(RideType.luxury);
                          }
                          rideController.setRideCategoryIndex(index);
                        } else {
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
                            padding: index == 2 || index == 3
                                ? null
                                : const EdgeInsets.all(
                                    Dimensions.paddingSizeDefault),
                            //   child:   Image.asset(Get.find<CategoryController>()
                            //       .categoryList[index]
                            //       .categoryImage!),
                            // ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(
                                  item.categoryImage!,
                                ),
                                if (index == 2 || index == 3)
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.8),
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
                            item.categoryTitle!.tr,
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
                })),
        // rideController.heightOfTypes
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: 200,
          height: rideController.heightOfTypes,
          // color: Colors.blue,
          child: rideController.isExpanded
              ? Obx(() => animatedWidget(
                  onTap: () {},
                  widget: RideSubCategoryWidget(
                    listOfSubCategory:
                        rideController.selectedPackage.value?.sub?.toList() ??
                            [],
                    categoryName: rideController.selectedCategoryTypeEnum,
                    selectedCategoryModel:
                        rideController.selectedPackage.value!,
                  ),
                  limit: 1))
              : const SizedBox(),
        ),
      ],
    );
  }
}
*/
