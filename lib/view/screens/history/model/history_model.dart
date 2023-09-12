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
  // List<ExtraRoutes>? extraRoutes;
  List<String>? googleRoute;
  bool? isParcel;
  dynamic parcelDetails;
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
}class ExtraRoutes {
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
