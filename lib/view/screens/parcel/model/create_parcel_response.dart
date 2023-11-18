//CreateParcelModel



import '../../../../bases/base_id_value_model.dart';
import '../../where_to_go/model/order_create.dart';

class CreateParcelModel {
  int? status;
  String? message;
  OrderData? data;

  CreateParcelModel({this.status, this.message, this.data});

  CreateParcelModel.fromJson(Map<String, dynamic> json) {
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





