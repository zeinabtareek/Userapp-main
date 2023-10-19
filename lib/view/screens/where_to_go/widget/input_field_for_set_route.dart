import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode node;
  void Function(String)? onChange;
  final String? hint;
  final VoidCallback? onTap;
  final VoidCallback? onClear;

  InputField({
    Key? key,
    required this.controller,
    required this.node,
    this.hint,
    this.onTap,
    this.onChange,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool isEmptyFelid = RxBool(controller.text.isEmpty);
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark.withOpacity(.25),
          borderRadius:
              BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
      child: TextFormField(
        controller: controller,
        enabled: true,
        style: textRegular.copyWith(color: Colors.white.withOpacity(0.8)),
        focusNode: node,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall,
              vertical: Dimensions.paddingSizeSmall),
          hintText: hint ?? 'Enter Route',
          // suffixIcon:  suffixIcon ,
          suffixIcon: Obx(() => suffixIcon(isEmptyFelid.isTrue)),
          hintStyle: textRegular.copyWith(color: Colors.white.withOpacity(0.5)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                width: 0.5,
                color: Theme.of(context).hintColor.withOpacity(0.5)),
          ),
        ),
        onChanged: (text) {
          onChange?.call(text);
          isEmptyFelid(text.isEmpty);
        },
        cursorColor: Colors.white,
      ),
    );
  }

  IconButton suffixIcon(bool state) {
    return state
        ? IconButton(
            icon: Icon(
              Icons.place_outlined,
              color: Colors.white.withOpacity(0.7),
            ),
            onPressed: onTap,
          )
        : IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white.withOpacity(0.7),
            ),
            onPressed: onClear,
          );
  }
}
