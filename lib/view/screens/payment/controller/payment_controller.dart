
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';
 import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/helper/cache_helper.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/ui/overlay_helper.dart';
import 'package:ride_sharing_user_app/view/screens/payment/repository/payment_repo.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/digital_payment_model.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/controller/create_trip_controller.dart';

import '../../../../bases/base_controller.dart';
import '../../../../util/app_strings.dart';
import '../../ride/controller/ride_controller.dart';
import '../widget/review_screen.dart';

class PaymentController extends BaseController implements GetxService{
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
  int ?paymentTypeSelectedIndex    ;
  // int paymentTypeSelectedIndex = 0;
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
@override
    onInit() async{
    // TODO: implement onInit
    super.onInit();


    await getDigitalPaymentMethodList();
    await checkUserFirstSelection();



  }

  checkUserFirstSelection()async{
//['cash', 'digital', 'wallet',];
    if(Get.find<RideController>().initialSelectItem=='cash'){
      paymentTypeSelectedIndex=0;
    }
    else if(Get.find<RideController>().initialSelectItem=='digital'){
      paymentTypeSelectedIndex=1;

    } else if(Get.find<RideController>().initialSelectItem=='wallet'){
      paymentTypeSelectedIndex=2;

    }
update();
  }


    getDigitalPaymentMethodList() async {
    Response response = await paymentRepo.getActivityList();
    if (response.statusCode == 200) {
      digitalPaymentMethodList = [];
      digitalPaymentMethodList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  // amount: Get.find<CreateATripController>().orderModel.data?.finalPrice?.toInt()??1, // SAR 257.58
  ///Moyaser gateway
  // final paymentConfig = PaymentConfig(
  //   publishableApiKey: 'pk_test_gYHJb7Dzs3SUjghm2JFhLrFPdQRKzxb4V5W8FDib',
  //   amount:amount,
  //    description: 'order #${Get.find<CreateATripController>().orderModel.data?.id}',
  //   metadata: {'size': '250g'},
  //   applePay: ApplePayConfig(merchantId: 'YOUR_MERCHANT_ID', label: 'YOUR_STORE_NAME', manual: false),
  // );


  paymentConfigFunc(int amount){
    return PaymentConfig(
      publishableApiKey: 'pk_test_gYHJb7Dzs3SUjghm2JFhLrFPdQRKzxb4V5W8FDib',
      amount:amount,
      description: 'order #${Get.find<CreateATripController>().orderModel.data?.id}',
      metadata: {'size': '250g'},
      applePay: ApplePayConfig(merchantId: 'YOUR_MERCHANT_ID', label: 'YOUR_STORE_NAME', manual: false),
    );
  }


  Future<void> onPaymentResult(result) async {
    print('result of payment ${result.toString()}');
    if (result is PaymentResponse) {
       showCustomSnackBar(Strings.success.tr);
      await CacheHelper.setValue(kay: Strings.transactionId, value: result.id);
       // showCustomSnackBar(result.id);
       Get.off(()=> const ReviewScreen());

      switch (result.status) {
        case PaymentStatus.paid:
        // handle success.
          break;
        case PaymentStatus.failed:
        // handle failure.
          break;
        case PaymentStatus.authorized:
        // handle authorized

          break;
        default:
      }
      return;
    }

    // handle other type of failures.
    if (result is ApiError) {
      print(result.message);
      showCustomSnackBar(result.message.toString());
    }
    if (result is AuthError) {
      print(result.message);
      showCustomSnackBar(result.message.toString());
    }
    if (result is ValidationError) {
      print(result.errors);
       showCustomSnackBar(result.errors.toString());

    }
    if (result is PaymentCanceledError) {
      print(result);
      showCustomSnackBar(result.toString());
    }
  }

}

class ReviewModel{
  String? icon;
  String? title;

  ReviewModel(this.icon, this.title);
}