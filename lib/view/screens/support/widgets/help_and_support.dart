import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../util/app_style.dart';


class ContactUsPage extends StatelessWidget {

  ContactUsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Center(child: Image.asset(Images.helpAndSupport,width: 172,height: 129,)),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  contactWithEmailOrPhone(
                    'contact_us_through_email'.tr,
                    'you_can_send_us_email_through'.tr,
                    "typically_the_support_team_send_you_any_feedback".tr,
                    context,
                    "6amTech@gmail.com",
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge,),
                  contactWithEmailOrPhone(
                    'contact_us_through_phone'.tr,
                    'contact_us_through_our_customer_care_number'.tr,
                    "talk_with_our_customer".tr,
                    context,
                   "01700000000",
                  )
                ],
              ),
              K.sizedBoxH0,
              K.sizedBoxH0,
              //email and call section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _emailCallButton(
                      context,
                      'email'.tr,
                      Icons.email,
                      email
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/20,),
                  _emailCallButton(
                    context,
                    'call'.tr,
                    Icons.call,
                    launchUri,
                    isCall:true,
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    ;
  }

  Widget contactWithEmailOrPhone(String title,String subTitle,String message,context,String emailOrPhone){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),),
        const SizedBox(height: Dimensions.paddingSizeLarge,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subTitle,style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.6)),),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
              Text(emailOrPhone,style: textMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!),),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Text(message,style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.6)),),
            ],
          ),
        ),
      ],
    );
  }

  _emailCallButton(context,String title,IconData iconData,Uri uri, {bool isCall = false}){
    return  CustomButton(
      width: 100,
      radius: Dimensions.radiusExtraLarge,
      buttonText: title,
      icon: iconData,
      onPressed: () async{
        await launchUrl(uri,mode: LaunchMode.externalApplication);
      },
    );
  }

  final Uri launchUri =  Uri(
    scheme: 'tel',
    path: "https://6amtech.com",
  );
  final Uri email =  Uri(
    scheme: 'mailto',
    path: "https://6amtech.com",
  );
}