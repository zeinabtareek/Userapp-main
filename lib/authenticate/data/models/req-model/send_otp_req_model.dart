import 'dart:convert';

class OtpReqModel {
  String? countryCode;
  String? phone;
  OtpReqModel({
    required this.countryCode,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    phone = phone!.replaceAll(countryCode!, "");
    countryCode = countryCode!.replaceAll("+", "00");
    return {
      'phone_code': countryCode,
      'phone': phone,
    };
  }

  factory OtpReqModel.fromMap(Map<String, dynamic> map) {
    return OtpReqModel(
      countryCode: map['countryCode'],
      phone: map['phone'],
    );
  }

  factory OtpReqModel.fromJson(String source) =>
      OtpReqModel.fromMap(json.decode(source));
}
