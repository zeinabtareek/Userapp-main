import 'dart:convert';

abstract class LoginReqModel {}

class LoginWithPassReqModel implements LoginReqModel {
  String? countryCode;
  String? phone;
  String? password;
  LoginWithPassReqModel({
    this.countryCode,
    this.phone,
    this.password,
  });

  Map<String, dynamic> toJson() {
    phone = phone!.replaceFirst(countryCode!, "");
    countryCode = countryCode!.replaceFirst("+", "");
    return {
      'phone_code': countryCode,
      'phone': phone,
      'password': password,
    };
  }

  factory LoginWithPassReqModel.fromMap(Map<String, dynamic> map) {
    return LoginWithPassReqModel(
      countryCode: map['countryCode'],
      phone: map['phone'],
      password: map['password'],
    );
  }

  factory LoginWithPassReqModel.fromJson(String source) =>
      LoginWithPassReqModel.fromMap(json.decode(source));
}
