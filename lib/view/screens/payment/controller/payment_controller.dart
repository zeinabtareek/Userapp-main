
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/payment/repository/payment_repo.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/digital_payment_model.dart';

class PaymentController extends GetxController implements GetxService{
  final PaymentRepo paymentRepo;

  PaymentController({required this.paymentRepo});

  List<DigitalPaymentModel> digitalPaymentMethodList = [];

  List<ReviewModel> reviewTypeList  = [
    ReviewModel(Images.notGood, 'not_good'),
    ReviewModel(Images.good, 'good'),
    ReviewModel(Images.satisfied, 'satisfied'),
    ReviewModel(Images.lovely, 'lovely'),
    ReviewModel(Images.superb, 'superb'),
  ];

  int reviewTypeSelectedIndex = 2;
  void setReviewType(int index){
    reviewTypeSelectedIndex = index;
    update();
  }

  List<String> paymentTypeList = ['cash_pay', 'digital_pay', 'use_wallet_money'];
  int paymentTypeSelectedIndex = 0;
  void setPaymentType(int index){
    paymentTypeSelectedIndex = index;
    update();

  }



  void setDigitalPaymentType(int index){
    digitalPaymentMethodList[index].isSelected =  !digitalPaymentMethodList[index].isSelected;
    update();

  }

  String tipAmount = '0';
  void setTipAmount(String amount){
    tipAmount = amount;
    update();
  }


  void getDigitalPaymentMethodList() async {
    Response response = await paymentRepo.getActivityList();
    if (response.statusCode == 200) {
      digitalPaymentMethodList = [];
      digitalPaymentMethodList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


///Moyaser gateway
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
      }
    }
  }

}

class ReviewModel{
  String? icon;
  String? title;

  ReviewModel(this.icon, this.title);
}