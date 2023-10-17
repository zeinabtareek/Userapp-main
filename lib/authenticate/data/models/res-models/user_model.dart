import 'dart:convert';

import 'country_model.dart';

class UserAuthModel {
  int? id;
  String? phoneCode;
  String? phone;
  String? email;
  String? img;
  String? firstName;
  String? lastName;
  String? username;
  String? address;
  String? identityNo;
  bool? isActive;
  bool? isBanned;
  bool? isDataCompleted;
  int? rating;
  dynamic lang;
  dynamic theme;
  Country? country;
  String? token;
  DateTime? createdAt;
  UserAuthModel({
    this.id,
    this.phoneCode,
    this.phone,
    this.email,
    this.img,
    this.firstName,
    this.lastName,
    this.username,
    this.address,
    this.identityNo,
    this.isActive,
    this.isBanned,
    this.isDataCompleted,
    this.rating,
    required this.lang,
    required this.theme,
    this.country,
    this.token,
    this.createdAt,
  });

  factory UserAuthModel.fromMap(Map<String, dynamic> json) {
    return UserAuthModel(
      id: json["id"],
      phoneCode: json["phone_code"],
      phone: json["phone"],
      email: json["email"],
      img: json["img"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      username: json["username"],
      address: json["address"],
      identityNo: json["identity_no"],
      isActive: json["is_active"],
      isBanned: json["is_banned"],
      isDataCompleted: json["is_data_completed"],
      rating: json["rating"],
      lang: json["lang"],
      theme: json["theme"],
      country:
          json["country"] == null ? null : Country.fromMap(json["country"]),
      token: json["token"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "phone_code": phoneCode,
        "phone": phone,
        "email": email,
        "img": img,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "address": address,
        "identity_no": identityNo,
        "is_active": isActive,
        "is_banned": isBanned,
        "is_data_completed": isDataCompleted,
        "rating": rating,
        "lang": lang,
        "theme": theme,
        "country": country?.toMap(),
        "token": token,
        "created_at": createdAt?.toIso8601String(),
      };

  String toJson() => json.encode(toMap());

  factory UserAuthModel.fromJson(String jsn) =>
      UserAuthModel.fromMap(json.decode(jsn));

  setEmil(String emil) => email = emil;

  setIdentityNo(String identityNo) => this.identityNo = identityNo;

  String get tkn => token!;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserAuthModel &&
        other.id == id &&
        other.phoneCode == phoneCode &&
        other.phone == phone &&
        other.email == email &&
        other.img == img &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username &&
        other.address == address &&
        other.identityNo == identityNo &&
        other.isActive == isActive &&
        other.isBanned == isBanned &&
        other.isDataCompleted == isDataCompleted &&
        other.rating == rating &&
        other.lang == lang &&
        other.theme == theme &&
        other.country == country &&
        other.token == token &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        phoneCode.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        img.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        address.hashCode ^
        identityNo.hashCode ^
        isActive.hashCode ^
        isBanned.hashCode ^
        isDataCompleted.hashCode ^
        rating.hashCode ^
        lang.hashCode ^
        theme.hashCode ^
        country.hashCode ^
        token.hashCode ^
        createdAt.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, phoneCode: $phoneCode, phone: $phone, email: $email, img: $img, firstName: $firstName, lastName: $lastName, username: $username, address: $address, identityNo: $identityNo, isActive: $isActive, isBanned: $isBanned, isDataCompleted: $isDataCompleted, rating: $rating, lang: $lang, theme: $theme, country: $country, token: $token, createdAt: $createdAt)';
  }
}
