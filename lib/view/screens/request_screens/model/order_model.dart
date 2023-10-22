

import '../../../../bases/base_id_value_model.dart';
import '../../where_to_go/model/order_create.dart';

class OrderModel {
  int? status;
  String? message;
  OrderData? data;

  OrderModel({this.status, this.message, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new OrderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OrderData {


    String? id;
    String? orderNum;
      From? from;
  To? to;
      String? status;
   List<StatusTimes>? statusTimes;
      num? distance;
  num? time;
      String? paymentType;
  dynamic transactionId;
      String? note;
  dynamic extraRoutes;
        List<GoogleRoute>? googleRoute;
  bool? isParcel;
      dynamic parcelDetails;
  Package? package;
      VehicleType? vehicleType;
  dynamic promoCode;
      User? user;
  num? kmPrice;
      num? priceBeforeDiscount;
  bool? promoCodeUsed;
      num? discountPercent;
  num? finalPrice;
      num? discountAmount;
  num? tip;
      num? driverAmount;
  String? createdAt;
   Driver? driver;
  OrderData(
      {this.id,
        this.orderNum,
        this.from,
        this.to,
        this.status,
        this.statusTimes,
        this.distance,
        this.time,
        this.paymentType,
        this.transactionId,
        this.note,
        this.extraRoutes,
        this.googleRoute,
        this.isParcel,
        this.parcelDetails,
        this.package,
        this.vehicleType,
        this.promoCode,
        this.driver,
        this.kmPrice,
        this.priceBeforeDiscount,
        this.promoCodeUsed,
        this.discountPercent,
        this.finalPrice,
        this.discountAmount,
        this.tip,
        this.driverAmount,
        this.createdAt});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNum = json['order_num'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new To.fromJson(json['to']) : null;
    status = json['status'];
    if (json['status_times'] != null) {
      statusTimes = <StatusTimes>[];
      json['status_times'].forEach((v) {
        statusTimes!.add(new StatusTimes.fromJson(v));
      });
    }
    distance = json['distance'];
    time = json['time'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id']??'';
    note = json['note'];
    if (json['extra_routes'] != null) {
      extraRoutes = <ExtraRoutes>[];
      json['extra_routes'].forEach((v) {
        extraRoutes!.add(new ExtraRoutes.fromJson(v));
      });
    }
    if (json['google_route'] != null) {
      googleRoute = <GoogleRoute>[];
      json['google_route'].forEach((v) {
        googleRoute!.add(new GoogleRoute.fromJson(v));
      });
    }
    isParcel = json['is_parcel'];
    parcelDetails = json['parcel_details']??'';
    package =
    json['package'] != null ? new Package.fromJson(json['package']) : null;
    vehicleType = json['vehicle_type'] != null
        ? new VehicleType.fromJson(json['vehicle_type'])
        : null;
    promoCode = json['promo_code'];
    // driver = json['driver'];
    if (this.driver != null) {
      json['driver'] = this.driver!.toJson();
    }
    kmPrice = json['km_price'];
    priceBeforeDiscount = json['price_before_discount'];
    promoCodeUsed = json['promo_code_used'];
    discountPercent = json['discount_percent'];
    finalPrice = json['final_price'];
    discountAmount = json['discount_amount'];
    tip = json['tip'];
    driverAmount = json['driver_amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_num'] = this.orderNum;
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    data['status'] = this.status;
    if (this.statusTimes != null) {
      data['status_times'] = this.statusTimes!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    data['time'] = this.time;
    data['payment_type'] = this.paymentType;
    data['transaction_id'] = this.transactionId;
    data['note'] = this.note;
    if (this.extraRoutes != null) {
      data['extra_routes'] = this.extraRoutes!.map((v) => v.toJson()).toList();
    }
    if (this.googleRoute != null) {
      data['google_route'] = this.googleRoute!.map((v) => v.toJson()).toList();
    }
    data['is_parcel'] = this.isParcel;
    data['parcel_details'] = this.parcelDetails;
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    if (this.vehicleType != null) {
      data['vehicle_type'] = this.vehicleType!.toJson();
    }
    data['promo_code'] = this.promoCode;
    data['driver'] = this.driver;
    data['km_price'] = this.kmPrice;
    data['price_before_discount'] = this.priceBeforeDiscount;
    data['promo_code_used'] = this.promoCodeUsed;
    data['discount_percent'] = this.discountPercent;
    data['final_price'] = this.finalPrice;
    data['discount_amount'] = this.discountAmount;
    data['tip'] = this.tip;
    data['driver_amount'] = this.driverAmount;
    data['created_at'] = this.createdAt;
    return data;
  }
}

// class Driver {
//   String? id;
//   String? phoneCode;
//   String? phone;
//   String? email;
//   String? img;
//   String? firstName;
//   String? lastName;
//   Vehicle? vehicle;
//
//   Driver(
//       {this.id,
//         this.phoneCode,
//         this.phone,
//         this.email,
//         this.img,
//         this.firstName,
//         this.lastName,
//         this.vehicle});
//
//   Driver.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     phoneCode = json['phone_code'];
//     phone = json['phone'];
//     email = json['email'];
//     img = json['img'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     vehicle =
//     json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['phone_code'] = this.phoneCode;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['img'] = this.img;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     if (this.vehicle != null) {
//       data['vehicle'] = this.vehicle!.toJson();
//     }
//     return data;
//   }
// }


class Driver {
  String? id;
  String? phoneCode;
  String? phone;
  String? email;
  String? img;
  String? firstName;
  String? lastName;
  Vehicle? vehicle;

  Driver(
      {this.id,
        this.phoneCode,
        this.phone,
        this.email,
        this.img,
        this.firstName,
        this.lastName,
        this.vehicle});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneCode = json['phone_code'];
    phone = json['phone'];
    email = json['email'];
    img = json['img'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    vehicle =
    json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone_code'] = this.phoneCode;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['img'] = this.img;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.toJson();
    }
    return data;
  }
}
class Vehicle {
  int? id;
  String? type;
  String? brand;
  String? model;
  FactoryYear? factoryYear;
  FactoryYear? color;
  String? licenseImage;
  String? img;

  Vehicle(
      {this.id,
        this.type,
        this.brand,
        this.model,
        this.factoryYear,
        this.color,
        this.licenseImage,
        this.img});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    brand = json['brand'];
    model = json['model'];
    factoryYear = json['factory_year'] != null
        ? new FactoryYear.fromJson(json['factory_year'])
        : null;
    color =
    json['color'] != null ? new FactoryYear.fromJson(json['color']) : null;
    licenseImage = json['license_image'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['brand'] = this.brand;
    data['model'] = this.model;
    if (this.factoryYear != null) {
      data['factory_year'] = this.factoryYear!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    data['license_image'] = this.licenseImage;
    data['img'] = this.img;
    return data;
  }
}

class FactoryYear {
  int? id;
  String? uuid;
  Name? name;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  FactoryYear(
      {this.id,
        this.uuid,
        this.name,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  FactoryYear.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



class Name {
  String? ar;
  String? en;
  String? ur;

  Name({this.ar, this.en, this.ur});

  Name.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
    ur = json['ur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    data['en'] = this.en;
    data['ur'] = this.ur;
    return data;
  }
}
/// lat : "21.23443"
/// lng : "23.32323"
/// location : "Nasr City"

// class To {
//   To({
//     String? lat,
//     String? lng,
//     String? location,}){
//     _lat = lat;
//     _lng = lng;
//     _location = location;
//   }
//
//   To.fromJson(dynamic json) {
//     _lat = json['lat'];
//     _lng = json['lng'];
//     _location = json['location'];
//   }
//   String? _lat;
//   String? _lng;
//   String? _location;
//   To copyWith({  String? lat,
//     String? lng,
//     String? location,
//   }) => To(  lat: lat ?? _lat,
//     lng: lng ?? _lng,
//     location: location ?? _location,
//   );
//   String? get lat => _lat;
//   String? get lng => _lng;
//   String? get location => _location;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['lat'] = _lat;
//     map['lng'] = _lng;
//     map['location'] = _location;
//     return map;
//   }
//
// }

/// lat : "21.23443"
/// lng : "23.32323"
/// location : "Nasr City"

// class From {
//   From({
//     String? lat,
//     String? lng,
//     String? location,}){
//     _lat = lat;
//     _lng = lng;
//     _location = location;
//   }
//
//   From.fromJson(dynamic json) {
//     _lat = json['lat'];
//     _lng = json['lng'];
//     _location = json['location'];
//   }
//   String? _lat;
//   String? _lng;
//   String? _location;
//   From copyWith({  String? lat,
//     String? lng,
//     String? location,
//   }) => From(  lat: lat ?? _lat,
//     lng: lng ?? _lng,
//     location: location ?? _location,
//   );
//   String? get lat => _lat;
//   String? get lng => _lng;
//   String? get location => _location;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['lat'] = _lat;
//     map['lng'] = _lng;
//     map['location'] = _location;
//     return map;
//   }
//
// }

/// id : "79d32c41-5dd9-41b2-b0e0-65960753746c"
/// phone_code : "+966"
/// phone : "123456784"
/// email : "omar4@gmail.com"
/// img : "http://hoodbackend.develobug.com/storage/files/uploads/user/img/11_hood_1697030718_@2023.png"
/// first_name : "abeer"
/// last_name : "elghool"
/// username : "abeerab7c3"

class User {
  User({
    String? id,
    String? phoneCode,
    String? phone,
    String? email,
    String? img,
    String? firstName,
    String? lastName,
    String? username,}){
    _id = id;
    _phoneCode = phoneCode;
    _phone = phone;
    _email = email;
    _img = img;
    _firstName = firstName;
    _lastName = lastName;
    _username = username;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _phoneCode = json['phone_code'];
    _phone = json['phone'];
    _email = json['email'];
    _img = json['img'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _username = json['username'];
  }
  String? _id;
  String? _phoneCode;
  String? _phone;
  String? _email;
  String? _img;
  String? _firstName;
  String? _lastName;
  String? _username;
  User copyWith({  String? id,
    String? phoneCode,
    String? phone,
    String? email,
    String? img,
    String? firstName,
    String? lastName,
    String? username,
  }) => User(  id: id ?? _id,
    phoneCode: phoneCode ?? _phoneCode,
    phone: phone ?? _phone,
    email: email ?? _email,
    img: img ?? _img,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    username: username ?? _username,
  );
  String? get id => _id;
  String? get phoneCode => _phoneCode;
  String? get phone => _phone;
  String? get email => _email;
  String? get img => _img;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['phone_code'] = _phoneCode;
    map['phone'] = _phone;
    map['email'] = _email;
    map['img'] = _img;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['username'] = _username;
    return map;
  }

}
class StatusTimes {
  String? status;
  String? time;

  StatusTimes({this.status, this.time});

  StatusTimes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['time'] = this.time;
    return data;
  }
}

class GoogleRoute {
  String? lat;
  String? lng;

  GoogleRoute({this.lat, this.lng});

  GoogleRoute.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Package {
  String? id;
  String? name;
  String? img;
  int? kmPrice;
  bool? isParcel;
  bool? hasChild;

  Package(
      {this.id,
        this.name,
        this.img,
        this.kmPrice,
        this.isParcel,
        this.hasChild});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    kmPrice = json['km_price'];
    isParcel = json['is_parcel'];
    hasChild = json['has_child'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['km_price'] = this.kmPrice;
    data['is_parcel'] = this.isParcel;
    data['has_child'] = this.hasChild;
    return data;
  }
}

class VehicleType {
  String? id;
  String? name;
  String? img;
  int? kmPrice;

  VehicleType({this.id, this.name, this.img, this.kmPrice});

  VehicleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    kmPrice = json['km_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['km_price'] = this.kmPrice;
    return data;
  }
}
