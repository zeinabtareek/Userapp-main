
abstract class BaseIdValueModel<T> {
  String? get id;
  T? get value;

  fromMap(Map<String, dynamic> map);
}

class BaseIdNameModelString implements BaseIdValueModel<String> {
  String? _id;
  String? _value;

  BaseIdNameModelString(
    this._id,
    this._value,
  );

  factory BaseIdNameModelString.fromMap(Map<String, dynamic> map) {
    return BaseIdNameModelString(
      map['id'].toString(),
      map['name'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": value,
    };
  }

  @override
  String? get id => _id;

  @override
  String? get value => _value;

  @override
  fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }
}
