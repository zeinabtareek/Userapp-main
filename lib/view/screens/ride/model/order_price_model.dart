class OrderPriceModel {
  int? status;
  String? message;
  OrderPriceData? data;

  OrderPriceModel({this.status, this.message, this.data});

  OrderPriceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new OrderPriceData.fromJson(json['data']) : null;
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

class OrderPriceData {
  num? kmPrice;
  num? distance;
  num? priceBeforeDiscount;
  bool? promoCodeUsed;
  num? discountPercent;
  num? discountAmount;
  num? finalPrice;

  OrderPriceData({
    this.kmPrice,
    this.distance,
    this.priceBeforeDiscount,
    this.promoCodeUsed,
    this.discountPercent,
    this.discountAmount,
    this.finalPrice,
  });

  OrderPriceData.fromJson(Map<String, dynamic> json) {
    kmPrice = json['km_price'];
    distance = json['distance'];
    priceBeforeDiscount = json['price_before_discount'];
    promoCodeUsed = json['promo_code_used'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'];
    finalPrice = json['final_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['km_price'] = this.kmPrice;
    data['distance'] = this.distance;
    data['price_before_discount'] = this.priceBeforeDiscount;
    data['promo_code_used'] = this.promoCodeUsed;
    data['discount_percent'] = this.discountPercent;
    data['discount_amount'] = this.discountAmount;
    data['final_price'] = this.finalPrice;
    return data;
  }
}
