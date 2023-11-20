import '../extensions/data_type_extensions.dart';

class VehicleType {
  String? id;
  String? name;
  String? img;
  num? kmPrice;
  bool? isParcel;
  bool? hasChild;
  String? createdAt;
  List<VehicleType>? types;
  bool? isActive;
  VehicleType({
    this.id,
    this.img,
    this.createdAt,
    this.hasChild,
    this.isParcel,
    this.kmPrice,
    this.name,
    this.types,
    this.isActive,
  });

  factory VehicleType.fromMap(Map<String, dynamic> map) {
    var apiTypes=map.containsKey('vehicle_types') &&
              map["vehicle_types"] is List &&
              (map['vehicle_types'] as List).isNotEmpty
          ? (map['vehicle_types'] as List)
              .map((e) => VehicleType.fromMap(e))
              .toList()
          : null;
    return VehicleType(
      isActive: map['is_active'],
      id: map['id'].toString(),
      name: map['name'],
      img: map["img"],
      createdAt: map['created_at'],
      kmPrice: map['km_price'] != null ? map['km_price'] as num : null,
      isParcel: boolFromApi(map['is_parcel']),
      hasChild:apiTypes!=null&& apiTypes.isNotEmpty ,
      types: apiTypes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "img": img,
      "created_at": createdAt,
      "km_price": kmPrice,
      "is_parcel": isParcel,
      "has_child": hasChild,
      'vehicle_types': types?.map((vehicle) => vehicle.toMap()).toList(),
    };
  }
}
