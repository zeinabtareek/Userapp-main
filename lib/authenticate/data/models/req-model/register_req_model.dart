import 'package:ride_sharing_user_app/authenticate/data/models/base_phone_req_model.dart';

abstract class RegisterReqModel {}

class HOODRegisterReqModel extends RegisterReqModel {
  String fName;
  String lName;
  BasePhoneReqModel phoneReqModel;
  String password;
  HOODRegisterReqModel({
    required this.fName,
    required this.lName,
 required this.phoneReqModel,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': fName,
      'last_name': lName,
   ... phoneReqModel.toJson(),
      'password': password,
      'password_confirmation': password,
    };
  }
}
