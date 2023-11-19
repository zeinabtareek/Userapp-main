import 'dart:async';

import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/view/screens/splash/get_app_version_use_case.dart';

import '../../../../authenticate/config/config.dart';
import '../../../../authenticate/domain/use-cases/auth_cases.dart';
import '../../../../initialize_dependencies.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../parcel/screens/parcel_home_screen.dart';

class SplashController extends BaseController {
  @override
    onInit() async{
    super.onInit();
    showDialogIfFoundUpdate();
    //   Future.delayed(const Duration(milliseconds: 2500), () async {
    // await  route();
    // });
  }
  final gifController = GifController(
    loop: false,
    onFinish: () {
      _route();
    },
  );
 static _route()async{
    if (await sl<AuthCases>().isAuthenticated()) {
      Get.to(() => const ParcelHomeScreen());
      // Get.offAll(DashboardScreen());
    } else {
      Get.offAllNamed(AuthScreenPath.loginScreenWithPassRouteName);
    }
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
