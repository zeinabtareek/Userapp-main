

import 'geometry_model.dart';

class Suggestion {
   final String  placeId;
   String ? description;
   String ? main_text;

  Suggestion({required this.placeId, this.description, this.main_text});
  factory Suggestion.fromJson(Map<String,dynamic>json){
    return Suggestion(
      placeId:json['place_id'],
      description:json['description'],
      main_text:json['main_text'],

    );
  }


}

class PlaceDetail {
  final Geometry ?geometry;
  String? address;
  double? latitude;
  double? longitude;
  String? name;

  PlaceDetail({
    this.geometry,
    this.address,
    this.latitude,
    this.longitude,
    this.name,
  });

  factory PlaceDetail.fromJson(Map<String,dynamic>json){
    return PlaceDetail(
      geometry: Geometry.fromJson(json['geometry']),
      address:json['address'],
      latitude:json['latitude'],
      longitude:json['longitude'],
      name:json['name'],

    );
}
}

