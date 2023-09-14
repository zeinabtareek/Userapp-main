import 'dart:convert';

import '../base_phone_req_model.dart';

class LoginWithOtpReqModel {
  BasePhoneReqModel phoneReqModel;
  String? otp;
  LoginWithOtpReqModel({
  required this.phoneReqModel,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
    ...phoneReqModel.toJson(),
      'otp': otp,
    };
  }


}
