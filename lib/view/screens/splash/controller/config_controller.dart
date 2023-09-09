import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/splash/model/config_model.dart';
import 'package:ride_sharing_user_app/view/screens/splash/repo/config_repo.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/widgets/permission_dialog.dart';

class ConfigController extends GetxController implements GetxService {
  final ConfigRepo configRepo;

  ConfigController({required this.configRepo});

  ConfigModel? _config;

  ConfigModel? get config => _config;

  Future<bool> getConfigData() async {
    Response response = await configRepo.getConfigData();
    bool isSuccess = false;
    if (response.statusCode == 200) {
      isSuccess = true;
      _config = ConfigModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  Future<bool> initSharedData() {
    return configRepo.initSharedData();
  }

  Future<bool> removeSharedData() {
    return configRepo.removeSharedData();
  }

  bool showIntro() {
    return configRepo.showIntro()!;
  }

  void disableIntro() {
    configRepo.disableIntro();
  }

  @override
  onInit() async {
    super.onInit();
    await _determinePosition();
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => const PermissionDialog());

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) => const PermissionDialog());

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => const PermissionDialog());

      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return Geolocator.getCurrentPosition();
  }
}
