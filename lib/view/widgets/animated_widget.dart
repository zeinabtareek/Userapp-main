





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/map/map_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/status_package_screen.dart';

import 'custom_category_card.dart';

animatedWidget({required Widget widget ,required int limit,List ?list ,  Function()? onTap,bool ?isNavigate, List? screensList,}) {
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
            duration: const Duration(milliseconds: 500),
            // duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: MediaQuery.of(Get.context!).size.width / 2,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              for (var i = 0; i <  limit;i++)
               list!=null?GestureDetector(
                 // onTap: isNavigate == true
                 //     ? () => Get.to(() => list[i]['onTap'] ?? Container()) // Replace Container() with a valid default widget
                 //     : onTap,
                 //
                 // onTap: (){
                 //   Get.to(()=>StatusPackageScreen());  },
                 onTap: ()=> Get.off( list[i]['onTap']??{} ),
                 // onTap: ()=> Get.to(() => list[i]['onTap']??{} ),
                 // onTap: ()=> Get.to(() => MapScreen(fromScreen: 'ride')),
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Card(
                     shape:   RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),  ),
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
                 )
               ): widget,

            ],
          ),
        ),
      ),
    ),
  );
}




// class AnimatedWidget extends StatelessWidget {
//   AnimatedWidget({super.key, required this.items,required this.isVertical,required this.widget});
//
//
//
//     @override
//     Widget build(BuildContext context) {
//       return AnimationLimiter(
//         child: ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (BuildContext context, int index) {
//             return AnimationConfiguration.staggeredList(
//               position: index,
//               duration: const Duration(milliseconds: 500),
//               child: SlideAnimation(
//                 // verticalOffset:  50.0,
//                 // horizontalOffset: MediaQuery.of(Get.context!).size.width / 2,
//                 verticalOffset:isVertical? 50.0:0,
//                 horizontalOffset:isVertical?0: MediaQuery.of(Get.context!).size.width / 2,
//                 child: FadeInAnimation(
//                     child: widget
//                   // ListTile(
//                   //   title: Text(items[index]),
//                   // ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//
// }

class AnimatedWidget1 extends StatelessWidget {
  final List<dynamic> items;
  final bool isVertical;
  final bool isGrid;
  final Widget widget;
  const AnimatedWidget1({super.key ,required this.widget,required this.isVertical, required  this.items, required  this.isGrid});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child:

       isGrid?     GridView.builder(
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisSpacing: 10, // Adjust the spacing between items
           childAspectRatio: 1.2, // Adjust the aspect ratio of items
           crossAxisCount: 2, // Set the number of columns as per your requirement
         ),
         itemCount: items.length,
         shrinkWrap: true,
         itemBuilder: (BuildContext context, int index) {
           return AnimationConfiguration.staggeredGrid(
             position: index,
             duration: const Duration(milliseconds: 500),
             columnCount: 2, // Set the same value as crossAxisCount
             child: SlideAnimation(
               // verticalOffset: 50.0,
               // horizontalOffset: MediaQuery.of(context).size.width / 2,
               verticalOffset: isVertical ? 50.0 : 0,
               horizontalOffset: isVertical ? 0 : MediaQuery.of(context).size.width / 2,
               child: FadeInAnimation(
                 child: widget,
                 // ListTile(
                 //   title: Text(items[index]),
                 // ),
               ),
             ),
           );
         },
       ):
      ListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              // verticalOffset:  50.0,
              // horizontalOffset: MediaQuery.of(Get.context!).size.width / 2,
              verticalOffset:isVertical? 50.0:0,
              horizontalOffset:isVertical?0: MediaQuery.of(Get.context!).size.width / 2,
              child: FadeInAnimation(
                  child: widget
                // ListTile(
                //   title: Text(items[index]),
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
