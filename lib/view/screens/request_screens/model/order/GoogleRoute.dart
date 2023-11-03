class GoogleRoute {
  GoogleRoute({
      this.lat, 
      this.lng,});

  GoogleRoute.fromJson(dynamic json) {
    lat = json['lat'].toString();
    lng = json['lng'].toString();
  }
  String ?lat;
  String ?lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }

}