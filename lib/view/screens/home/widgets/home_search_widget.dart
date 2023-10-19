import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';

import '../../../../util/app_strings.dart';
import '../../ride/controller/ride_controller.dart';
import '../../where_to_go/controller/where_to_go_controller.dart';
import '../../where_to_go/where_to_go_screen.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
        // initState: (_) => con.getCategoryList(),
    builder: (rideController)
    {
      return SizedBox(
        // height: Dimensions.identityImageHeight,
        child: TextField(
          onTap: () {
            rideController.isFromCat.value=false;
            Get.to(() =>
                SetDestinationScreen(
                    fromCat: rideController.isFromCat.value)); //false
          },
          style: textRegular.copyWith(
              color: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium!
                  .color!
                  .withOpacity(0.8)),
          cursorColor: Theme
              .of(context)
              .hintColor,
          autofocus: false,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(
                vertical: Dimensions.iconSizeSmall, horizontal: 5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.menuIconSize),
              borderSide: BorderSide(
                  width: 0.5,
                  color: Theme
                      .of(context)
                      .hintColor
                      .withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide:
              BorderSide(width: 0.5, color: Theme
                  .of(context)
                  .primaryColor),
            ),
            fillColor: Theme
                .of(context)
                .primaryColor
                .withOpacity(0.07),
            isDense: true,
            hintText: Strings.whereToGo.tr,
            hintStyle: textRegular.copyWith(
                color: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withOpacity(0.3)),
            filled: true,
            prefixIconConstraints:
            const BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: IconButton(
              padding: EdgeInsets.zero,
              color: Theme
                  .of(context)
                  .hintColor,
              onPressed: () {
                // if(searchController.searchController.text.trim().isNotEmpty) {
                //   //searchController.clearSearchController();
                // }
                FocusScope.of(context).unfocus();
              },
              icon: Image.asset(
                Images.homeSearchIcon,
                height: 25,
                width: 25,
              ),
            ),
          ),
          //onChanged: (text) => searchController.showSuffixIcon(context,text),
          // onSubmitted: (text) {
          //   if(text.isNotEmpty) {
          //     searchController.searchData(text);
          //   }
          // },
        ),
      );
    }
    );}
}
