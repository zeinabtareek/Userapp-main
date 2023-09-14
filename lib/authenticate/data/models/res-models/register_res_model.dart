import 'dart:convert';

import '../base_model.dart';
import 'user_model.dart';

abstract class RegisterResModel {}

class HOODAuthorizedResModel extends BaseResModel<HOODAuthorizedResModel>
    implements RegisterResModel {
  @override
  String? msg;
  @override
  int? status;
  User? user;

  HOODAuthorizedResModel(
    this.user, {
    this.msg,
    this.status,
  }) : super(msg: msg, status: status);

  factory HOODAuthorizedResModel.fromJson(Map<String, dynamic> json) {
    return HOODAuthorizedResModel(
      json["data"] != null ? User.fromMap(json["data"]) : null,
      msg: json["message"],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() => {"data": user?.toMap()};

  String toJson() => json.encode(toMap());

  @override
  HOODAuthorizedResModel? get data => this;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HOODAuthorizedResModel && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => 'HOODAuthorizedResModel(user: $user)';

  bool get isSuccess=> user!=null&&status==200;
  
  @override
  int get statusNumber => this.status!;
}
