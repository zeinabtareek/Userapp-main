import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.searchBarSize,
      child: TextField(
        style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),
        cursorColor: Theme.of(context).hintColor,
        autofocus: false,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(50,),left: Radius.circular(50)),
            borderSide: BorderSide(style: BorderStyle.none, width: 0),
          ),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.07),
          isDense: true,
          hintText: 'search'.tr,
          hintStyle:  textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.3)),
          filled: true,
          prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
          suffixIcon:  IconButton(
            color: Theme.of(context).hintColor,
            onPressed: () {
              // if(searchController.searchController.text.trim().isNotEmpty) {
              //   //searchController.clearSearchController();
              // }
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(Icons.arrow_forward,size: 20,),
          ) ,

          prefixIcon:  IconButton(
            padding: EdgeInsets.zero,
            color: Theme.of(context).hintColor,
            onPressed: () {
              // if(searchController.searchController.text.trim().isNotEmpty) {
              //   //searchController.clearSearchController();
              // }
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(Icons.search_outlined,size: 20,),
          ) ,
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
}
