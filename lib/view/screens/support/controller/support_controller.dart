


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SupportController extends GetxController{



  final List<String> complainsList = ['Good Driver', 'Bad Driver', 'Good Driver', 'Good Driver'];
  late String initialSelectItem;
  final feedBackController=TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();




    initialSelectItem = complainsList.first;
  }

}