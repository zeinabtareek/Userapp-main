class BasePhoneReqModel {
  BasePhoneReqModel({
    required this.phone,
    required this.phoneCode,
  }) {
    phone = phone.replaceFirst(phoneCode, "");
  }

  String phone;
  String phoneCode;

  Map<String, dynamic> toJson() {
    return {
      "phone_code": phoneCode,
      "phone": phone,
    };
  }

  factory BasePhoneReqModel.froMap(Map<String, dynamic> map) {
    return BasePhoneReqModel(phone: map['phone'], phoneCode: map['phone_code']);
  }

  @override
  String toString() {
    return " phone: $phone, phoneCode: $phoneCode";
  }
}
