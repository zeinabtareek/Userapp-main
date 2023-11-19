import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/offer/model/level_model.dart';

import '../../../../authenticate/data/models/base_model.dart';
import '../../../../authenticate/data/models/res-models/user_model.dart';
import '../../../../helper/network/dio_integration.dart';
import '../../../../util/app_constants.dart';
import '../model/edit_profile_req_model.dart';

class UserRepo {
  Future<UserAuthModel> updateProfile(
    EditProfileReqModel updateProfileReqModel,
  ) async {
    try {
      final res = await DioUtilNew.dio!.post(
        AppConstants.updateProfile,
        data: await updateProfileReqModel.toForm(),
      );

      if (res.data['status'] == 200) {
        return UserAuthModel.fromMap(
          res.data['data'],
          msg: res.data['message'],
        );
      } else {
        throw MsgModel.fromJson(res.data);
      }
    } on Exception catch (e) {
      throw MsgModel()..msg = e.toString();
    }
  }
}
