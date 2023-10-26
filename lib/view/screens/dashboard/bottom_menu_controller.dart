import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/view/screens/history/history_screen.dart';
import 'package:ride_sharing_user_app/view/screens/home/home_screen.dart';
import 'package:ride_sharing_user_app/view/screens/notification/notification_screen.dart';
import 'package:ride_sharing_user_app/view/screens/profile/profile_screen/profile_screen.dart';

import '../../../util/app_strings.dart';
import '../../widgets/permission_dialog.dart';

class BottomMenuController extends GetxController implements GetxService {
  int _currentTab = 0;
  int get currentTab => _currentTab;
  final List<Widget> screen = [
    const HomeScreen(),
    const HistoryScreen(
      fromPage: Strings.home,
    ),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  Widget _currentScreen = const HomeScreen();
  Widget get currentScreen => _currentScreen;
  @override
  resetNavBar() {
    _currentScreen = const HomeScreen();
    _currentTab = 0;
  }

  selectHomePage() {
    _currentScreen = const HomeScreen();
    _currentTab = 0;
    update();
  }

  selectActivityScreen() {
    _currentScreen = const HistoryScreen(
      fromPage: Strings.home,
    );
    _currentTab = 1;
    update();
  }

  selectNotificationScreen() {
    _currentScreen = const NotificationScreen();
    _currentTab = 2;
    update();
  }

  selectProfileScreen() {
    _currentScreen = const ProfileScreen();
    _currentTab = 3;
    update();
  }

  ///for determining  location  condition
  // Future<Position?> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     showDialog(
  //         context: Get.context!,
  //         barrierDismissible: false,
  //         builder: (context) => const PermissionDialog());
  //
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   ///LocationPermission.denied
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       showDialog(
  //           context: Get.context!,
  //           barrierDismissible: false,
  //           builder: (context) => const PermissionDialog());
  //
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   ///LocationPermission.deniedForever
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     showDialog(
  //         context: Get.context!,
  //         barrierDismissible: false,
  //         builder: (context) => const PermissionDialog());
  //
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //
  //
  //
  //   return Geolocator.getCurrentPosition();
  // }
}
