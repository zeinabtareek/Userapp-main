import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../../bases/base_id_value_model.dart';
import '../../where_to_go/model/order_create.dart';

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
        data!.add(HistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryData {
  String? id;
  String? status;
  num? distance;
  num? finalPrice;
  String? orderNum;
  String? note;
  ParcelDetails? parcelDetails;
  int? time;
  String? paymentType;
  From? from;
  List<From>? googleRoute;
  From? to;
  bool? isParcel;
  Package? package;
  Driver? driver;
  String? createdAt;
  List<ExtraRoutes>? extraRoutes;
  bool isClipped = true;
  List<OrderStep>? steps;
  HistoryData({
    this.id,
    this.status,
    this.distance,
    this.time,
    this.paymentType,
    this.from,
    this.to,
    this.isParcel,
    this.finalPrice,
    this.package,
    this.driver,
    this.extraRoutes,
    this.orderNum,
    this.createdAt,
    this.steps,
    this.parcelDetails,
    this.note,
    this.googleRoute,
  });

  HistoryData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("google_route") && json['google_route'] != null) {
      // googleRoute = From.fromJson(json['google_route']);
      googleRoute = <From>[];
      json['google_route'].forEach((v) {
        googleRoute!.add(From.fromJson(v));
      });
    }

    if (json.containsKey("note") && json['note'] != null) {
      note = json['note'];
    }

    if (json.containsKey("parcel_details") && json['parcel_details'] != null) {
      parcelDetails = ParcelDetails.fromMap(json['parcel_details']);
    }
    if (json['status_times'] != null) {
      steps = <OrderStep>[];
      json['status_times'].forEach((v) {
        steps!.add(OrderStep.fromMap(v));
      });
    }
    orderNum = json['order_num'];
    id = json['id'].toString();
    status = json['status'];
    distance = json['distance'];
    time = json['time'];
    finalPrice = json['final_price'];
    paymentType = json['payment_type'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
    isParcel = json['is_parcel'];
    package =
        json['package'] != null ? Package.fromJson(json['package']) : null;
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    createdAt = json['created_at'];
    if (json.containsKey("extra_routes") && json['extra_routes'] != null) {
      extraRoutes = <ExtraRoutes>[];
      json['extra_routes'].forEach((v) {
        extraRoutes!.add(ExtraRoutes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['distance'] = distance;
    data['final_price'] = finalPrice;
    data['time'] = time;
    data['payment_type'] = paymentType;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.toJson();
    }
    data['is_parcel'] = isParcel;
    if (package != null) {
      data['package'] = package!.toJson();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }

  //
  //'pending', 'request_accepted', 'parcel_picked', 'arrived_drop_point', 'continued', 'cancel', 'spl_cancel', 'driver_cancel', 'delivered'
//
// request_accepted,parcel_picked,arrived_drop_point,delivered

  bool get isCanceled => ["cancel", 'spl_cancel', 'driver_cancel']
      .any((element) => element == status);
  // bool get isCompleted => status == "parcel_delivered";
  bool get isCompleted => ["parcel_delivered", 'delivered', "spl_delivered"]
      .any((element) => element == status);
  bool get isPending => status == "pending";
  String get packageName => parcelDetails?.parcelName ?? "";

  final Map<String, dynamic> _ex = {
    "id": "971a79fc-2559-470d-a312-508bccf30be8",
    "order_num": "971a7",
    "status": "cancel",
    "status_times": [
      {"status": "pending", "time": "2023-11-23 07:15:41"},
      {"status": "cancel", "time": "2023-11-23 08:01:29"}
    ],
    "distance": 10,
    "time": 10,
    "payment_type": "cash",
    "from": {"lat": "21.23443", "lng": "23.32323", "location": "Nasr City"},
    "to": {"lat": "21.23443", "lng": "23.32323", "location": "Nasr City"},
    "is_parcel": true,
    "final_price": 1200,
    "package": {
      "id": "9571cdde-45fc-4501-9538-82ac88c5b397",
      "name": "بضائع",
      "img":
          "https://arabchance.com/Hood-Backend-Dashboard/public/default/place_holder.jpg",
      "km_price": 120,
      "is_parcel": true,
      "has_child": false,
      "is_active": true
    },
    "driver": null,
    "created_at": "2023-11-23 07:15:41"
  };

  factory HistoryData.deff() {
    return HistoryData.fromJson({
      "id": "971a79fc-2559-470d-a312-508bccf30be8",
      "order_num": "971a7",
      "status": "cancel",
      "status_times": [
        {"status": "pending", "time": "2023-11-23 07:15:41"},
        {"status": "cancel", "time": "2023-11-23 08:01:29"}
      ],
      "distance": 10,
      "time": 10,
      "payment_type": "cash",
      "from": {"lat": "21.23443", "lng": "23.32323", "location": "Nasr City"},
      "to": {"lat": "21.23443", "lng": "23.32323", "location": "Nasr City"},
      "is_parcel": true,
      "final_price": 1200,
      "package": {
        "id": "9571cdde-45fc-4501-9538-82ac88c5b397",
        "name": "بضائع",
        "img":
            "https://arabchance.com/Hood-Backend-Dashboard/public/default/place_holder.jpg",
        "km_price": 120,
        "is_parcel": true,
        "has_child": false,
        "is_active": true
      },
      "driver": null,
      "created_at": "2023-11-23 07:15:41"
    });
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryData &&
        other.id == id &&
        other.status == status &&
        other.distance == distance &&
        other.finalPrice == finalPrice &&
        other.orderNum == orderNum &&
        other.note == note &&
        other.parcelDetails == parcelDetails &&
        other.time == time &&
        other.paymentType == paymentType &&
        other.from == from &&
        other.googleRoute == googleRoute &&
        other.to == to &&
        other.isParcel == isParcel &&
        other.package == package &&
        other.driver == driver &&
        other.createdAt == createdAt &&
        listEquals(other.extraRoutes, extraRoutes) &&
        other.isClipped == isClipped &&
        listEquals(other.steps, steps);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        distance.hashCode ^
        finalPrice.hashCode ^
        orderNum.hashCode ^
        note.hashCode ^
        parcelDetails.hashCode ^
        time.hashCode ^
        paymentType.hashCode ^
        from.hashCode ^
        googleRoute.hashCode ^
        to.hashCode ^
        isParcel.hashCode ^
        package.hashCode ^
        driver.hashCode ^
        createdAt.hashCode ^
        extraRoutes.hashCode ^
        isClipped.hashCode ^
        steps.hashCode;
  }

  HistoryData copyWith({
    String? id,
    String? status,
    num? distance,
    num? finalPrice,
    String? orderNum,
    String? note,
    ParcelDetails? parcelDetails,
    int? time,
    String? paymentType,
    From? from,
    List<From>? googleRoute,
    From? to,
    bool? isParcel,
    Package? package,
    Driver? driver,
    String? createdAt,
    List<ExtraRoutes>? extraRoutes,
    bool? isClipped,
    List<OrderStep>? steps,
  }) {
    return HistoryData(
      id: id ?? this.id,
      status: status ?? this.status,
      distance: distance ?? this.distance,
      finalPrice: finalPrice ?? this.finalPrice,
      orderNum: orderNum ?? this.orderNum,
      note: note ?? this.note,
      parcelDetails: parcelDetails ?? this.parcelDetails,
      time: time ?? this.time,
      paymentType: paymentType ?? this.paymentType,
      from: from ?? this.from,
      googleRoute: googleRoute ?? this.googleRoute,
      to: to ?? this.to,
      isParcel: isParcel ?? this.isParcel,
      package: package ?? this.package,
      driver: driver ?? this.driver,
      createdAt: createdAt ?? this.createdAt,
      extraRoutes: extraRoutes ?? this.extraRoutes,
      // isClipped: isClipped ?? this.isClipped,
      steps: steps ?? this.steps,
    );
  }
}

class OrderStep {
  final String name;
  final String date;

  OrderStep({required this.name, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
    };
  }

  factory OrderStep.fromMap(Map<String, dynamic> map) {
    return OrderStep(
      name: map['status'] ?? '',
      date: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStep.fromJson(String source) =>
      OrderStep.fromMap(json.decode(source));
}

class From {
  String? lat;
  String? lng;
  String? location;

  From({this.lat, this.lng, this.location});

  From.fromJson(Map<String, dynamic> json) {
    lat = json['lat'].toString();
    lng = json['lng'].toString();
    if (json.containsKey("location")) {
      location = json['location'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['location'] = location;
    return data;
  }

  From copyWith({
    String? lat,
    String? lng,
    String? location,
  }) {
    return From(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      location: location ?? this.location,
    );
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['location'] = location;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['km_price'] = kmPrice;
    data['is_parcel'] = isParcel;
    data['has_child'] = hasChild;
    return data;
  }
}

class ParcelDetails {
  /*
 "parcel_details": {
                "sender_number": "0109382738",
                "sender_name": "ahmed",
                "receiver_number": "0199383987",
                "receiver_name": "ali",
                "parcel_name": "books",
                "parcel_dimension": "12*12*9",
                "parcel_weight": "1.7 kg",
                "how_pay": null,
                "parcel_category": {
                    "id": "2e815b70-6c96-485c-91f0-2ee45f49205e",
                    "name": "صندوق",
                    "img": "http://arabchance.com/Hood-Backend-Dashboard/public/default/place_holder.jpg",
                    "created_at": "2023-10-17 10:04:19"
                }
            } 
   */

  String? senderNumber;
  String? senderName;
  String? receiverNumber;
  String? receiverName;
  String? parcelName;
  String? parcelDimension;
  String? parcelWeight;
  String? howPay;
  Package? parcelCategory;
  ParcelDetails({
    this.senderNumber,
    this.senderName,
    this.receiverNumber,
    this.receiverName,
    this.parcelName,
    this.parcelDimension,
    this.parcelWeight,
    this.howPay,
    this.parcelCategory,
  });

  factory ParcelDetails.fromMap(Map<String, dynamic> map) {
    return ParcelDetails(
      senderNumber: map['sender_number'],
      senderName: map['sender_name'],
      receiverNumber: map['receiver_number'],
      receiverName: map['receiver_name'],
      parcelName: map['parcel_name'],
      parcelDimension: map['parcel_dimension'],
      parcelWeight: map['parcel_weight'],
      howPay: map['how_pay'],
      parcelCategory: map['parcel_category'] != null
          ? Package.fromJson(map['parcel_category'])
          : null,
    );
  }

  factory ParcelDetails.fromJson(String source) =>
      ParcelDetails.fromMap(json.decode(source));
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
    factoryYear = BaseIdNameModelString.fromMap(json['factory_year']);
    color = BaseIdNameModelString.fromMap(json['color']);
    licenseImage = json['license_image'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['brand'] = brand;
    data['model'] = model;
    data['factory_year'] = factoryYear;
    data['color'] = color;
    data['license_image'] = licenseImage;
    data['img'] = img;
    return data;
  }
}
