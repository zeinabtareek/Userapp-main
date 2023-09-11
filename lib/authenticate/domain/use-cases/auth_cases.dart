import 'package:ride_sharing_user_app/authenticate/data/models/res-models/user_model.dart';

import '../../data/models/req-model/complete_data_req_model.dart';
import '../../data/models/req-model/login_with_otp_model.dart';
import '../../data/models/req-model/login_with_pass_req_model.dart';
import '../../data/models/req-model/register_req_model.dart';
import '../../data/models/req-model/send_otp_req_model.dart';
import '../../data/models/req-model/update_password_req_model.dart';
import '../../data/models/req-model/verify_phone_req_model.dart';
import '../../typedefs.dart';
import '../repo/auth_repo.dart';

class AuthCases {
  final AuthRepo _data;

  AuthCases(this._data);
  FDH completeData(
    CompleteDataReqModel completeDataReqModel,
  ) {
    return _data.completeData(completeDataReqModel);
  }

  FDM forgetPassword(
    OtpReqModel sendOtpReqModel,
  ) {
    return _data.forgetPassword(sendOtpReqModel);
  }

  Future<User?> getUserData() {
    return _data.getUserData();
  }

  Future<bool> isAuthenticated() {
    return _data.isAuthenticated();
  }

  FDH loginWithOtp(
    LoginWithOtpReqModel loginWithOtpReqModel,
  ) {
    return _data.loginWithOtp(loginWithOtpReqModel);
  }

  FDH loginWithPassword(LoginWithPassReqModel loginWithPassReqModel) {
    return _data.loginWithPassword(loginWithPassReqModel);
  }

  FDH register(HOODRegisterReqModel req) {
    return _data.register(req);
  }

  FDM sendOtp(
    OtpReqModel sendOtpReqModel,
  ) {
    return _data.sendOtp(sendOtpReqModel);
  }

  Future<bool?> setUserDate(User user) {
    return _data.setUserDate(user);
  }

  FDM updatePassword(
    UpdatePasswordReqModel updatePasswordReqModel,
  ) {
    return _data.updatePassword(updatePasswordReqModel);
  }

 FDH verifyPhone(
    VerifyPhoneReqModel verifyPhoneReqModel,
  ) {
        return _data.verifyPhone(verifyPhoneReqModel);

  }
}
