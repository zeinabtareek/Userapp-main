import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';

import '../../choose_from_map/choose_from_map_screen.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode node;
  final String? hint;
  final VoidCallback? onTap;
  const InputField({Key? key, required this.controller, required this.node, this.hint,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 45,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark.withOpacity(.25),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
      ),
      child:
      TextFormField(
        controller: controller,
        style: textRegular.copyWith(color: Colors.white.withOpacity(0.8)),
        focusNode: node,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
          hintText: hint ?? 'Enter Route',
          // suffixIcon:  suffixIcon ,
          suffixIcon: IconButton(
    icon :Icon(Icons.place_outlined, color: Colors.white.withOpacity(0.7),
          ),onPressed: onTap,
          ),
          hintStyle: textRegular.copyWith(color: Colors.white.withOpacity(0.5)),
          enabledBorder: UnderlineInputBorder(
            borderSide:  BorderSide(width: 0.5,
                color: Theme.of(context).hintColor.withOpacity(0.5)),
          ),


        ),
        cursorColor: Colors.white,

      ),);
  }
}
