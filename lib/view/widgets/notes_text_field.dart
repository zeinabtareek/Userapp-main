

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/dimensions.dart';
import '../../util/text_style.dart';

class NotesTextField extends StatelessWidget {
  const NotesTextField({
    super.key,
    required this.hint,
    required this.textEditingController,
  });

  final  hint;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      maxLines: 5,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).hintColor.withOpacity(.1),
      hintText: hint,
      hintStyle: textRegular.copyWith(color: Theme.of(context).hintColor.withOpacity(.5)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        borderSide:  BorderSide(width: 0.5,
            color: Theme.of(context).hintColor.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        borderSide:  BorderSide(width: 0.5,
            color: Theme.of(context).primaryColor.withOpacity(0.5)),
      ),


    ),

    );
  }
}