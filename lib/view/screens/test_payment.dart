
import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

class TestPaymentScreen extends StatelessWidget {
   TestPaymentScreen({Key? key}) : super(key: key);

  final paymentConfig = PaymentConfig(
    publishableApiKey: 'pk_test_gYHJb7Dzs3SUjghm2JFhLrFPdQRKzxb4V5W8FDib',
    amount: 25758, // SAR 257.58
    description: 'order #1324',
    metadata: {'size': '250g'},
    applePay: ApplePayConfig(merchantId: 'YOUR_MERCHANT_ID', label: 'YOUR_STORE_NAME', manual: false),
  );

  void onPaymentResult(result) {
    print('result $result');
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
        // handle success.
          break;
        case PaymentStatus.failed:
        // handle failure.
          break;
          default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: Colors.red,
            // width: 200,
            // height: 100,
            child: ApplePay(
              config: paymentConfig,
              onPaymentResult: onPaymentResult,
            ),
          ),
          const Text("or"),
          CreditCard(
            config: paymentConfig,
            onPaymentResult: onPaymentResult,
          )
        ],
      ),
    );
  }
}