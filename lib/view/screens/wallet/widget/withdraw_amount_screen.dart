import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/custom_title.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/wallet_money_amount_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../../../util/app_strings.dart';


class WithdrawAmountScreen extends StatefulWidget {
  const WithdrawAmountScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawAmountScreen> createState() => _WithdrawAmountScreenState();
}

class _WithdrawAmountScreenState extends State<WithdrawAmountScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: const CustomAppBar(title: ""),
          body: Column(children: [

            CustomTitle(title: Strings.walletMoney.tr, color: Theme.of(context).textTheme.displayLarge!.color,),
            const WalletMoneyAmountWidget(walletMoney: true,amount: '300',),
          ],)
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SizedBox(height: 50,
          child: CustomButton(buttonText: Strings.sendWithdrawRequest.tr,
          onPressed: (){},),),
      ),
    );
  }
}
