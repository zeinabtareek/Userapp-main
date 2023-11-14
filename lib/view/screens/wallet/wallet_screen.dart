import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/wallet_money_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get.find<WalletController>().getMyEarnList();
    // Get.find<WalletController>().getPaymentMethodList();
    // Get.find<WalletController>().getVoucherList();
    // Get.find<WalletController>().getPromoCodeList();
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: CustomBody(
        appBar: CustomAppBar(title: Strings.wallet.tr),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeDefault),
              child: SizedBox(
                  height: 30,
                  child: Text(
                    Strings.walletMoney.tr,
                    style: K.primaryMediumTextStyle,
                  )),
            ),
            const WalletMoneyScreen()
          ],
        ),
      ),
    );
  }
}
