import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../helper/custom_pick_helper.dart';
import '../../util/dimensions.dart';
import '../../util/images.dart';

class ImagePick extends StatelessWidget {
  final Function(File img) onSelectImg;
  final Function() deleteImg;
  final double? hight;
  final double? width;
  ImagePick({
    super.key,
    required this.onSelectImg,
    required this.deleteImg,
    this.hight,
    this.width,
  });

  final Rxn<File> selectedFile = Rxn(null);

  bool get isPickedImg => selectedFile.value != null;

  void pickImg() {
    CustomPickHelper.pickImage(ImageSource.camera).then((value) {
      if (value != null) {
        selectedFile.value = value;
        onSelectImg(value);
        // setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Align(
        alignment: Alignment.center,
        child: Obx(
          () => DottedBorder(
            color: Theme.of(context).hintColor,
            dashPattern: const [3, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(Dimensions.paddingSizeSmall),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child:
                  // authController.pickedIdentityImageFront != null
                  isPickedImg
                      ? Stack(
                          alignment: FractionalOffset.bottomLeft,
                          children: [
                            // StatefulBuilder(builder: ())
                            Image.file(
                              File(selectedFile.value!.path),
                              width: width ?? Dimensions.identityImageWidth,
                              height: hight ?? Dimensions.identityImageHeight,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                              onPressed: () {
                                selectedFile.value = null;

                                deleteImg.call();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 25,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: pickImg,
                          child: SizedBox(
                            height: hight ?? Dimensions.identityImageHeight,
                            width: width ?? Dimensions.identityImageWidth,
                            child: Image.asset(Images.cameraPlaceholder,
                                width: 50),
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
