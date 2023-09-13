// verify_phone_req_model
class VerifyPhoneReqModel {
  String phone;
  String countryCode;
  String phoneConfirmationToken;
  VerifyPhoneReqModel({
    required this.phone,
    required this.countryCode,
    required this.phoneConfirmationToken,
  });

  Map<String, dynamic> toMap() {
    phone = phone.replaceAll(countryCode, "");
    countryCode = countryCode.replaceAll("+", "00");
    return {
      'phone': phone,
      'phone_code': countryCode,
      'phone_confirmation_token': phoneConfirmationToken,
    };
  }

  factory VerifyPhoneReqModel.fromMap(Map<String, dynamic> map) {
    return VerifyPhoneReqModel(
      phone: map['phone'],
      countryCode: map['countryCode'],
      phoneConfirmationToken: map['phoneConfirmationToken'],
    );
  }
}
