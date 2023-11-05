import 'Data.dart' as d;

class OrderModel {
  OrderModel({
      this.status, 
      this.message, 
      this.data,});

  OrderModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?d. OrderData.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
 d. OrderData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}