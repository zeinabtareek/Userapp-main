import 'dart:convert';

class LoginWithOtpReqModel {
  String? countryCode;
  String? phone;
  String? otp;
  LoginWithOtpReqModel({
    required this.countryCode,
    required this.phone,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    phone = phone!.replaceAll(countryCode!, "");
    countryCode = countryCode!.replaceAll("+", "00");
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
