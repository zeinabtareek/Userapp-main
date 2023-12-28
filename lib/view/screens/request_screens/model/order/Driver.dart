import '../../../where_to_go/model/order_create.dart';

class Driver {
  Driver({
      this.id, 
      this.phoneCode, 
      this.phone, 
      this.email, 
      this.img, 
      this.firstName, 
      this.lastName, 
      this.vehicle,});

  Driver.fromJson(dynamic json) {
    id = json['id'];
    phoneCode = json['phone_code'];
    phone = json['phone'];
    email = json['email'];
    img = json['img'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    vehicle = json['vehicle'] != null ?VehicleD.fromJson(json['vehicle']) : null;
  }
  String ?id;
  String ?phoneCode;
  String ?phone;
  String ?email;
  String ?img;
  String ?firstName;
  String ?lastName;
  VehicleD? vehicle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['phone_code'] = phoneCode;
    map['phone'] = phone;
    map['email'] = email;
    map['img'] = img;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    if (vehicle != null) {
      map['vehicle'] = vehicle?.toJson();
    }
    return map;
  }

}