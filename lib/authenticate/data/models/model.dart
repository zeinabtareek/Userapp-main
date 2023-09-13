abstract class Model<T> {
 T fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap();

  String toJson();
}
