import 'dart:convert';

abstract class BaseResModel<T> {
  String? msg;
  int? status;


  
  BaseResModel({
    this.msg,
    this.status,
  });
  T? get data;
  int get statusNumber;

  fromMap(Map<String, dynamic> map) {
    status = map["status"];

    msg = map["message"];
  }
}

class MsgModel extends BaseResModel<MsgModel> {


  Map<String,dynamic>? stateData;
  MsgModel({

    this.stateData,
  });

 

  MsgModel.fromKMap(Map<String, dynamic> map) {
    msg = map['message'];
    status = map['status']?.toInt();
    stateData = map['data'];
  }

  // String toJson() => json.encode(toMap());

  factory MsgModel.fromJson(Map<String, dynamic> map) => MsgModel.fromKMap(map);

  bool get isSuccess => status == 200;
  @override
  MsgModel? get data => this;

  @override
  int get statusNumber => status!;

  @override
  String toString() {
    
    return "MSG( msg $msg  status $status)";
  }

  // MsgModel copyWith({
  //   String? massage,
  //   int? status,
  //   Map<String,dynamic>? stateData,
  // }) {
  //   return MsgModel(
  //     massage: massage ?? this.massage,
  //     status: status ?? this.status,
  //     stateData: stateData ?? this.stateData,
  //   );
  // }
}
