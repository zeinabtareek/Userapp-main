

class ChangePasswordReqModel {
  final String oldPass;
  final String newPass;
  ChangePasswordReqModel({
    required this.oldPass,
    required this.newPass,
  });

  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPass,
      'password': newPass,
      "password_confirmation":newPass,
    };
  }



}
