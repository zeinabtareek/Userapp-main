import '../../../../../bases/base_id_value_model.dart';
import 'From.dart';
import 'To.dart';
import 'StatusTimes.dart';
import 'GoogleRoute.dart';
import 'Package.dart';
import 'VehicleType.dart';
import 'Driver.dart';

class OrderData {
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
      this.createdAt,});

  OrderData.fromJson(dynamic json) {
    id = json['id'];
    orderNum = json['order_num'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? To.fromJson(json['to']) : null;
    status = json['status'];
    if (json['status_times'] != null) {
      statusTimes = [];
      json['status_times'].forEach((v) {
        statusTimes?.add(StatusTimes.fromJson(v));
      });
    }
    distance = json['distance'];
    time = json['time'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    note = json['note'];
    extraRoutes = json['extra_routes'];
    if (json['google_route'] != null) {
      googleRoute = [];
      json['google_route'].forEach((v) {
        googleRoute?.add(GoogleRoute.fromJson(v));
      });
    }
    isParcel = json['is_parcel'];
    parcelDetails = json['parcel_details'];
    package = json['package'] != null ? Package.fromJson(json['package']) : null;
    vehicleType = json['vehicle_type'] != null ? VehicleType.fromJson(json['vehicle_type']) : null;
    promoCode = json['promo_code'];
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    kmPrice = json['km_price'];
    priceBeforeDiscount = json['price_before_discount'];
    promoCodeUsed = json['promo_code_used'];
    discountPercent = json['discount_percent'];
    // BaseIdNameModelString.fromMap(json['factory_year']);
    // BaseIdNameModelString.fromMap(json['color']);
    finalPrice = json['final_price'];
    discountAmount = json['discount_amount'];
    tip = json['tip'];
    driverAmount = json['driver_amount'];
    createdAt = json['created_at'];
  }
  String ?id;
  String ?orderNum;
  From ?from;
  To ?to;
  String? status;
  List<StatusTimes> ?statusTimes;
  num? distance;
  num? time;
  String ?paymentType;
  dynamic transactionId;
  String ?note;
  dynamic extraRoutes;
  List<GoogleRoute>? googleRoute;
  bool ?isParcel;
  dynamic parcelDetails;
  Package ?package;
  VehicleType? vehicleType;
  dynamic promoCode;
  Driver? driver;
  int ?kmPrice;
  int ?priceBeforeDiscount;
  bool ?promoCodeUsed;
  int ?discountPercent;
  int ?finalPrice;
  int ?discountAmount;
  int ?tip;
  int ?driverAmount;
  String ?createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_num'] = orderNum;
    if (from != null) {
      map['from'] = from?.toJson();
    }
    if (to != null) {
      map['to'] = to?.toJson();
    }
    map['status'] = status;
    if (statusTimes != null) {
      map['status_times'] = statusTimes?.map((v) => v.toJson()).toList();
    }
    map['distance'] = distance;
    map['time'] = time;
    map['payment_type'] = paymentType;
    map['transaction_id'] = transactionId;
    map['note'] = note;
    map['extra_routes'] = extraRoutes;
    if (googleRoute != null) {
      map['google_route'] = googleRoute?.map((v) => v.toJson()).toList();
    }
    map['is_parcel'] = isParcel;
    map['parcel_details'] = parcelDetails;
    if (package != null) {
      map['package'] = package?.toJson();
    }
    if (vehicleType != null) {
      map['vehicle_type'] = vehicleType?.toJson();
    }
    map['promo_code'] = promoCode;
    if (driver != null) {
      map['driver'] = driver?.toJson();
    }
    map['km_price'] = kmPrice;
    map['price_before_discount'] = priceBeforeDiscount;
    map['promo_code_used'] = promoCodeUsed;
    map['discount_percent'] = discountPercent;
    map['final_price'] = finalPrice;
    map['discount_amount'] = discountAmount;
    map['tip'] = tip;
    map['driver_amount'] = driverAmount;
    map['created_at'] = createdAt;
    return map;
  }

}