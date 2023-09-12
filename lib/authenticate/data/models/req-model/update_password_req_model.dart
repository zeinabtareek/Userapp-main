import 'dart:convert';

class UpdatePasswordReqModel {
  String? countryCode;
  String? phone;
  String? password;
  String? forgetPasswordCode;
  UpdatePasswordReqModel({
   required this.countryCode,
   required this.phone,
   required this.password,
   required this.forgetPasswordCode,
  });

  Map<String, dynamic> toJson() {
    phone = phone!.replaceAll(countryCode!, "");
    countryCode = countryCode!.replaceAll("+", "00");
    return {
      'phone_code': countryCode,
      'phone': phone,
      'password': password,
      'password_confirmation':password,
      'forget_password_code': forgetPasswordCode,
    };
  }

  factory UpdatePasswordReqModel.fromMap(Map<String, dynamic> map) {
    return UpdatePasswordReqModel(
      countryCode: map['countryCode'],
      phone: map['phone'],
      password: map['password'],
      forgetPasswordCode: map['forgetPasswordCode'],
    );
  }

  // String toJson() => json.encode(toMap());

  factory UpdatePasswordReqModel.fromJson(String source) => UpdatePasswordReqModel.fromMap(json.decode(source));
}
