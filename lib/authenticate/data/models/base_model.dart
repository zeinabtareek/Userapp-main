import 'dart:convert';

abstract class BaseResModel<T> {
  String? msg;
  int? status;
  BaseResModel({
    this.msg,
    this.status,
  });
  T? get data;

  fromMap(Map<String, dynamic> map) {
    status = map["status"];

    msg = map["message"];
    print(" status $status  msg $msg");
  }
}

class MsgModel extends BaseResModel<MsgModel> {
  @override
  String? msgg;

  @override
  int? status;
  MsgModel({
    this.msgg,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'msg': msgg,
      'status': status,
    };
  }

  MsgModel.fromKMap(Map<String, dynamic> map) {
    msgg = map['msg'];
    status = map['status']?.toInt();
  }

  String toJson() => json.encode(toMap());

  factory MsgModel.fromJson(Map<String, dynamic> map) => MsgModel.fromKMap(map);

bool get isSuccess=> status==200;
  @override
  // TODO: implement data
  MsgModel? get data => throw UnimplementedError();
}
