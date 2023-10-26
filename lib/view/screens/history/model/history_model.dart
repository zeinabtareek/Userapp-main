import '../../../../bases/base_id_value_model.dart';
import '../../chat/models/res/msg_chat_res_model_item.dart';

class HistoryModel {
  int? status;
  String? message;
  List<HistoryData>? data;

  HistoryModel({this.status, this.message, this.data});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HistoryData>[];
      json['data'].forEach((v) {
        data!.add(new HistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryData {
  String? id;
  String? status;
  int? distance;
  int? time;
  String? paymentType;
  From? from;
  From? to;
  bool? isParcel;
  Package? package;
  Driver? driver;
  String? createdAt;

  HistoryData(
      {this.id,
        this.status,
        this.distance,
        this.time,
        this.paymentType,
        this.from,
        this.to,
        this.isParcel,
        this.package,
        this.driver,
        this.createdAt});

  HistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    distance = json['distance'];
    time = json['time'];
    paymentType = json['payment_type'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
    isParcel = json['is_parcel'];
    package =
    json['package'] != null ? new Package.fromJson(json['package']) : null;
    driver =
    json['driver'] != null ? new Driver.fromMap(json['driver']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['distance'] = this.distance;
    data['time'] = this.time;
    data['payment_type'] = this.paymentType;
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    data['is_parcel'] = this.isParcel;
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class From {
  String? lat;
  String? lng;
  String? location;

  From({this.lat, this.lng, this.location});

  From.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location'] = this.location;
    return data;
  }
}
class To {
  String? lat;
  String? lng;
  String? location;

  To({this.lat, this.lng, this.location});

  To.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location'] = this.location;
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

// class Driver {
//   String? id;
//   String? phoneCode;
//   String? phone;
//   String? email;
//   String? img;
//   String? firstName;
//   String? lastName;
//   dynamic  rate;
//   Vehicle? vehicle;

//   Driver(
//       {this.id,
//         this.phoneCode,
//         this.phone,
//         this.email,
//         this.img,
//         this.firstName,
//         this.rate,
//         this.lastName,
//         this.vehicle});

//   Driver.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     phoneCode = json['phone_code'];
//     phone = json['phone'];
//     email = json['email'];
//     rate = json['rate'];
//     img = json['img'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     vehicle =
//     json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['phone_code'] = this.phoneCode;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['img'] = this.img;
//     data['rate'] = this.rate;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     if (this.vehicle != null) {
//       data['vehicle'] = this.vehicle!.toJson();
//     }
//     return data;
//   }
// }

// class Vehicle {
//   int? id;
//   String? type;
//   String? brand;
//   String? model;
//   String? factoryYear;
//   String? color;
//   String? licenseImage;
//   String? img;
//
//   Vehicle(
//       {this.id,
//         this.type,
//         this.brand,
//         this.model,
//         this.factoryYear,
//         this.color,
//         this.licenseImage,
//         this.img});
//
//   Vehicle.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     brand = json['brand'];
//     model = json['model'];
//     factoryYear = json['factory_year'];
//     color = json['color'];
//     licenseImage = json['license_image'];
//     img = json['img'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['type'] = this.type;
//     data['brand'] = this.brand;
//     data['model'] = this.model;
//     data['factory_year'] = this.factoryYear;
//     data['color'] = this.color;
//     data['license_image'] = this.licenseImage;
//     data['img'] = this.img;
//     return data;
//   }
// }
class Vehicle {
  int? id;
  String? type;
  String? brand;
  String? model;
  BaseIdNameModelString? factoryYear;
  BaseIdNameModelString? color;
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
    factoryYear = BaseIdNameModelString.fromMap(json['factory_year']) ;
    color =  BaseIdNameModelString.fromMap(json['color']) ;
    licenseImage = json['license_image'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['factory_year'] = this.factoryYear;
    data['color'] = this.color;
    data['license_image'] = this.licenseImage;
    data['img'] = this.img;
    return data;
  }
}
