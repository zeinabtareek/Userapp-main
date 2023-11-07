import '../../data/models/base_phone_req_model.dart';
import '../../data/models/req-model/change_password_req_model.dart';
import '../../data/models/req-model/complete_data_req_model.dart';
import '../../data/models/req-model/login_with_otp_model.dart';
import '../../data/models/req-model/login_with_pass_req_model.dart';
import '../../data/models/req-model/register_req_model.dart';
import '../../data/models/req-model/update_password_req_model.dart';
import '../../data/models/req-model/verify_phone_req_model.dart';
import '../../data/models/res-models/user_model.dart';
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
    BasePhoneReqModel sendOtpReqModel,
  ) {
    return _data.forgetPassword(sendOtpReqModel);
  }

  Future<UserAuthModel?> getUserData() {
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
    BasePhoneReqModel sendOtpReqModel,
  ) {
    return _data.sendOtp(sendOtpReqModel);
  }

  Future<bool?> setUserDate(UserAuthModel? user) {
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

  FDM changePass(ChangePasswordReqModel req) async {
    return _data.changePass(req);
  }

  Future<LoginWithPassReqModel?> getAuthUserData() async {
    return _data.getAuthUserData();
  }

  Future<void> saveAuthUserData(LoginWithPassReqModel? loginWithPassReqModel) {
    return _data.saveAuthUserData(loginWithPassReqModel);
  }

  Future<bool> isContainsAuthUserData() async {
    return _data.isContainsAuthUserData();
  }

  FDM checkOtpCode(LoginWithOtpReqModel req) async {
    return _data.checkOtpCode(req);
  }

    logout() {
    return _data.logout();
  }

  deleteAcc() {
    return _data.deleteAcc();
  }
}
