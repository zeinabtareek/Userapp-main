import 'dart:async';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/view/screens/splash/get_app_version_use_case.dart';

import '../../../../authenticate/config/config.dart';
import '../../../../authenticate/domain/use-cases/auth_cases.dart';
import '../../../../initialize_dependencies.dart';
import '../../dashboard/dashboard_screen.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    showDialogIfFoundUpdate();
    // Timer(const Duration(seconds: 5), () async {
      Future.delayed(const Duration(milliseconds: 2500), () async {
    // Future.delayed(const Duration(seconds: 30), () async {
      if (await sl<AuthCases>().isAuthenticated()) {
        Get.offAll(DashboardScreen());
      } else {
        Get.offAllNamed(AuthScreenPath.loginScreenWithPassRouteName);
      }
    });
  }

  Future<String> currentAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }

  Future<String> getStoreAppVersion() async {
    String appVersion = '';
    await actionCenter.execute(
        () async => appVersion = await GetAppVersionUseCase().call(),
        checkConnection: true);

    return appVersion;
  }

  void showDialogIfFoundUpdate() async {
    if (await currentAppVersion() != await getStoreAppVersion()) {
      print(" New Update Available ");
      // Get.defaultDialog(title: "New Update Available", content: );
    }
  }
}
