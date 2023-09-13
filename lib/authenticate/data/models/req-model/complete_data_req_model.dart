import 'dart:io';

import 'package:dio/dio.dart';

class CompleteDataReqModel {
  String? email;
  String? address;
  // String? identityNo;
  File? img;
  CompleteDataReqModel({
    required this.email,
    required this.address,
    // required this.identityNo,
    required this.img,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    MultipartFile.fromFile(img!.path).then((value) => data['img'] = value);
    data["email"] = email;
    data['address'] = address;
    // data["identity_no"] = identityNo;
    // data['img'] = await );
    return data;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
