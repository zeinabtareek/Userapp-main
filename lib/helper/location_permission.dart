import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../util/app_strings.dart';
import '../view/screens/choose_from_map/choose_from_map_screen.dart';

checkPermissionBeforeNavigate(context)async{

  LocationPermission permission;

  bool serviceEnabled = await Geolocator
      .isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    ScaffoldMessenger.of(context)
        .showSnackBar(  SnackBar(
        content: Text(Strings.locationServicesDisabled.tr,
          style: TextStyle(fontSize: 16),
        )));
    return;
  }
  permission =
  await Geolocator.checkPermission();
  if (permission ==
      LocationPermission.denied) {
    permission =
    await Geolocator.requestPermission();
    if (permission ==
        LocationPermission.denied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(  SnackBar(
          content: Text(
              Strings.locationDenied.tr
          )));
      return;
    }
  }
  if (permission ==
      LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context)
        .showSnackBar(  SnackBar(
        content: Text(Strings.locationPermanentlyDenied.tr
        )));
    return;
  }
  if (permission ==
      LocationPermission.always ||
      permission ==
          LocationPermission.whileInUse) {
    Get.to(()=>ChooseFromMapScreen());
  }

}