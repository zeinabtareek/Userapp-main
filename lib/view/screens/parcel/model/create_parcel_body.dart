import '../../where_to_go/model/order_create.dart';

class CreateParcelBody {
  String? orderType;
  String? packageId;
  From? from;
  To? to;
   List<ExtraRoutes>? googleRoutes;
  String? time;
  num? distance;
  String? note;
  String? paymentType;
  String? senderNumber;
  String? senderName;
  String? receiverNumber;
  String? receiverName;
  String? parcelDimension;
  String? parcelWeight;
  String? whoPay;
  String? parcelCategoryId;

  CreateParcelBody({
    this.orderType,
    this.packageId,
    this.from,
    this.to,
     this.googleRoutes,
    this.time,
    this.distance,
    this.note,
    this.senderName,
    this.senderNumber,
    this.receiverName,
    this.receiverNumber,
    this.parcelCategoryId,
    this.parcelDimension,
    this.parcelWeight,
    this.whoPay,
    this.paymentType,
  });

  factory CreateParcelBody.fromJson(Map<String, dynamic> json) {
    return CreateParcelBody(
      orderType: json['order_type'],
      packageId: json['package_id'],
      from: json['from'] != null ? From.fromJson(json['from']) : null,
      to: json['to'] != null ? To.fromJson(json['to']) : null,

      googleRoutes: json['google_route'] != null
          ? List<ExtraRoutes>.from(
          json['google_route'].map((x) => ExtraRoutes.fromJson(x)))
          : null,
      time: json['time'],
      distance: json['distance'],
      note: json['note'],
      paymentType: json['payment_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['order_type'] = orderType;
    data['package_id'] = packageId;
    // data['from'] = from?.toJson();
    // data['to'] = to?.toJson();
    data.addAll(from?.toJson() ?? {});
    data.addAll(to?.toJson() ?? {});
    if (googleRoutes != null && (googleRoutes?.isNotEmpty ?? false)) {
      for (var element in googleRoutes!) {
        data.addAll(element.toGoogleRouteJson(googleRoutes!.indexOf(element)));
      }
    }

    data['time'] = time;
    data['distance'] = distance;
    data['note'] = note;
    data['payment_type'] = paymentType;
    data['sender_number'] = senderNumber;
    data['sender_name'] = senderName;
    data['receiver_number'] = receiverNumber;
    data['receiver_name'] = receiverName;
    data['parcel_dimension'] = parcelDimension;
    data['parcel_weight'] = parcelWeight;
    data['who_pay'] = whoPay;
    data['parcel_category_id'] = parcelCategoryId;

    return data;
  }
}