import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../../../config/config.dart';
import '../../models/base_model.dart';
import '../../models/req-model/complete_data_req_model.dart';
import '../../models/req-model/login_with_otp_model.dart';
import '../../models/req-model/login_with_pass_req_model.dart';
import '../../models/req-model/register_req_model.dart';
import '../../models/req-model/send_otp_req_model.dart';
import '../../models/req-model/update_password_req_model.dart';
import '../../models/req-model/verify_phone_req_model.dart';
import '../../models/res-models/register_res_model.dart';

part 'remote_auth.g.dart';

@RestApi(baseUrl:  AuthLib.baseUrl)
abstract class RemoteApiAuth {
  factory RemoteApiAuth(Dio dio) =  _RemoteApiAuth;

  @POST(AuthLib.registerEndPoint)
  Future<HttpResponse<HOODAuthorizedResModel>> register(
    @Body() HOODRegisterReqModel req,
  );

  @POST(AuthLib.loginWithPassEndPoint)
  Future<HttpResponse<HOODAuthorizedResModel>> loginWithPassword(
    @Body() LoginWithPassReqModel req,
  );

  @POST(AuthLib.loginWithOtpEndPoint)
  Future<HttpResponse<HOODAuthorizedResModel>> loginWithOtp(
    @Body() LoginWithOtpReqModel req,
  );

  @POST(AuthLib.completeDataEndPoint)
  Future<HttpResponse<HOODAuthorizedResModel>> completeData(
    @Body() CompleteDataReqModel req,
  );

  @POST(AuthLib.verifyPhoneEndPoint)
  Future<HttpResponse<HOODAuthorizedResModel>> verifyPhone(
    @Body() VerifyPhoneReqModel req,
  );

  @POST(AuthLib.sendOtpEndPoint)
  Future<HttpResponse<MsgModel>> sendOtp(
    @Body() OtpReqModel req,
  );

  @POST(AuthLib.forgetPasswordEndPoint)
  Future<HttpResponse<MsgModel>> forgetPassword(
    @Body() OtpReqModel req,
  );

  @POST(AuthLib.updatePasswordEndPoint)
  Future<HttpResponse<MsgModel>> updatePassword(
    @Body() UpdatePasswordReqModel req,
  );
}
