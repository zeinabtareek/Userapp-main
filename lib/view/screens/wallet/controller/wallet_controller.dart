import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/controller/base_controller.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/my_earn_model.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/wallet_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/wallet_model.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/repository/wallet_repo.dart';

import '../../../../helper/logger/logger.dart';
import '../../../../util/action_center/action_center.dart';
import '../repository/wallet_repo1.dart';
import '../../../../enum/view_state.dart';

class WalletController extends BaseController implements GetxService{
  final WalletRepo walletRepo;

  WalletController({required this.walletRepo});

  TextEditingController inputController = TextEditingController();
  FocusNode inputNode = FocusNode();

  List<MyEarnModel> myEarnList =[];
  List<WalletItem> paymentMethodList =[];
  List<WalletItem> promoCodeList =[];
  List<WalletItem> voucherList =[];


  bool isConvert = false;
  void toggleConvertCard(bool value){
    isConvert = value;
    update();
  }


  void getMyEarnList() async {
    Response response = await walletRepo.getMyEarnList();
    if (response.statusCode == 200) {
      myEarnList = [];
      myEarnList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void getPaymentMethodList() async {
    Response response = await walletRepo.getPaymentMethodList();
    if (response.statusCode == 200) {
      paymentMethodList = [];
      paymentMethodList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void getVoucherList() async {
    Response response = await walletRepo.getVoucherList();
    if (response.statusCode == 200) {
      voucherList = [];
      voucherList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void getPromoCodeList() async {
    Response response = await walletRepo.getPromoCodeList();
    if (response.statusCode == 200) {
      promoCodeList = [];
      promoCodeList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllTransactions();
  }
  ///TODO fetch wallet api
  final repo=WalletRepository();
  final ActionCenter _actionCenter = ActionCenter(Get.find<AbsLogger>());
  WalletModel  model=WalletModel( );
  // List<WalletData> model=<WalletData>[];

  getAllTransactions()async{

    var result = (await _actionCenter.execute(
          () async {

        setState(ViewState.busy);
        model = await   repo.getAllTransactions();
        if (model.data!.isNotEmpty ) {
          setState(ViewState.idle);
        } else {
          setState(ViewState.noDate);
        }   },
      checkConnection: true,
    ));
    if (!result) {
      setState(ViewState.error);
      print(" ::: error in getting transaction ");
    }update();

  }



}