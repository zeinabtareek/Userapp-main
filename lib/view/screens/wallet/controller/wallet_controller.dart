import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';
import 'package:ride_sharing_user_app/view/screens/payment/controller/payment_controller.dart';

import '../../../../helper/display_helper.dart';
import '../../../../pagination/typedef/page_typedef.dart';
import '../../../../util/app_strings.dart';
import '../../payment/credit_card_screen.dart';
import '../repository/wallet_repo1.dart';

class WalletController extends BaseController implements GetxService {
  final WalletRepository walletRepo=WalletRepository();

  // WalletController();

  TextEditingController inputController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController chargeAmountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  // final controller =Get.put(WalletController());
  @override
  void onInit() {
    super.onInit();
   }

  @override
  void dispose() {
    for (var element in [amountController, noteController ,inputController,inputNode ]) {
      amountController.clear();
      noteController.clear();
      chargeAmountController.clear();
      element.dispose();
    }

    super.dispose();
  }
back(){
  amountController.clear();
  noteController.clear();
  chargeAmountController.clear();
}

  FocusNode inputNode = FocusNode();

  RxString amount = "0.0".obs;

  refreshAmount(String newAmount) {
    amount(newAmount);
  }

  // @override
  // void dispose() {
  //   inputController.dispose();
  //   inputNode.dispose();
  //   super.dispose();
  // }

  // List<MyEarnModel> myEarnList =[];
  // List<WalletItem> paymentMethodList =[];
  // List<WalletItem> promoCodeList =[];
  // List<WalletItem> voucherList =[];

  // bool isConvert = false;
  // void toggleConvertCard(bool value){
  //   isConvert = value;
  //   update();
  // }

  // void getMyEarnList() async {
  //   Response response = await walletRepo.getMyEarnList();
  //   if (response.statusCode == 200) {
  //     myEarnList = [];
  //     myEarnList.addAll(response.body);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }

  // void getPaymentMethodList() async {
  //   Response response = await walletRepo.getPaymentMethodList();
  //   if (response.statusCode == 200) {
  //     paymentMethodList = [];
  //     paymentMethodList.addAll(response.body);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }

  // void getVoucherList() async {
  //   Response response = await walletRepo.getVoucherList();
  //   if (response.statusCode == 200) {
  //     voucherList = [];
  //     voucherList.addAll(response.body);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }

  // void getPromoCodeList() async {
  //   Response response = await walletRepo.getPromoCodeList();
  //   if (response.statusCode == 200) {
  //     promoCodeList = [];
  //     promoCodeList.addAll(response.body);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }





  withdrawWallet({transactionId})async{
    setState(ViewState.busy);
   await walletRepo.withdrawWallet(amount:

   int.parse( amountController.text),
       note: noteController.text,

       transactionId:'$transactionId' );
    amountController.clear();
    noteController.clear();
    setState(ViewState.idle);
  }

  chargeWallet({transactionId})async{
    setState(ViewState.busy);
   await walletRepo.chargeWallet(amount:
   int.parse( chargeAmountController.text),
       transactionId:transactionId );
    chargeAmountController.clear();
      setState(ViewState.idle);
    update();

  }


  navigateToPayment({required bool isCharge}){
  int amount=(isCharge==true)?int.parse( chargeAmountController.text,):int.parse( amountController.text,);
  Get.off(()=>CreditCardScreen(
    paymentConfig: Get.find<PaymentController>().paymentConfigFunc( amount),
    onPaymentResult:isCharge==true?onPaymentResultCharge:onPaymentResult,
    amount: amount));  update();
}


  onPaymentResult(result) async {
    print('result of payment ${result.toString()}');
      if (result is PaymentResponse) {
        showCustomSnackBar(Strings.success.tr,isError: false);

       await withdrawWallet(transactionId: result.id);//
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


  onPaymentResultCharge(result) async {
    print('result of payment ${result.toString()}');
    if (result is PaymentResponse) {
      showCustomSnackBar(Strings.success.tr,isError: false);
      await chargeWallet(transactionId: result.id);//
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


    update();
  }



   }
