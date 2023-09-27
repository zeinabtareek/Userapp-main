import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/my_earn_card_widget.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/payment_method_screen.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/wallet_money_amount_widget.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/custom_title.dart';

import '../../../../controller/base_controller.dart';
import '../../../../util/app_strings.dart';
import '../../../widgets/confirmation_dialog.dart';

class WalletMoneyScreen extends StatelessWidget {
  const WalletMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<WalletController>().getMyEarnList();

    return GetBuilder<WalletController>(builder: (walletController) {
      return BaseStateWidget<WalletController>(
        successWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.paddingSizeDefault),
            WalletMoneyAmountWidget(
              walletMoney: true,
              amount: walletController.model.wallet.toString() ?? '0.0',
            ),
            InkWell(
              onTap: () => Get.to(() => const PaymentMethodScreen()),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTitle(
                      title: Strings.checkPaymentMethod.tr,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      icon: Images.profileMyWallet,
                    ),
                    TextButton(
                        onPressed: () =>
                            Get.to(() => const PaymentMethodScreen()),
                        child: const Text(Strings.withdraw))
                    // IconButton(onPressed: (){},
                    //   icon: Icon(Icons.arrow_forward_ios_outlined,color: Theme.of(context).primaryColor,size: 18,),
                    // ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Divider(),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: walletController.model.data?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return MyEarnCardWidget(
                      myEarnModel: walletController.model.data![index],
                      onTap: () {
                        // showDialog(
                        //     context: context,
                        //     builder: (_) {
                        //       return ConfirmationDialog(
                        //         icon: Images.walletMoney,
                        //         title: 'details',
                        //         description: '',
                        //         onYesPressed: () {
                        //
                        //         },
                        //       );
                        //     });
                      },
                    );
                  }),
            )
          ],
        ),
        emptyWord: Strings.noHistory.tr,
        onPressedRetryButton: () {
          walletController.getAllTransactions();
        },
      );
    });
  }
}
