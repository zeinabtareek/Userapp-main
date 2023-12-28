import '../../../../bases/base_id_value_model.dart';

class CreateOrderModel {
  int? status;
  String? message;
  OrderData? data;

  CreateOrderModel({this.status, this.message, this.data});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? OrderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
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
  From? to;
  String? status;
  List<StatusTimes>? statusTimes;
  dynamic distance;
  dynamic time;
  String? paymentType;
  dynamic transactionId;
  String? note;
  List<ExtraRoutes>? extraRoutes;
  List<GoogleRoute>? googleRoute;
  dynamic parcelDetails;
  VehicleType? vehicleType;
  bool? promoCode;
  dynamic kmPrice;
  late final dynamic priceBeforeDiscount;
  late final bool? promoCodeUsed;
  late final dynamic discountPercent;
  late final dynamic finalPrice;
  late final dynamic discountAmount;
  late final bool? isParcel;
  late final Package? package;
  late dynamic driver;
  // late final Driver? driver;
  // late final User ?user;
  late final String? createdAt;

  dynamic tip;
  dynamic driverAmount;
  OrderData({
    this.id,
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
    this.createdAt,
  });

  OrderData.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      orderNum = json['order_num'];
      from = json['from'] != null ? From.fromJson(json['from']) : null;
      to = json['to'] != null ? From.fromJson(json['to']) : null;
      status = json['status'];
      if (json['status_times'] != null) {
        statusTimes = <StatusTimes>[];
        json['status_times'].forEach((v) {
          statusTimes!.add(StatusTimes.fromJson(v));
        });
      }
      distance = json['distance'];
      time = json['time'];
      paymentType = json['payment_type'];
      transactionId = json['transaction_id'];
      note = json['note'];
      if (json['extra_routes'] != null) {
        extraRoutes = <ExtraRoutes>[];
        json['extra_routes'].forEach((v) {
          extraRoutes!.add(ExtraRoutes.fromJson(v));
        });
      }
      if (json['google_route'] != null) {
        googleRoute = <GoogleRoute>[];
        json['google_route'].forEach((v) {
          googleRoute!.add(GoogleRoute.fromJson(v));
        });
      }
      isParcel = json['is_parcel'];
      parcelDetails = json['parcel_details'];
      package =
          json['package'] != null ? Package.fromJson(json['package']) : null;
      vehicleType = json['vehicle_type'] != null
          ? VehicleType.fromJson(json['vehicle_type'])
          : null;
      promoCode = json['promo_code'];
      driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
      kmPrice = json['km_price'];
      priceBeforeDiscount = json['price_before_discount'];
      promoCodeUsed = json['promo_code_used'];
      discountPercent = json['discount_percent'];
      finalPrice = json['final_price'];
      discountAmount = json['discount_amount'];
      tip = json['tip'];
      driverAmount = json['driver_amount'];
      createdAt = json['created_at'];
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_num'] = orderNum;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.toJson();
    }
    data['status'] = status;
    if (statusTimes != null) {
      data['status_times'] = statusTimes!.map((v) => v.toJson()).toList();
    }
    data['distance'] = distance;
    data['time'] = time;
    data['payment_type'] = paymentType;
    data['transaction_id'] = transactionId;
    data['note'] = note;
    if (extraRoutes != null) {
      data['extra_routes'] = extraRoutes!.map((v) => v.toJson()).toList();
    }
    if (googleRoute != null) {
      data['google_route'] = googleRoute!.map((v) => v.toJson()).toList();
    }
    data['is_parcel'] = isParcel;
    data['parcel_details'] = parcelDetails;
    if (package != null) {
      data['package'] = package!.toJson();
    }
    if (vehicleType != null) {
      data['vehicle_type'] = vehicleType!.toJson();
    }
    data['promo_code'] = promoCode;
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    data['km_price'] = kmPrice;
    data['price_before_discount'] = priceBeforeDiscount;
    data['promo_code_used'] = promoCodeUsed;
    data['discount_percent'] = discountPercent;
    data['final_price'] = finalPrice;
    data['discount_amount'] = discountAmount;
    data['tip'] = tip;
    data['driver_amount'] = driverAmount;
    data['created_at'] = createdAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from[lat]'] = lat;
    data['from[lng]'] = lng;
    data['from[location]'] = location;
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['time'] = time;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['km_price'] = kmPrice;
    return data;
  }
}

// class OrderData {
//   OrderData({
//     this.id,
//     this.status,
//     this.distance,
//     this.time,
//     this.paymentType,
//     this.from,
//     this.to,
//     this.extraRoutes,
//     this.priceBeforeDiscount,
//     this.promoCodeUsed,
//     this.discountPercent,
//     this.finalPrice,
//     this.discountAmount,
//     this.isParcel,
//     this.package,
//     this.driver,
//     this  .user,
//     this.createdAt,
//   });
//   late final String? id;
//   late final String ?status;
//   late final num ?distance;
//   // late final int ?distance;
//   late final num ?time;
//   late final String ?paymentType;
//   late final From ?from;
//   late final To ?to;
//   late final List<ExtraRoutes> ?extraRoutes;
//   late final num ?priceBeforeDiscount;
//   late final bool? promoCodeUsed;
//   late final num ?discountPercent;
//   late final num? finalPrice;
//   late final num ?discountAmount;
//   late final bool ?isParcel;
//   late final Package? package;
//   late final Driver? driver;
//   late final User ?user;
//   late final String ?createdAt;
//
//   OrderData.fromJson(Map<dynamic, dynamic> json) {
//     id = json['id'];
//     status = json['status'];
//     distance = json['distance'];
//     time = json['time'];
//     paymentType = json['payment_type'];
//     from = json['from'] != null ? From.fromJson(json['from']) : null;
//     to = json['to'] != null ? To.fromJson(json['to']) : null;
//     extraRoutes = List.from(json['extra_routes'] ?? [])
//         .map((e) => ExtraRoutes.fromJson(e))
//         .toList();
//     priceBeforeDiscount = json['price_before_discount'];
//     promoCodeUsed = json['promo_code_used'];
//     discountPercent = json['discount_percent'];
//     finalPrice = json['final_price'];
//     discountAmount = json['discount_amount'];
//     isParcel = json['is_parcel'];
//     package = json['package'] != null ? Package.fromJson(json['package']) : null;
//     driver = null;
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     createdAt = json['created_at'];
//   }
//
//
// }
// /// id : "79d32c41-5dd9-41b2-b0e0-65960753746c"
// /// phone_code : "+966"
// /// phone : "123456784"
// /// email : "omar4@gmail.com"
// /// img : "http://hoodbackend.develobug.com/storage/files/uploads/user/img/11_hood_1697030718_@2023.png"
// /// first_name : "abeer"
// /// last_name : "elghool"
// /// username : "abeerab7c3"
//
// class User {
//   User({
//     String? id,
//     String? phoneCode,
//     String? phone,
//     String? email,
//     String? img,
//     String? firstName,
//     String? lastName,
//     String? username,}){
//     _id = id;
//     _phoneCode = phoneCode;
//     _phone = phone;
//     _email = email;
//     _img = img;
//     _firstName = firstName;
//     _lastName = lastName;
//     _username = username;
//   }
//
//   User.fromJson(dynamic json) {
//     _id = json['id'];
//     _phoneCode = json['phone_code'];
//     _phone = json['phone'];
//     _email = json['email'];
//     _img = json['img'];
//     _firstName = json['first_name'];
//     _lastName = json['last_name'];
//     _username = json['username'];
//   }
//   String? _id;
//   String? _phoneCode;
//   String? _phone;
//   String? _email;
//   String? _img;
//   String? _firstName;
//   String? _lastName;
//   String? _username;
//   User copyWith({  String? id,
//     String? phoneCode,
//     String? phone,
//     String? email,
//     String? img,
//     String? firstName,
//     String? lastName,
//     String? username,
//   }) => User(  id: id ?? _id,
//     phoneCode: phoneCode ?? _phoneCode,
//     phone: phone ?? _phone,
//     email: email ?? _email,
//     img: img ?? _img,
//     firstName: firstName ?? _firstName,
//     lastName: lastName ?? _lastName,
//     username: username ?? _username,
//   );
//   String? get id => _id;
//   String? get phoneCode => _phoneCode;
//   String? get phone => _phone;
//   String? get email => _email;
//   String? get img => _img;
//   String? get firstName => _firstName;
//   String? get lastName => _lastName;
//   String? get username => _username;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['phone_code'] = _phoneCode;
//     map['phone'] = _phone;
//     map['email'] = _email;
//     map['img'] = _img;
//     map['first_name'] = _firstName;
//     map['last_name'] = _lastName;
//     map['username'] = _username;
//     return map;
//   }
//
// }

///zeinab
class ExtraRoutes {
  ExtraRoutes({
    required this.lat,
    required this.lng,
    required this.location,
  });
  late final String lat;
  late final String lng;
  late final String location;

  ExtraRoutes.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['location'] = location;
    return data;
  }

  Map<String, dynamic> toGoogleRouteJson(int index) {
    final data = <String, dynamic>{};
    data['google_route[$index][lat]'] = lat;
    data['google_route[$index][lng]'] = lng;
    // data['google_route[$index][location]'] = location;
    return data;
  }

  Map<String, dynamic> toExtraRoutesJson(int index) {
    final data = <String, dynamic>{};
    data['extra_routes[$index][lat]'] = lat;
    data['extra_routes[$index][lng]'] = lng;
    data['extra_routes[$index][location]'] = location;
    return data;
  }
}

class To {
  To({
    this.lat,
    this.lng,
    this.location,
  });
  late final String? lat;
  late final String? lng;
  late final String? location;

  To.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['to[lat]'] = lat;
    data['to[lng]'] = lng;
    data['to[location]'] = location;
    return data;
  }
}

class Driver {
  Driver({
    required this.id,
    required this.phoneCode,
    required this.phone,
    required this.email,
    required this.img,
    required this.firstName,
    required this.lastName,
    this.isOnline,
    this.vehicle,
  });
  late final String id;
  late final String phoneCode;
  late final String phone;
  late final String email;
  late final String img;
  late final String firstName;
  late final String lastName;
  bool? isOnline;
  VehicleD? vehicle;

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneCode = json['phone_code'];
    phone = json['phone'];
    email = json['email'];
    img = json['img'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    isOnline = json['is_online'];
    vehicle =
        json['vehicle'] != null ? VehicleD.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['phone_code'] = phoneCode;
    data['phone'] = phone;
    data['email'] = email;
    data['img'] = img;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['is_online'] = isOnline;
    data['vehicle'] = vehicle?.toJson();
    return data;
  }
}

class VehicleD {
  VehicleD({
    required this.id,
    required this.type,
    required this.brand,
    required this.model,
    required this.factoryYear,
    required this.color,
    required this.licenseImage,
    required this.img,
  });
  late final int id;
  late final String type;
  late final String brand;
  late final String model;
  late final BaseIdNameModelString factoryYear;
  late final BaseIdNameModelString color;
  late final String licenseImage;
  late final String img;

  VehicleD.fromJson(Map<String, dynamic> json) {
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
    final data = <String, dynamic>{};
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
// /// lat : "21.23443"
// /// lng : "23.32323"
// /// location : "Nasr City"
//
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
//
//
//
// /// id : "85712ad3-bd9e-442b-932b-229ddbc4ce54"
// /// name : "سيارة"
// /// img : "http://hoodbackend.develobug.com/default/place_holder.jpg"
// /// km_price : 100
// /// is_parcel : false
// /// has_child : true
//
// class Package {
//   Package({
//     String? id,
//     String? name,
//     String? img,
//     num? kmPrice,
//     bool? isParcel,
//     bool? hasChild,}){
//     _id = id;
//     _name = name;
//     _img = img;
//     _kmPrice = kmPrice;
//     _isParcel = isParcel;
//     _hasChild = hasChild;
//   }
//
//   Package.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _img = json['img'];
//     _kmPrice = json['km_price'];
//     _isParcel = json['is_parcel'];
//     _hasChild = json['has_child'];
//   }
//   String? _id;
//   String? _name;
//   String? _img;
//   num? _kmPrice;
//   bool? _isParcel;
//   bool? _hasChild;
//   Package copyWith({  String? id,
//     String? name,
//     String? img,
//     num? kmPrice,
//     bool? isParcel,
//     bool? hasChild,
//   }) => Package(  id: id ?? _id,
//     name: name ?? _name,
//     img: img ?? _img,
//     kmPrice: kmPrice ?? _kmPrice,
//     isParcel: isParcel ?? _isParcel,
//     hasChild: hasChild ?? _hasChild,
//   );
//   String? get id => _id;
//   String? get name => _name;
//   String? get img => _img;
//   num? get kmPrice => _kmPrice;
//   bool? get isParcel => _isParcel;
//   bool? get hasChild => _hasChild;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['img'] = _img;
//     map['km_price'] = _kmPrice;
//     map['is_parcel'] = _isParcel;
//     map['has_child'] = _hasChild;
//     return map;
//   }
//
// }
//
// /// lat : "21.123"
// /// lng : "21.124"
//
// class GoogleRoute {
//   GoogleRoute({
//     String? lat,
//     String? lng,}){
//     _lat = lat;
//     _lng = lng;
//   }
//
//   GoogleRoute.fromJson(dynamic json) {
//     _lat = json['lat'];
//     _lng = json['lng'];
//   }
//   String? _lat;
//   String? _lng;
//   GoogleRoute copyWith({  String? lat,
//     String? lng,
//   }) => GoogleRoute(  lat: lat ?? _lat,
//     lng: lng ?? _lng,
//   );
//   String? get lat => _lat;
//   String? get lng => _lng;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['lat'] = _lat;
//     map['lng'] = _lng;
//     return map;
//   }
//
// }
//
// class StatusTimes {
//   StatusTimes({
//     String? status,
//     String? time,}){
//     _status = status;
//     _time = time;
//   }
//
//   StatusTimes.fromJson(dynamic json) {
//     _status = json['status'];
//     _time = json['time'];
//   }
//   String? _status;
//   String? _time;
//   StatusTimes copyWith({  String? status,
//     String? time,
//   }) => StatusTimes(  status: status ?? _status,
//     time: time ?? _time,
//   );
//   String? get status => _status;
//   String? get time => _time;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = _status;
//     map['time'] = _time;
//     return map;
//   }
//
// }
//
// /// lat : "21.23443"
// /// lng : "23.32323"
// /// location : "Nasr City"
//
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
