class LocationModel{
 final double ?lat;
 final double ?lng;


 LocationModel({this.lat,this.lng});
 factory LocationModel.fromJson(Map<dynamic,dynamic> parsedJson){
   return LocationModel(
     lat: parsedJson['lat'],
     lng: parsedJson['lng']
   );
 }
}