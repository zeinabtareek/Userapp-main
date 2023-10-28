



//WalletWithdrawScreen



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/bank_info_view.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/wallet_money_amount_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/text_style.dart';
import '../../widgets/custom_body.dart';
import '../payment/credit_card_screen.dart';
import 'charge_withdraw_screen.dart';

class WalletWithdrawScreen extends StatefulWidget {
  const WalletWithdrawScreen({Key? key}) : super(key: key);

  @override
  State< WalletWithdrawScreen> createState() => _WalletWithdrawScreenState();
}

class _WalletWithdrawScreenState extends State<WalletWithdrawScreen> {
  final controller= Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body:

        Stack(
          children: [



        CustomBody(
        appBar: CustomAppBar(title: Strings.wallet.tr,onBackPressed: (){

          // Get.find<RideController>()
          //     .resetControllerValue();
          Get.back();


        },),

      body: SingleChildScrollView(
        child: Column(
          children: [
             Container(
                transform: Matrix4.translationValues(0, -30, 0),
                child:   WalletMoneyAmountWidget(isWithDraw: true,
                  onTap: (){
                  // Get.to(ChargeWithdrawScreen());
                  },)),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall),
                    child: Text(
                      'withdraw_amount'.tr,
                      style: textSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge),
                    ),
                  ),
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
                          controller:controller. amountController,
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
                            border:K. underlineInputBorder,
                            enabledBorder:K. underlineInputBorder,
                            focusedBorder: K.underlineInputBorder,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                      color: Theme.of(context).primaryColor.withOpacity(.25)),
                  Padding(
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
                                controller. amountController.text =
                                    K.suggestedAmount[index].toString();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeSmall),
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
                                      child: Text(K.suggestedAmount[index].toString(),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall),
                    child: Text(
                      'remark'.tr,
                      style: textSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller:controller. noteController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                          minWidth: Get.width / 2,
                        ),
                        hintText: 'remark_hint'.tr,
                        hintStyle: textRegular.copyWith(
                            color: Theme.of(context).hintColor.withOpacity(.5)),
                        border: K.underlineInputBorder,
                        enabledBorder:K. underlineInputBorder,
                        focusedBorder: K.underlineInputBorder,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
      Obx(()=>controller.state==ViewState.busy?      Center(child: CircularProgressIndicator(),):SizedBox(),),
     ] ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SizedBox(
          height: 25,
          child: CustomButton(
            radius: 20,
            buttonText: 'send_withdraw_request'.tr,
            onPressed: () {
              if(controller.amountController.text==''){
                OverlayHelper.showWarningToast(Get.overlayContext!, 'add_withdraw_amount_first'.tr ?? "");

              }
            else{
              // controller.withdrawWallet();
              controller.navigateToPayment(isCharge: false);
              // OverlayHelper.showSuccessToast(Get.overlayContext!, 'withdraw_successfully'.tr ?? "");

             }
            },
          ),
        ),
      ),

    );
  }
}
