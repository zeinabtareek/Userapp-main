abstract class RegisterReqModel {}

class HOODRegisterReqModel extends RegisterReqModel {
  String fName;
  String lName;
  String countryCode;
  String phone;
  String password;
  HOODRegisterReqModel({
    required this.fName,
    required this.lName,
    required this.countryCode,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    phone = phone.replaceAll(countryCode, "");
    countryCode = countryCode.replaceAll("+", "00");
    return {
      'first_name': fName,
      'last_name': lName,
      'phone_code': countryCode,
      'phone': phone,
      'password': password,
      'password_confirmation': password,
    };
  }
}
