import 'dart:convert';

import '../base_phone_req_model.dart';

class UpdatePasswordReqModel {
  BasePhoneReqModel phoneReqModel;
  String? password;
  String? forgetPasswordCode;
  UpdatePasswordReqModel({
    required this.phoneReqModel,
    required this.password,
    required this.forgetPasswordCode,
  });

  Map<String, dynamic> toJson() {
    return {
...phoneReqModel.toJson(),
      'password': password,
      'password_confirmation': password,
      'forget_password_code': forgetPasswordCode,
    };
  }

}
