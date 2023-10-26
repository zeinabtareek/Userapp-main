import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';

class WalletController extends BaseController implements GetxService {
  // final WalletRepo walletRepo;

  WalletController();

  TextEditingController inputController = TextEditingController();
  FocusNode inputNode = FocusNode();

  RxString amount = "0.0".obs;

  refreshAmount(String newAmount) {
    amount(newAmount);
  }

  @override
  void dispose() {
    inputController.dispose();
    inputNode.dispose();
    super.dispose();
  }

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getAllTransactions();
  }
}
