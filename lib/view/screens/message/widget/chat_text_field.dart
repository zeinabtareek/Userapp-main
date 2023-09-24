import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/text_style.dart';

class ChatTextField extends StatelessWidget {
  final formKey;
  final onPickMultipleImage;
  final onPickFiles;
  final bool isLoading;
  final onSendMessageTap;
  final TextEditingController conversationController;

  const ChatTextField({
    super.key,
    required this.formKey,
    required this.conversationController,
    required this.onSendMessageTap,
    required this.onPickFiles,
    required this.onPickMultipleImage,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimensions.paddingSizeSmall,
        right: Dimensions.paddingSizeSmall,
        bottom: Dimensions.paddingSizeSmall,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 4),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Form(
        key: formKey,
        child: Row(
          children: [
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(
              child: TextField(
                controller: conversationController,
                textCapitalization: TextCapitalization.sentences,
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .color!
                      .withOpacity(0.8),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Strings.typeHere.tr,
                  hintStyle: textRegular.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color!
                        .withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                onChanged: (String newText) {},
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall),
                  child: InkWell(
                      child: Image.asset(Images.pickImage,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                      onTap: onPickMultipleImage),
                ),
                InkWell(
                  onTap: onPickFiles,
                  child: Image.asset(Images.pickFile,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                isLoading == true
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 20,
                        width: 40,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).hoverColor,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: onSendMessageTap,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall,
                          ),
                          child: Image.asset(
                            Images.sendMessage,
                            width: 25,
                            height: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
