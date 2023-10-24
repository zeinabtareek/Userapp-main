class Package {
  Package({
      this.id, 
      this.name, 
      this.img, 
      this.kmPrice, 
      this.isParcel, 
      this.hasChild,});

  Package.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    kmPrice = json['km_price'];
    isParcel = json['is_parcel'];
    hasChild = json['has_child'];
  }
  String ?id;
  String ?name;
  String ?img;
  int ?kmPrice;
  bool ?isParcel;
  bool ?hasChild;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['img'] = img;
    map['km_price'] = kmPrice;
    map['is_parcel'] = isParcel;
    map['has_child'] = hasChild;
    return map;
  }

}