import 'dart:convert';

abstract class LoginReqModel {}

class LoginWithPassReqModel implements LoginReqModel {
  String countryCode;
  String phone;
  String password;
  LoginWithPassReqModel({
    required this.countryCode,
    required this.phone,
    required this.password,
  }) {
    phone = phone.replaceFirst(countryCode, "");
    countryCode = countryCode.replaceFirst("+", "");
  }

  Map<String, dynamic> toJson() {
    return {
      'phone_code': countryCode,
      'phone': phone,
      'password': password,
    };
  }

  factory LoginWithPassReqModel.fromMap(Map<String, dynamic> map) {
    return LoginWithPassReqModel(
      countryCode: map['phone_code'],
      phone: map['phone'],
      password: map['password'],
    );
  }

  factory LoginWithPassReqModel.fromJson(String source) =>
      LoginWithPassReqModel.fromMap(json.decode(source));
}
