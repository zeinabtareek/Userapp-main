
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view/screens/profile/widgets/pick_image_widget.dart';
import 'display_helper.dart';

class CustomPickHelper {
  static Future<File?> pickImage(ImageSource imageSource) async {
    XFile? file = await ImagePicker().pickImage(
        source: imageSource, maxHeight: 500, maxWidth: 500, imageQuality: 50);

    if (file != null) {
      return File(file.path);
    }
    return null;
  }
  static Future <File?> showPickImageBottomSheet(BuildContext context) {
    File ? file;
    return showModalBottomSheet<File?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return   PickImageWidget(
          onCameraTap: () async{

            file= await pickImage(ImageSource.camera);
            Navigator.of(context).pop(file);

          },
          onGalleryTap: () async{
            file= await pickImage(ImageSource.gallery);
            Navigator.of(context).pop(file);

          },);
      },
    );
    return Future.value(file);
  }
  static Future<File?> pickVideo(ImageSource imageSource) async {
    XFile? file = await ImagePicker().pickVideo(source: imageSource);

    if (file != null) {
      return File(file.path);
    }
    return null;
  }

  static Future<FilePickerResult?> pickImageVideo() async {
    return checkPermission(() async {
      FilePicker.platform.clearTemporaryFiles();
      FilePickerResult? file = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowCompression: true,
          allowMultiple: false,
          withData: true,
          allowedExtensions: [...imageFileExtensions, ...videoFileExtensions]);
      if (file != null) {
        if (file.files.isNotEmpty) {
          return file;
        }
      }
      return null;
    });
  }

  static Future<FilePickerResult?> checkPermission(Function accepted) async {
    final PermissionStatus status =
        await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      return accepted();
    } else {

            showCustomSnackBar(status.name);

      return null;
    }
  }

  static List<String> imageFileExtensions = [
    'jpeg',
    'jpg',
    'png',
    'gif',
    'bmp',
    'tiff',
    'tif',
    'webp',
    'heic',
    'heif',
    'svg',
  ];

  static List<String> videoFileExtensions = [
    'mp4',
    'avi',
    'mov',
    'mkv',
    'wmv',
    'flv',
    'mpeg',
    'mpg',
    '3gp',
    'webm',
    'm4v',
  ];
}


