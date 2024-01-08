// import '../../history/model/history_model.dart';
import 'order_create.dart';

class CreateOrderBody {
  String? orderType;
  String? packageId;
  From? from;
  To? to;
  List<ExtraRoutes>? extraRoutes;
  List<ExtraRoutes>? googleRoutes;
  String? time;
  num? distance;
  String? note;
  String? vehicleTypeId;
  String? paymentType;
  String? promoCode;

  CreateOrderBody({
    this.orderType,
    this.packageId,
    this.from,
    this.to,
    this.extraRoutes,
    this.time,
    this.distance,
    this.note,
    this.vehicleTypeId,
    this.paymentType,
    this.promoCode,
    this.googleRoutes,
  });

  factory CreateOrderBody.fromJson(Map<String, dynamic> json) {
    return CreateOrderBody(
      orderType: json['order_type'],
      packageId: json['package_id'],
      from: json['from'] != null ? From.fromJson(json['from']) : null,
      to: json['to'] != null ? To.fromJson(json['to']) : null,
      extraRoutes: json['extra_routes'] != null
          ? List<ExtraRoutes>.from(
              json['extra_routes'].map((x) => ExtraRoutes.fromJson(x)))
          : null,
      googleRoutes: json['google_route'] != null
          ? List<ExtraRoutes>.from(
              json['google_route'].map((x) => ExtraRoutes.fromJson(x)))
          : null,
      time: json['time'],
      distance: json['distance'],
      note: json['note'],
      promoCode: json['promo_code'],
      vehicleTypeId: json['vehicle_type_id'],
      paymentType: json['payment_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['order_type'] = orderType;
    data['package_id'] = packageId;
    if (promoCode != null && ((promoCode?.isNotEmpty) ?? false)) {
      data['promo_code'] = promoCode;
    }
    data.addAll(from?.toJson() ?? {});
    data.addAll(to?.toJson() ?? {});

    if (extraRoutes != null && (extraRoutes?.isNotEmpty ?? false)) {
      for (var element in extraRoutes!) {
        data.addAll(element.toExtraRoutesJson(extraRoutes!.indexOf(element)));
      }
    }

    if (googleRoutes != null && (googleRoutes?.isNotEmpty ?? false)) {
      for (var element in googleRoutes!) {
        data.addAll(element.toGoogleRouteJson(googleRoutes!.indexOf(element)));
      }
    }

    data['time'] = time;
    data['distance'] = distance;
    data['note'] = note;
    data['vehicle_type_id'] = vehicleTypeId;
    data['payment_type'] = paymentType;
    return data;
  }
}
