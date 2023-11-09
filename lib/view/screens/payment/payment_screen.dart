
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/payment/controller/payment_controller.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/digital_card_payment_widget.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/payment_type_item_widget.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/review_screen.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/tips_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/trip_fare_summery.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../../util/app_style.dart';
import '../wallet/widget/use_voucher_code.dart';
import '../where_to_go/controller/create_trip_controller.dart';
import 'credit_card_screen.dart';

class PaymentScreen extends StatelessWidget {
    PaymentScreen({Key? key}) : super(key: key);

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//final controller=Get.put(PaymentController(paymentRepo: Get.f));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PaymentController>(
        builder: (paymentController) {
          return GestureDetector(
            onTap: (){
              if(paymentController.isApplePay.value==true){
              paymentController.isApplePay.value=false;
Get.back();
            };
            },
            child: CustomBody(
              appBar: CustomAppBar(title: 'here_is_your_payment'.tr,onBackPressed: (){
                if(Navigator.canPop(context))
                Get.back();
              },showBackButton: false,),
              body:  GetBuilder<CreateATripController>(
                init: CreateATripController(),
                // initState: Get.find<CreateATripController>().showTrip(),
                builder: (controller) =>  SingleChildScrollView(child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraLarge),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text('payment'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                    // Container(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeThree),
                    //     decoration: BoxDecoration(
                    //       color: Theme.of(context).primaryColor.withOpacity(.2),
                    //   borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    // ),child: Row(children: [
                    //   Text('cash'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
                    //   const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                    //   SizedBox(width: Dimensions.iconSizeSmall, child: Image.asset(Images.cash))
                    // ],))
                  ],),


                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text('this_trip_is'.tr),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                  Text('complete'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                ],),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: Text(PriceConverter.convertPrice(context, double.parse(controller.orderModel.data?.finalPrice.toString()??'0.0')),style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeOverLarge,color: Theme.of(context).textTheme.bodyMedium!.color)),
                ),

                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('your'.tr, style: textMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color),),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                  Text('total_fare'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                  Text('for_this_trip'.tr, style: textMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color),),
                ],),

                Row(crossAxisAlignment: paymentController.paymentTypeSelectedIndex == 2? CrossAxisAlignment.end:CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: paymentController.paymentTypeList.length,
                          itemBuilder: (context, index){
                        return PaymentTypeItem(
                            title: paymentController.paymentTypeList[index],
                          isDisabled:index==2&&double.parse(paymentController.user?.wallet.toString()??'0.0')<double.parse(controller.orderModel.data?.finalPrice.toString()??'0.0')?true:false,
                          index: index,
                          selectedIndex: paymentController.paymentTypeSelectedIndex??0,
                          // selectedIndex: paymentController.paymentTypeSelectedIndex,
                        );
                      }),
                    ),



                    // //Text(paymentController.user?.wallet.toString()??""),
                    Text(paymentController.digitalPaymentMethodList.length.toString()??""),
                    // paymentController.paymentTypeSelectedIndex == 1?
                    // GestureDetector(
                    //   onTap: (){
                    //     showDialog(context: context, builder: (_)=>const TipsWidget());
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    //     child: Container(decoration: BoxDecoration(
                    //         color: Theme.of(context).primaryColor.withOpacity(.35),
                    //         borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                    //     ),
                    //       child: Center(
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(horizontal:Dimensions.iconSizeSmall, vertical: Dimensions.paddingSizeSmall),
                    //           child: Text(paymentController.tipAmount == '0'? 'add_tips'.tr:'${'tips'.tr}-${paymentController.tipAmount}', style: textSemiBold.copyWith(color: Theme.of(context).primaryColorDark),),
                    //         ),
                    //       ),),
                    //   ),
                    // ):
                    /// here we will change the wallet amount

                    paymentController.paymentTypeSelectedIndex == 2
                        ? Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(text: 'available'.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                            TextSpan(
                              text: PriceConverter.convertPrice(context, double.parse(paymentController.user?.wallet.toString()??'0.0')),
                              style: textSemiBold.copyWith(color: Theme.of(context).hintColor)
                            ),

                          ],
                      ),
                    ),
                        ):const SizedBox()
                  ],
                ),

                paymentController.paymentTypeSelectedIndex == 1?
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge),
                  child: Stack(
                    children: [
                      SizedBox(height: 160,
                        child: ListView.builder(
                          // itemCount: 2,
                          itemCount: paymentController.digitalPaymentMethodList.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                            return
                              DigitalCardPaymentWidget(
                              digitalPaymentModel: paymentController.digitalPaymentMethodList[index],
                              index: index,
                            onTap:  (){
                                if(index==0){

                                  if(paymentController.isApplePay.value==true){
                                    paymentController.isApplePay.value=false;
                                    Get.back();
                                  };
                              Get.find<PaymentController>().setDigitalPaymentType(index);
                              Get.to(()=>CreditCardScreen(
                                paymentConfig: paymentController.paymentConfigFunc( Get.find<CreateATripController>().orderModel.data?.finalPrice?.toInt()??1, ),
                                onPaymentResult: paymentController.onPaymentResult,
                                amount: Get.find<CreateATripController>().orderModel.data?.finalPrice?.toInt()??1,
                              ));



                                 }else if(index==1){
                                  paymentController.isApplePay.value=true;
                                  showBottomSheet(context: context, builder: (BuildContext context){

                                    return    Container(
                                      width: MediaQuery.of(context).size.width.w,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          K.sizedBoxH0,
                                          Padding(
                                            padding:  EdgeInsetsDirectional.only(start: 5.w,end: 5.w,bottom: 10.h,top: 20.h),
                                            child: Text("pay_with_apple_pay".tr,style: K.boldBlackTextStyle,),
                                          ),Padding(
                                            padding: EdgeInsetsDirectional.only(start: 20.w),
                                            child: Text("click_on_btn_to_finish_your_billing".tr,style: K.blackTextStyleLarge,),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(30.sp),
                                            height: 200.h,
                                            width: 100.w,
                                            color: Colors.red,
                                            // child: ApplePay(
                                            //   config:paymentController.paymentConfigFunc( Get.find<CreateATripController>().orderModel.data?.finalPrice?.toInt()??1, ),
                                            //   onPaymentResult: paymentController.onPaymentResult,
                                            // ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });



                                 }
                              }
                            );

                        }),
                      ),

                    ],
                  ),
                ):const SizedBox(),
                Padding(
                  padding:  const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
                  child: Container(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.125),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                  ),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text('trip_details'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
                     Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor.withOpacity(.75),)
                  ],),),
                ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault),
                  child: RouteWidget(),
                ),

              GetBuilder<CreateATripController>(
                init: CreateATripController(),
                // initState: Get.find<CreateATripController>().showTrip(),
                builder: (controller) =>      TripFareSummery(fromPayment: true,paymentMethod: controller.orderModel.data?.paymentType.toString()??'',),)

              ],),),
            )),
          );
        }
      ),
      bottomNavigationBar:
      // GetBuilder<PaymentController>(
    // init: PaymentController(),
      //  initState:
    // builder: (controller)=>
   Obx(() =>Get.find<PaymentController>().isApplePay.value==true?const SizedBox():
      Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
        height: 80,

        child: CustomButton(buttonText: 'pay_now'.tr,
        radius: 25,
        onPressed: (){
          // Get.off(()=> const UseCouponScreen());
          Get.off(()=> const ReviewScreen());
      // Get.off(()=> const  ());
        })),
      )
    );
  }
}






