import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/my_earn_card_widget.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/custom_title.dart';

import '../../../../pagination/typedef/page_typedef.dart';
import '../../../../pagination/widgets/paginations_widgets.dart';
import '../../../../util/app_strings.dart';
import '../charge_withdraw_screen.dart';
import '../pagnation/get_all_transactions_use_case.dart';
import '../wallet_withdraw_screen.dart';
import 'wallet_money_amount_widget.dart';

class WalletMoneyScreen extends StatelessWidget {
  const WalletMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.find<WalletController>().getMyEarnList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: Dimensions.paddingSizeDefault),
          WalletMoneyAmountWidget(onTap: () {
            Get.to(() =>   ChargeWithdrawScreen());

          },),
        InkWell(
          onTap: () {
            // Get.to(() => const PaymentMethodScreen());
          },
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
                    onPressed: () {
                      Get.to(() => const WalletWithdrawScreen());
                    },
                    child: const Text(Strings.withdraw))
                // IconButton(onPressed: (){},
                //   icon: Icon(Icons.arrow_forward_ios_outlined,color: Theme.of(context).primaryColor,size: 18,),
                // ),
              ],
            ),
          ),
        ),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Divider(),
        ),

        SizedBox(
          height: ((Get.height / 3) * 1.5),
          child: GetBuilder<PaginateAllTransactionsController>(
              init: PaginateAllTransactionsController(
                GetAllTransactionsUseCase(),
              ),
              builder: (con) {
                return PaginateAllTransactionsView(
                  listPadding: const EdgeInsets.only(top: 0, bottom: 90),
                  child: (entity) => MyEarnCardWidget(
                    data: entity,
                    onTap: () {},
                  ),
                  paginatedLst: (list) {
                    return SmartRefresherApp(
                      controller: con,
                      list: list,
                    );
                  },
                );
              }),
        )
        // Expanded(
        //   child: ListView.builder(
        //       itemCount: walletController.model.data?.length,
        //       shrinkWrap: true,
        //       itemBuilder: (context, index) {
        //         return MyEarnCardWidget(
        //           data: walletController.model.data![index],
        //           onTap: () {
        //             // showDialog(
        //             //     context: context,
        //             //     builder: (_) {
        //             //       return ConfirmationDialog(
        //             //         icon: Images.walletMoney,
        //             //         title: 'details',
        //             //         description: '',
        //             //         onYesPressed: () {
        //             //
        //             //         },
        //             //       );
        //             //     });
        //           },
        //         );
        //       }),
        // )
      ],
    );
  }
}
