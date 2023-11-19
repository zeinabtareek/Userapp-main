import '../../../../authenticate/data/models/base_model.dart';
import '../../../../helper/cache_helper.dart';
import '../../../../helper/network/dio_integration.dart';
import '../../../../util/app_constants.dart';
import '../model/req/setting_req_model.dart';

abstract class SettingRepo {
  Future<SettingModel> getSetting();

  Future<SettingModel> updateSetting(SettingModel settingReqModel);

  Future<SettingModel?> saveSettingToLocal(SettingModel settingReqModel);

  Future<SettingModel?> getSettingFromLocal();
}

class SettingRepoImp implements SettingRepo {
  @override
  getSetting() async {
    try {
      final res = await DioUtilNew.dio!.get(
        AppConstants.profileDetails,
      );

      if (res.data['status'] == 200) {
        var resp;
        if ((res.data['data'] is List)) {
          resp = (res.data['data'] as List).first;
        } else {
        resp=  res.data['data'];
        }
        return SettingModel.fromMap(resp);
      } else {
        throw MsgModel.fromJson(res.data);
      }
    } on Exception catch (e) {
      throw MsgModel()..msg= e.toString();
    }
  }

  @override
  updateSetting(SettingModel settingReqModel) async {
    try {
      final res = await DioUtilNew.dio!.post(
        AppConstants.profileDetails,
        data: settingReqModel.toMap(),
      );

      if (res.data['status'] == 200) {
        return SettingModel.fromMap(res.data['data']);
      } else {
        throw MsgModel.fromJson(res.data);
      }
    } on Exception catch (e) {
      throw MsgModel()..msg = e.toString();
    }
  }

  @override
  Future<SettingModel?> getSettingFromLocal() {
    if (!CacheHelper.instance!.containsKey(SettingModel.savedKey)) {
      return Future.value(null);
    } else {
      var json = CacheHelper.getValue(kay: SettingModel.savedKey);
      return Future.value(SettingModel.fromJson(json));
    }
  }

  @override
  Future<SettingModel?> saveSettingToLocal(SettingModel settingReqModel) async {
    var json = settingReqModel.toJson();
    if (await CacheHelper.setValue(kay: SettingModel.savedKey, value: json) ??
        false) {
      return settingReqModel;
    } else {
      return null;
    }
  }
}
