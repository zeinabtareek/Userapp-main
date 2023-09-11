import 'dart:convert';

class OtpReqModel {
  String? countryCode;
  String? phone;
  OtpReqModel({
    this.countryCode,
    this.phone,
  });

  Map<String, dynamic> toJson() {
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
