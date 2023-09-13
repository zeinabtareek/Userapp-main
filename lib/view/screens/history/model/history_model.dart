// class HistoryModel {
//   int? status;
//   String? message;
//   List<HistoryData>? data;
//
//   HistoryModel({this.status, this.message, this.data});
//
//   HistoryModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <HistoryData>[];
//       json['data'].forEach((v) {
//         data!.add(new HistoryData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class HistoryData {
//   int? id;
//   String? status;
//   int? distance;
//   int? time;
//   String? paymentType;
//   String? note;
//   int? farePrice;
//   int? userFarePrice;
//   int? acceptedFarePrice;
//   int? driverFare;
//   int? tip;
//   From? from;
//   From? to;
//   List<ExtraRoutes>? extraRoutes;
//   // List<ExtraRoutes>? extraRoutes;
//   List<String>? googleRoute;
//   bool? isParcel;
//   dynamic parcelDetails;
//   String? createdAt;
//
//   HistoryData(
//       {this.id,
//         this.status,
//         this.distance,
//         this.time,
//         this.paymentType,
//         this.note,
//         this.farePrice,
//         this.userFarePrice,
//         this.acceptedFarePrice,
//         this.driverFare,
//         this.tip,
//         this.from,
//         this.to,
//         this.extraRoutes,
//         this.googleRoute,
//         this.isParcel,
//         this.parcelDetails,
//         this.createdAt});
//
//   HistoryData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     status = json['status'];
//     distance = json['distance'];
//     time = json['time'];
//     paymentType = json['payment_type'];
//     note = json['note'];
//     farePrice = json['fare_price'];
//     userFarePrice = json['user_fare_price'];
//     acceptedFarePrice = json['accepted_fare_price'];
//     driverFare = json['driver_fare'];
//     tip = json['tip'];
//     from = json['from'] != null ? new From.fromJson(json['from']) : null;
//     to = json['to'] != null ? new From.fromJson(json['to']) : null;
//     if (json['extra_routes'] != null) {
//       extraRoutes = <ExtraRoutes>[];
//       json['extra_routes'].forEach((v) {
//         extraRoutes!.add(new ExtraRoutes.fromJson(v));
//       });
//     }
//     googleRoute = json['google_route'].cast<String>();
//     isParcel = json['is_parcel'];
//     parcelDetails = json['parcel_details'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['status'] = this.status;
//     data['distance'] = this.distance;
//     data['time'] = this.time;
//     data['payment_type'] = this.paymentType;
//     data['note'] = this.note;
//     data['fare_price'] = this.farePrice;
//     data['user_fare_price'] = this.userFarePrice;
//     data['accepted_fare_price'] = this.acceptedFarePrice;
//     data['driver_fare'] = this.driverFare;
//     data['tip'] = this.tip;
//     if (this.from != null) {
//       data['from'] = this.from!.toJson();
//     }
//     if (this.to != null) {
//       data['to'] = this.to!.toJson();
//     }
//     if (this.extraRoutes != null) {
//       data['extra_routes'] = this.extraRoutes!.map((v) => v.toJson()).toList();
//     }
//     data['google_route'] = this.googleRoute;
//     data['is_parcel'] = this.isParcel;
//     data['parcel_details'] = this.parcelDetails;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }
//
// class From {
//   double? lat;
//   double? lng;
//   String? location;
//
//   From({this.lat, this.lng, this.location});
//
//   From.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lng = json['lng'];
//     location = json['location'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     data['location'] = this.location;
//     return data;
//   }
// }
class ExtraRoutes {
  double? lat;
  double? lng;
  String? location;

  ExtraRoutes({this.lat, this.lng, this.location});

  ExtraRoutes.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? status;
  int? distance;
  int? time;
  String? paymentType;
  String? note;
  int? farePrice;
  int? userFarePrice;
  int? acceptedFarePrice;
  int? driverFare;
  int? tip;
  From? from;
  From? to;
  List<ExtraRoutes>? extraRoutes;
  List<String>? googleRoute;
  bool? isParcel;
  String? parcelDetails;
  Driver? driver;
  String? createdAt;

  HistoryData(
      {this.id,
        this.status,
        this.distance,
        this.time,
        this.paymentType,
        this.note,
        this.farePrice,
        this.userFarePrice,
        this.acceptedFarePrice,
        this.driverFare,
        this.tip,
        this.from,
        this.to,
        this.extraRoutes,
        this.googleRoute,
        this.isParcel,
        this.parcelDetails,
        this.driver,
        this.createdAt});

  HistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    distance = json['distance'];
    time = json['time'];
    paymentType = json['payment_type'];
    note = json['note'];
    farePrice = json['fare_price'];
    userFarePrice = json['user_fare_price'];
    acceptedFarePrice = json['accepted_fare_price'];
    driverFare = json['driver_fare'];
    tip = json['tip'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
    if (json['extra_routes'] != null) {
      extraRoutes = <ExtraRoutes>[];
      json['extra_routes'].forEach((v) {
        extraRoutes!.add(new ExtraRoutes.fromJson(v));
      });
    }
    googleRoute = json['google_route'].cast<String>();
    isParcel = json['is_parcel'];
    parcelDetails = json['parcel_details'];
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['distance'] = this.distance;
    data['time'] = this.time;
    data['payment_type'] = this.paymentType;
    data['note'] = this.note;
    data['fare_price'] = this.farePrice;
    data['user_fare_price'] = this.userFarePrice;
    data['accepted_fare_price'] = this.acceptedFarePrice;
    data['driver_fare'] = this.driverFare;
    data['tip'] = this.tip;
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    if (this.extraRoutes != null) {
      data['extra_routes'] = this.extraRoutes!.map((v) => v.toJson()).toList();
    }
    data['google_route'] = this.googleRoute;
    data['is_parcel'] = this.isParcel;
    data['parcel_details'] = this.parcelDetails;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class From {
  double? lat;
  double? lng;
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

class Driver {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? password;
  dynamic forgetPasswordCode;
  String? phoneCode;
  String? phone;
  int? phoneConfirmed;
  String? img;
  String? address;
  dynamic timezone;
  int? isActive;
  int? isBanned;
  int? isDataCompleted;
  dynamic emailConfirmationToken;
  dynamic phoneConfirmationToken;
  dynamic otp;
  dynamic identityNo;
  dynamic referralCode;
  dynamic  referredBy;
  dynamic lang;
  int? rate;
  dynamic loginBy;
  dynamic lastKnownIp;
  dynamic lastLoginAt;
  double? lat;
  double? lng;
  dynamic countryId;
  String? packageId;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;

  Driver(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.password,
        this.forgetPasswordCode,
        this.phoneCode,
        this.phone,
        this.phoneConfirmed,
        this.img,
        this.address,
        this.timezone,
        this.isActive,
        this.isBanned,
        this.isDataCompleted,
        this.emailConfirmationToken,
        this.phoneConfirmationToken,
        this.otp,
        this.identityNo,
        this.referralCode,
        this.referredBy,
        this.lang,
        this.rate,
        this.loginBy,
        this.lastKnownIp,
        this.lastLoginAt,
        this.lat,
        this.lng,
        this.countryId,
        this.packageId,
        this.rememberToken,
        this.createdAt,
        this.updatedAt});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    firstName = json['first_name']??"";
    lastName = json['last_name']??'';
    username = json['username']??'';
    email = json['email']??'';
    emailVerifiedAt = json['email_verified_at']??'';
    password = json['password'];
    forgetPasswordCode = json['forget_password_code'];
    phoneCode = json['phone_code'];
    phone = json['phone'];
    phoneConfirmed = json['phone_confirmed'];
    img = json['img'];
    address = json['address'];
    timezone = json['timezone'];
    isActive = json['is_active'];
    isBanned = json['is_banned'];
    isDataCompleted = json['is_data_completed'];
    emailConfirmationToken = json['email_confirmation_token'];
    phoneConfirmationToken = json['phone_confirmation_token'];
    otp = json['otp'];
    identityNo = json['identity_no'];
    referralCode = json['referral_code'];
    referredBy = json['referred_by'];
    lang = json['lang'];
    rate = json['rate'];
    loginBy = json['login_by'];
    lastKnownIp = json['last_known_ip'];
    lastLoginAt = json['last_login_at'];
    lat = json['lat'];
    lng = json['lng'];
    countryId = json['country_id'];
    packageId = json['package_id'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['forget_password_code'] = this.forgetPasswordCode;
    data['phone_code'] = this.phoneCode;
    data['phone'] = this.phone;
    data['phone_confirmed'] = this.phoneConfirmed;
    data['img'] = this.img;
    data['address'] = this.address;
    data['timezone'] = this.timezone;
    data['is_active'] = this.isActive;
    data['is_banned'] = this.isBanned;
    data['is_data_completed'] = this.isDataCompleted;
    data['email_confirmation_token'] = this.emailConfirmationToken;
    data['phone_confirmation_token'] = this.phoneConfirmationToken;
    data['otp'] = this.otp;
    data['identity_no'] = this.identityNo;
    data['referral_code'] = this.referralCode;
    data['referred_by'] = this.referredBy;
    data['lang'] = this.lang;
    data['rate'] = this.rate;
    data['login_by'] = this.loginBy;
    data['last_known_ip'] = this.lastKnownIp;
    data['last_login_at'] = this.lastLoginAt;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['country_id'] = this.countryId;
    data['package_id'] = this.packageId;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
