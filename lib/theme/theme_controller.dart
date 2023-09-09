import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final SharedPreferences sharedPreferences;
  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences.setBool(AppConstants.theme, _darkTheme);
    update();
  }

  void changeThemeSetting(bool theme){
    _darkTheme = theme;
    sharedPreferences.setBool(AppConstants.theme, theme);
    update();
  }

  void _loadCurrentTheme() async {
    _darkTheme = sharedPreferences.getBool(AppConstants.theme) ?? false;
    update();
  }
}