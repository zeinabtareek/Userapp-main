import 'dart:io';

import 'package:dio/dio.dart';

class CompleteDataReqModel {
  String? email;
  String? address;
  // String? identityNo;
  File? img;
  MultipartFile? uploadImg;
  CompleteDataReqModel({
    required this.email,
    required this.address,
    // required this.identityNo,
    required this.img,
  });

  Future<Map<String, dynamic>> toMap() async {
    Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    // data['email'] = 'abeerelghool@gmail.com';

    data['address'] = address;
    // TODO: remove identity_no key
    data["identity_no"] = "9662837498739409658";
    data['img'] = await MultipartFile.fromFile(img!.path);
    return data;
  }

  @override
  String toString() {
    return toMap().toString();
  }

 Future< FormData> toForm() async{
      return FormData.fromMap(await toMap());
  }
}
