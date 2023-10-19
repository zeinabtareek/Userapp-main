// Country
import 'dart:convert';

class Country {
  String? id;
  String? name;
  String? phoneCode;
  String? code;
  String? img;
  String? currencyName;
  String? currencySymbol;
  DateTime? createdAt;
  Country({
    this.id,
    this.name,
    this.phoneCode,
    this.code,
    this.img,
    this.currencyName,
    this.currencySymbol,
    this.createdAt,
  });

  factory Country.fromMap(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        phoneCode: json["phone_code"],
        code: json["code"],
        img: json["img"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone_code": phoneCode,
        "code": code,
        "img": img,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
        "created_at": createdAt?.toIso8601String(),
      };

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String jsn) => Country.fromMap(json.decode(jsn));
}
