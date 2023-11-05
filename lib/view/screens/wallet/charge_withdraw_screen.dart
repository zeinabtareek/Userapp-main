
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/wallet_money_amount_widget.dart';

import '../../../enum/view_state.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/text_style.dart';
import '../../../util/ui/overlay_helper.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_button.dart';

class ChargeWithdrawScreen extends StatelessWidget {
    ChargeWithdrawScreen({Key? key}) : super(key: key);
    final controller=Get.put(WalletController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:   Stack(
          children: [   CustomBody(
        appBar: CustomAppBar(title: 'charge_amount'.tr,onBackPressed: (){
          controller.back();
          Get.back();
        },),

        body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            // Container(
            //     transform: Matrix4.translationValues(0, -30, 0),
            //     child:   WalletMoneyAmountWidget(isWithDraw: true,
            //       onTap: (){
            //         Get.to(ChargeWithdrawScreen());
            //       },)),


            K.sizedBoxH0,
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            //   child:

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall),
                    child: Text(
                      'charge_amount'.tr,//Charge the wallet amount
                      style: textSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge),
                    ),
                  ),
            K.sizedBoxH0,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('  ',
                          // Text('\$ ',
                          style: textBold.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              color: Theme.of(context).primaryColor)),
                      IntrinsicWidth(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller:controller. chargeAmountController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            constraints: BoxConstraints(
                              minWidth: Get.width / 2,
                            ),
                            hintText: 'enter_amount'.tr,
                            hintStyle: textRegular.copyWith(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(.5)),
                            border: K.underlineInputBorder,
                            enabledBorder: K.underlineInputBorder,
                            focusedBorder:K. underlineInputBorder,
                          ),
                        ),
                      ),
                    ],
                  ),
            K.sizedBoxH0,
                  Divider(
                      color: Theme.of(context).primaryColor.withOpacity(.25)),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child:    Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.paddingSizeSmall,
                        bottom: Dimensions.paddingSizeDefault),
                    child: SizedBox(
                      height: 30,
                      child: ListView.builder(
                          itemCount: K.suggestedAmount.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (amountContext, index) {
                            return InkWell(
                              onTap: () {
                                controller. chargeAmountController.text =
                                    K.suggestedAmount[index].toString();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeExtraSmall),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeLarge),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: Get.isDarkMode
                                              ? Theme.of(context)
                                              .hintColor
                                              .withOpacity(.5)
                                              : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.75))),
                                  child: Center(
                                      child: Text(
                                        K.suggestedAmount[index].toString(),
                                        style: textRegular.copyWith(
                                            color: Get.isDarkMode
                                                ? Theme.of(context)
                                                .hintColor
                                                .withOpacity(.5)
                                                : Theme.of(context).primaryColor),
                                      )),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  ),


                ],
              ),
            // ),
          // ],
        // ),
      )
      ),
        Obx(()=>controller.state==ViewState.busy?      Center(child: CircularProgressIndicator(),):SizedBox(),),
    ] ),
    bottomNavigationBar: Obx(()=> Padding(
    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
    child: SizedBox(
    height: 25,
    child: CustomButton(
      isLoading: controller.state==ViewState.busy?true:false,
    radius: 20,
    buttonText: 'send_charge_request'.tr,//إرسال طلب شحن المحفظة
    onPressed: () {
    if(controller.chargeAmountController.text==''){
    OverlayHelper.showWarningToast(Get.overlayContext!, 'add_charge_amount_first'.tr ?? "");

    }
    else{
    // controller.withdrawWallet();
    controller.navigateToPayment(isCharge:true);
    // OverlayHelper.showSuccessToast(Get.overlayContext!, 'withdraw_successfully'.tr ?? "");

    }
    },
    ),
    ),
    ),
    ),
    );
  }
}
