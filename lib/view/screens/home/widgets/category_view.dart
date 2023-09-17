import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/category_controller.dart';
import 'package:ride_sharing_user_app/view/screens/map/map_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import '../../../widgets/custom_category_card.dart';
import '../../where_to_go/where_to_go_screen.dart';


class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      initState: (_)=> Get.find<CategoryController>().getCategoryList(),
      builder: (categoryController){
      return
        // Column(
        // children: [
          SizedBox(height: 130, width: Get.width,
            child: ListView.builder(
              itemCount: categoryController.categoryList.length,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return  GestureDetector(
                  onTap: (){
                    if(index==2) {
                      Get.find<RideController>().updateSelectedRideType(RideType.parcel);
                      Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.initial);
                      Get.to((const MapScreen(fromScreen: 'parcel',)));
                    }else{

                      Get.to(()=>   SetDestinationScreen());
                    }
                  },
                  child: CustomCategoryCard(
                      image:categoryController.categoryList[index].categoryImage!,
                      title:categoryController.categoryList[index].categoryTitle!.tr,
                    isClicked: false,
                  ),
                );
              }
            ),
          );

          // SizedBox(height: 130, width: Get.width,
          //   child: ListView.builder(
          //       itemCount: categoryController.categoryList.length,
          //       padding: EdgeInsets.zero,
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (context,index){
          //         return  GestureDetector(
          //           onTap: (){
          //             if(index==2) {
          //               Get.find<RideController>().updateSelectedRideType(RideType.parcel);
          //               Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.initial);
          //               Get.to((const MapScreen(fromScreen: 'parcel',)));
          //             }else{
          //
          //               // Get.to(()=>   SetDestinationScreen());
          //             }
          //           },
          //           child:  CustomCategoryCard(
          //                 image:categoryController.categoryList[index].categoryImage!,
          //               title:categoryController.categoryList[index].categoryTitle!.tr,
          //             isClicked: true,
          //
          //
          //           ),
          //         );
          //       }
          //   ),
          // ),
        // ],
      // );
    });
  }
}
