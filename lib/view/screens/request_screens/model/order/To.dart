class To {
  To({
      this.lat, 
      this.lng, 
      this.location,});

  To.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
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