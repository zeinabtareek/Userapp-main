import 'dart:io';

import '../../data_state.dart';
import '../../domain/repo/auth_repo.dart';
import '../models/base_model.dart';
import '../models/req-model/change_password_req_model.dart';
import '../models/req-model/complete_data_req_model.dart';
import '../models/req-model/login_with_otp_model.dart';
import '../models/req-model/login_with_pass_req_model.dart';
import '../models/req-model/register_req_model.dart';
import '../models/req-model/send_otp_req_model.dart';
import '../models/req-model/update_password_req_model.dart';
import '../models/req-model/verify_phone_req_model.dart';
import '../models/res-models/register_res_model.dart';
import '../models/res-models/user_model.dart';
import '../services/local/local_auth.dart';
import '../services/remote/remote_auth.dart';

class AuthRepoImp implements AuthRepo {
  final RemoteApiAuth remoteApiAuth;
  final LocalAuth localAuth;
  final SecureLocalAuth secureLocalAuth;
  AuthRepoImp({
    required this.remoteApiAuth,
    required this.localAuth,
    required this.secureLocalAuth,
  });
  @override
  Future<DataState<HOODAuthorizedResModel>> completeData(
      CompleteDataReqModel completeDataReqModel) async {
    try {
      var res = await remoteApiAuth.completeData(completeDataReqModel);
      if (res.response.statusCode == HttpStatus.ok) {
        return DataSuccess(res.data);
      } else {
        return DataFailedErrorMsg(res.data.msg ?? "");
      }
    } catch (e) {
      return DataFailedErrorMsg(e.toString());
    }
  }

  @override
  Future<DataState<MsgModel>> forgetPassword(
      OtpReqModel sendOtpReqModel) async {
    try {
      var res = await remoteApiAuth.forgetPassword(sendOtpReqModel);

      if (res.response.statusCode == HttpStatus.ok) {
        return DataSuccess(res.data);
      } else {
        return DataFailedErrorMsg(res.data.msgg ?? "");
      }
    } catch (e) {
      return DataFailedErrorMsg(e.toString());
    }
  }

  @override
  Future<User?> getUserData() {
    return localAuth.getUser();
  }

  @override
  Future<bool> isAuthenticated() {
    return localAuth.isAuthenticated();
  }

  @override
  Future<DataState<HOODAuthorizedResModel>> loginWithOtp(
      LoginWithOtpReqModel loginWithOtpModel) async {
    try {
      var res = await remoteApiAuth.loginWithOtp(loginWithOtpModel);

      if (res.response.statusCode == HttpStatus.ok) {
        return DataSuccess(res.data);
      } else {
        return DataFailedErrorMsg(res.data.msg ?? "");
      }
    } catch (e) {
      return DataFailedErrorMsg(e.toString());
    }
  }

  @override
  Future<DataState<HOODAuthorizedResModel>> loginWithPassword(
      LoginWithPassReqModel loginWithPassReqModel) async {
    try {
      var res = await remoteApiAuth.loginWithPassword(loginWithPassReqModel);

      if (res.response.statusCode == HttpStatus.ok) {
        return DataSuccess(res.data);
      } else {
        return DataFailedErrorMsg(res.data.msg ?? "");
      }
    } catch (e) {
      return DataFailedErrorMsg(e.toString());
    }
  }

  @override
  Future<DataState<HOODAuthorizedResModel>> register(
      HOODRegisterReqModel req) async {
    try {
      var res = await remoteApiAuth.register(req);

      if (res.response.statusCode == HttpStatus.ok) {
        return DataSuccess(res.data);
      } else {
        return DataFailedErrorMsg(res.data.msg ?? "");
      }
    } catch (e) {
      return DataFailedErrorMsg(e.toString());
    }
  }

  @override
  Future<DataState<MsgModel>> sendOtp(OtpReqModel sendOtpReqModel) async {
    try {
      var res = await remoteApiAuth.sendOtp(sendOtpReqModel);

      if (res.response.statusCode == HttpStatus.ok) {
        return DataSuccess(res.data);
      } else {
        return DataFailedErrorMsg(res.data.msgg ?? "");
      }
    } catch (e) {
      return DataFailedErrorMsg(e.toString());
    }
  }

  @override
  Future<bool?> setUserDate(User? user) {
    return localAuth.setUser(user);
  }

  @override
  Future<DataState<MsgModel>> updatePassword(
      UpdatePasswordReqModel updatePasswordReqModel) async {
    try {
      var res = await remoteApiAuth.updatePassword(updatePasswordReqModel);

      if (res.response.statusCode == HttpStatus.ok) {
        return DataSuccess(res.data);
      } else {
        return DataFailedErrorMsg(res.data.msgg ?? "");
      }
    } catch (e) {
      return DataFailedErrorMsg(e.toString());
    }
  }

  @override
  Future<DataState<HOODAuthorizedResModel>> verifyPhone(
      VerifyPhoneReqModel verifyPhoneReqModel) async {
    try {
      var res = await remoteApiAuth.verifyPhone(verifyPhoneReqModel);

      if (res.response.statusCode == HttpStatus.ok) {
        return DataSuccess(res.data);
      } else {
        return DataFailedErrorMsg(res.data.msg ?? "");
      }
    } catch (e) {
      return DataFailedErrorMsg(e.toString());
    }
  }

  @override
  Future<DataState<MsgModel>> changePass(ChangePasswordReqModel req) async {
    try {
      final res = await remoteApiAuth.changePass(req);
      if (res.response.statusCode == HttpStatus.ok) {
        return DataSuccess(res.data);
      } else {
        return DataFailedErrorMsg(res.data.msg ?? "");
      }
    } catch (e) {
      return DataFailedErrorMsg(e.toString());
    }
  }

  @override
  Future<LoginWithPassReqModel?> getAuthUserData() {
    return secureLocalAuth.getAuthUserData();
  }

  @override
  Future<bool> isContainsAuthUserData() {
    return secureLocalAuth.isContainsAuthUserData();
  }

  @override
  Future<void> saveAuthUserData(LoginWithPassReqModel? loginWithPassReqModel) {
    return secureLocalAuth.saveAuthUserData(loginWithPassReqModel);
  }
}
