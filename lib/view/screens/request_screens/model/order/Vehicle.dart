import '../../../../../bases/base_id_value_model.dart';

class Vehicle {
  Vehicle({
      this.id, 
      this.type, 
      this.brand, 
      this.model, 
      this.factoryYear, 
      this.color, 
      this.licenseImage, 
      this.img,});

  Vehicle.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    brand = json['brand'];
    model = json['model'];
    // factoryYear = json['factory_year'];
    // color = json['color'];

    BaseIdNameModelString.fromMap(json['factory_year']);
    BaseIdNameModelString.fromMap(json['color']);
    licenseImage = json['license_image'];
    img = json['img'];
  }
  int ?id;
  String ?type;
  String ?brand;
  String ?model;
  BaseIdNameModelString? factoryYear, color;

  String ?licenseImage;
  String ?img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['brand'] = brand;
    map['model'] = model;
    map['factory_year'] =  factoryYear?.toMap();
    map['color'] =  color?.toMap();

    map['license_image'] = licenseImage;
    map['img'] = img;
    return map;
  }

}