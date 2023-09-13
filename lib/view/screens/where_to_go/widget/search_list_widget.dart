import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';

import '../../../../util/app_style.dart';
import '../controller/where_to_go_controller.dart';
import '../model/search_suggestion_model.dart';

class SearchListWidget extends StatelessWidget {
  RxList<Predictions> listOfSearchedPlaces;
  void Function()? onTap;
    TextEditingController  inputTextField;
  SearchListWidget({super.key, required this.listOfSearchedPlaces,required this.onTap,required this.inputTextField});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(WhereToGoController(setMapRepo: Get.find()));
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(Dimensions.iconSizeSmall),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: K.borderRadiusOnlyTop,
      ),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount:
            listOfSearchedPlaces.isNotEmpty ? listOfSearchedPlaces.length : 2,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             GestureDetector(
               onTap:(){
                 print(listOfSearchedPlaces[index] .structuredFormatting?.secondaryText);
                 // controller. handlePlaceSelection(listOfSearchedPlaces[index].description.toString());
               },
               // onTap: onTap,
               child:  Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
               ),
               child: ListTile(
                   visualDensity:
                   const VisualDensity(horizontal: 0, vertical: -4),
                   leading: Icon(
                     Icons.location_on,
                     color: Theme.of(Get.context!).primaryColor,
                   ),
                   title: Text(
                     listOfSearchedPlaces[index] .structuredFormatting?.mainText.toString()?? listOfSearchedPlaces[index] .structuredFormatting?.secondaryText.toString()??'',
                     maxLines: 1,
                   ),
                   subtitle: Text(
                     listOfSearchedPlaces[index].description.toString() ?? '',
                     style: TextStyle(
                         color: Colors.black.withOpacity(.8), fontSize: 14),
                   ),
                   onTap:
                       () async {
                     print(listOfSearchedPlaces[index] .description);

                     controller. handlePlaceSelection(listOfSearchedPlaces[index].description.toString(),inputTextField );
                     listOfSearchedPlaces.clear();
                     }
                   ),
             ),
             ),
              index == listOfSearchedPlaces.length - 1
                  ? SizedBox()
                  : const Divider(
                      thickness: 1,
                    ),
            ],
          );
        },
      ),
    );
  }
}
