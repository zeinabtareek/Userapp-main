
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';

import 'controller/payment_controller.dart';

class CreditCardScreen extends StatelessWidget {
    CreditCardScreen({Key? key}) : super(key: key);
final controller =Get.put(PaymentController(paymentRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    return CreditCard(
      config: controller.paymentConfig,
      onPaymentResult: controller.onPaymentResult,
    );
  }
}
