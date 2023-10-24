class VehicleType {
  VehicleType({
      this.id, 
      this.name, 
      this.img, 
      this.kmPrice,});

  VehicleType.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    kmPrice = json['km_price'];
  }
  String ?id;
  String ?name;
  String ?img;
  int ?kmPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['img'] = img;
    map['km_price'] = kmPrice;
    return map;
  }

}