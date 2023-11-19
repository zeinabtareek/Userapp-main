import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';

import '../../../../authenticate/data/models/base_model.dart';
import '../../../../bases/base_controller.dart';
import '../../../../helper/cache_helper.dart';
import '../../../../localization/localization_controller.dart';
import '../../../../theme/theme_controller.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../model/req/setting_req_model.dart';
import '../repo/setting_repo.dart';
// import 'package:ride_sharing_user_app/view/screens/auth/repository/auth_repo.dart';

// class AuthController extends GetxController implements GetxService {
//   final AuthRepo authRepo;
//   AuthController({required this.authRepo});
//
//
//
// }

class SettingsController extends BaseController {
  SettingRepoImp repo = SettingRepoImp();

  Rx<SettingModel> settingModel = (SettingModel.getDefault()).obs;

  RxBool isUpdateMode = false.obs;

  RxBool isActiveNonfiction = true.obs;

  RxBool isActiveDark = true.obs;

  RxString lang = "en".obs;

  @override
  void onInit() {
    if (!CacheHelper.instance!.containsKey(SettingModel.savedKey)) {
      settingModel = (SettingModel.getDefault()).obs;
      _collectData();
      saveSettingToRemote();
    } else {
      _handelGetSettingFromWhere().then((_) => _collectData());
    }

    // _collectData();
    super.onInit();
  }

  Future _handelGetSettingFromWhere() async {
    if (await getSettingFromLocal() == null) {
      await getSettingFromRemote();
    }
  }

  void _collectData() {
    isActiveDark.value = settingModel.value.isDarkMode.value;
    isActiveNonfiction.value = settingModel.value.isActiveNotification.value;
    lang.value = settingModel.value.lang.value;
  }

  RxBool isLoading = false.obs;

  Future getSettingFromLocal() async {
    isLoading(true);
    final res = await repo.getSettingFromLocal();
    isLoading(false);
    if (res != null) {
      settingModel(res);
      return settingModel.value = res;
    } else {
      return null;
    }
  }

  saveSettingToLocal() async {
    isLoading(true);
    final res = await repo.saveSettingToLocal(settingModel.value);
    isLoading(false);
    if (res != null) {
      settingModel.value = res;
    }
    update();
  }

  Future getSettingFromRemote() async {
    final state = await actionCenter.execute(
      () async {
        try {
          isLoading(true);

          final res = await repo.getSetting();
          settingModel.value = res;
          isLoading(false);
          await saveSettingToLocal();
          update();
        } on MsgModel catch (e) {
          OverlayHelper.showErrorToast(Get.overlayContext!, e.msg ?? "");
        }
      },
      checkConnection: true,
    );
  }

  saveSettingToRemote() async {
    final state = await actionCenter.execute(
      () async {
        try {
          isLoading(true);

          final res = await repo.updateSetting(
            SettingModel(
              lang: lang,
              isDarkMode: isActiveDark,
              isActiveNotification: isActiveNonfiction,
            ),
          );
          var oldSetting = settingModel.value;
          settingModel.value = res;
          isLoading(false);
          await saveSettingToLocal();
          updateLang(oldSetting);
          updateTheme();
          isUpdateMode(false);
          update();
        } on MsgModel catch (e) {
          OverlayHelper.showErrorToast(Get.overlayContext!, e.msg ?? "");
        }
      },
      checkConnection: true,
    );
  }

  updateLang(SettingModel setting) {
    if (lang.value == 'en') {
      Get.find<LocalizationController>().setLanguage(const Locale('en', 'US'));
    } else {
      Get.find<LocalizationController>().setLanguage(const Locale('ar', 'SA'));
    }
    if(lang.value!=setting.lang.value){
      Restart.restartApp();
    }
  }

  updateTheme() {
    Get.find<ThemeController>().changeThemeSetting(isActiveDark.value);
  }
}
