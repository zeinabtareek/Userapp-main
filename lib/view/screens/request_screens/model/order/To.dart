class To {
  To({
      this.lat, 
      this.lng, 
      this.location,});

  To.fromJson(dynamic json) {
    lat = json['lat'].toString();
    lng = json['lng'].toString();
    location = json['location'].toString();
  }
  String? lat;
  String ?lng;
  String ?location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    map['location'] = location;
    return map;
  }

}