import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../extensions/data_type_extensions.dart';
import '../../../../../theme/theme_controller.dart';

class SettingModel {
  RxString lang;
  RxBool isDarkMode;
  RxBool isActiveNotification;
  SettingModel({
    required this.lang,
    required this.isDarkMode,
    required this.isActiveNotification,
  });

  factory SettingModel.getDefault() {
    return SettingModel(
      lang: (Get.locale!.languageCode).obs,
      isDarkMode: (Get.find<ThemeController>().isDarkTheme).obs,
      isActiveNotification: true.obs,
    );
  }
  static const String savedKey = "SettingModel";

  Map<String, dynamic> toMap() {
    return {
      'lang': lang.value,
      'dark_mode': isDarkMode.value == true ? 1 : 0,
      'notification_state': isActiveNotification.value == true ? 1 : 0,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      lang: (map['lang']?.toString() ?? '').obs,
      isDarkMode: (boolFromApi(map['dark_mode']) ?? false).obs,
      isActiveNotification:
          (boolFromApi(map['notification_state']) ?? false).obs,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(json.decode(source));

  SettingModel copyWith({
    String? lang,
    bool? isDarkMode,
    bool? isActiveNotification,
  }) {
    return SettingModel(
      lang: (lang?.obs) ?? this.lang,
      isDarkMode: (isDarkMode?.obs) ?? this.isDarkMode,
      isActiveNotification:
          (isActiveNotification?.obs) ?? this.isActiveNotification,
    );
  }
}
