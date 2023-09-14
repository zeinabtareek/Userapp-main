// verify_phone_req_model
import '../base_phone_req_model.dart';

class VerifyPhoneReqModel {
  BasePhoneReqModel phoneReqModel;
  String phoneConfirmationToken;
  VerifyPhoneReqModel({
    required this.phoneReqModel,
    required this.phoneConfirmationToken,
  });

  Map<String, dynamic> toMap() {
    return {
      ...phoneReqModel.toJson(),
      'phone_confirmation_token': phoneConfirmationToken,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
