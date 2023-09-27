import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/date_converter.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/my_earn_model.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/wallet_model.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

import '../../../../util/app_strings.dart';






class MyEarnCardWidget extends StatelessWidget {
  final WalletData myEarnModel;
  // final MyEarnModel myEarnModel;
  void Function()? onTap;
   MyEarnCardWidget({Key? key, required this.myEarnModel,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
      child: GetBuilder<WalletController>(
        builder: (walletController) {
          return Column(
            children: [
              GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                  child: Row(children: [
                    Expanded(child:
                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(width: Dimensions.iconSizeLarge,
                        //     child: Image.asset(Images.myEarnIcon)),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          SizedBox(

                              width:MediaQuery.of(context).size.width/2,

                              child: Text('${'XID'}# ${myEarnModel.id??''}', style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),maxLines: 3,overflow: TextOverflow.ellipsis,)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                            child: Text(DateConverter.dateTimeStringToDateOnly(myEarnModel.createdAt!),
                              style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                          ),
                          Text('${Strings.tripId.tr} : ${myEarnModel.order!.id}', style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),)
                        ],),
                      ],
                    )),
                    Container(
                      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).primaryColor.withOpacity(.15)),
                      child:
                      Text(PriceConverter.convertPrice(context,double.parse( myEarnModel.amount.toString())),
                        style: textBold.copyWith(color: Theme.of(context).primaryColor)))
                  ],),
                ),
              ),
              CustomDivider(height: .5,color: Theme.of(context).hintColor.withOpacity(.75),)
            ],
          );
        }
      ),
    );
  }
}
