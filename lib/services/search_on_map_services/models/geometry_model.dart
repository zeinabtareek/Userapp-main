
import 'location_model.dart';

class Geometry{
  final LocationModel ? location;
   Geometry({this.location});
  factory Geometry.fromJson(Map<dynamic ,dynamic> parsedJson){
    return Geometry(
        // location: parsedJson['location']
      location: LocationModel.fromJson(parsedJson['location'])
    );
  }
}