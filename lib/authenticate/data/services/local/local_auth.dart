import '../../../../helper/cache_helper.dart';
import '../../models/res-models/user_model.dart';
import 'i_local_auth.dart';

class LocalAuth implements ILocalAuth<User> {
  LocalAuth() {
    CacheHelper.init();
  }
  final String key = "user";

  @override
  Future<User?> getUser() {
    String jsn = CacheHelper.getValue(kay: key) as String;
    return Future.value(User.fromJson(jsn));
  }

  @override
  Future<bool?> setUser(User? user) async {
    if (user != null) {
      return CacheHelper.setValue(kay: key, value: user.toJson());
    } else {
     return CacheHelper.deleteOneValue(kay: key);
    }
  }

  @override
  Future<bool> isAuthenticated() {
    return Future.value(CacheHelper.instance!.containsKey(key));
  }
}
