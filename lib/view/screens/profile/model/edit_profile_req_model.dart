import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class EditProfileReqModel {
  String fName;
  String lName;
  String? email;
  String? address;
  File? img;
  EditProfileReqModel({
    required this.fName,
    required this.lName,
    this.email,
    this.address,
    this.img,
  });

  Future<Map<String, dynamic>> toMap() async {
    Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = fName;
    data['last_name'] = lName;
    data["email"] = email;
    data['address'] = address;
    data['img'] = await MultipartFile.fromFile(img!.path);
    return data;
  }

  Future< FormData> toForm() async => FormData.fromMap(await toMap());
}
