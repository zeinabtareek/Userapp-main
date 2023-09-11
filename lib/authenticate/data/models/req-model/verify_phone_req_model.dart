
// verify_phone_req_model
class VerifyPhoneReqModel {
  String? phone;
  String? countryCode;
  String? phoneConfirmationToken;
  VerifyPhoneReqModel({
    this.phone,
    this.countryCode,
    this.phoneConfirmationToken,
  });

  Map<String, dynamic> toMap() {
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
