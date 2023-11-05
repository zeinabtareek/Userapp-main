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

  Future<Map<String, dynamic>> toMap() async {
    Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data['address'] = address;
    data['img'] = await MultipartFile.fromFile(img!.path);
    return data;
  }

  @override
  String toString() {
    return toMap().toString();
  }

  Future<FormData> toForm() async {
    return FormData.fromMap(await toMap());
  }
}
