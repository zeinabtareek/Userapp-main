import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../helper/cache_helper.dart';
import '../../models/req-model/login_with_pass_req_model.dart';
import '../../models/res-models/user_model.dart';
import 'i_local_auth.dart';

class LocalAuth implements ILocalAuth<UserAuthModel> {
  final String key = "user";

  @override
  Future<UserAuthModel?> getUser() {
    String jsn = CacheHelper.getValue(kay: key) as String;
    return Future.value(UserAuthModel.fromJson(jsn));
  }

  @override
  Future<bool?> setUser(UserAuthModel? user) async {
    if (user != null) {
      return CacheHelper.setValue(kay: key, value: user.toJson());
    } else {
      return CacheHelper.deleteOneValue(kay: key);
    }
  }

  @override
  Future<bool> isAuthenticated() {
    return Future.value(CacheHelper.instance?.containsKey(key));
  }
}

class SecureLocalAuth implements ISecureLocalAuth<LoginWithPassReqModel> {
  FlutterSecureStorage secureStorage;
  SecureLocalAuth(this.secureStorage);

  String key = "SecureLocalAuth";
  @override
  Future<LoginWithPassReqModel?> getAuthUserData() async {
    String? json = await secureStorage.read(key: key);

    if (json != null) {
      return LoginWithPassReqModel.fromJson(json);
    } else {
      return null;
    }
  }

  @override
  Future<bool> isContainsAuthUserData() async {
    return await secureStorage.containsKey(key: key);
  }

  @override
  Future<void> saveAuthUserData(LoginWithPassReqModel? user) async {
    if (user == null) {
      return await secureStorage.delete(key: key);
    } else {
      return await secureStorage.write(
        key: key,
        value: json.encode(user.toJson()),
      );
    }
  }
}
