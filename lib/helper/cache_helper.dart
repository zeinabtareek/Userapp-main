import 'package:shared_preferences/shared_preferences.dart';
//cache_helper 
class CacheHelper {
  static SharedPreferences? _sharedPreferences;
  CacheHelper._();

  static SharedPreferences? get instance => _sharedPreferences;
  static init() async =>
      _sharedPreferences ??= await SharedPreferences.getInstance();

  static Future<bool?> setValue({
    required String kay,
    required Object value,
  }) async {
    if (value is String) {
      return _sharedPreferences!.setString(kay, value);
    } else if (value is int) {
      return _sharedPreferences!.setInt(kay, value);
    } else if (value is bool) {
      return _sharedPreferences!.setBool(kay, value);
    } else if (value is double) {
      return _sharedPreferences!.setDouble(kay, value);
    } else if (value is List<String>) {
      return _sharedPreferences!.setStringList(kay, value);
    }
    return null;
  }

  static Object? getValue({
    required String kay,
    dynamic onNullVal,
  }) =>
      _sharedPreferences!.get(kay) ?? onNullVal;

  static Future<bool>? deleteOneValue({
    required String? kay,
  }) async =>
      _sharedPreferences!.remove(kay!);

  static Future<bool>? deleteAllValues() async => _sharedPreferences!.clear();
}
