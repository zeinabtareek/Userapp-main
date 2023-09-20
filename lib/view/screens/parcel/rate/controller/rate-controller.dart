import 'package:get/get.dart';

class RateController extends GetxController {
  final counter = 1.obs;

  List kilosList = [
    '1kg',
    '1kg',
    '1kg',
    '1kg',
    '1kg',
    '1kg',
  ];

  add() {
    counter.value++;
    print(counter.value);
    update();
   }

  minimize() {
       counter.value > 1 ? counter.value-- : counter.value = 1;
    }

}
