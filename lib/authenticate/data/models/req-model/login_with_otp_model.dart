import 'dart:convert';

class LoginWithOtpReqModel {
  String? countryCode;
  String? phone;
  String? otp;
  LoginWithOtpReqModel({
    this.countryCode,
    this.phone,
    this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_code': countryCode,
      'phone': phone,
      'otp': otp,
    };
  }

  factory LoginWithOtpReqModel.fromMap(Map<String, dynamic> map) {
    return LoginWithOtpReqModel(
      countryCode: map['countryCode'],
      phone: map['phone'],
      otp: map['otp'],
    );
  }


  factory LoginWithOtpReqModel.fromJson(String source) =>
      LoginWithOtpReqModel.fromMap(json.decode(source));
}
