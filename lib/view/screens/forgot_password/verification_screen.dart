import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/forgot_password/reset_password_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';


class VerificationScreen extends StatefulWidget {
  final String number;
  final bool fromOtpLogin;
  const VerificationScreen({super.key,required this.number,  this.fromOtpLogin = false});

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  Timer? _timer;
  int? _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds! - 1;
      if(_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: Strings.verification.tr,showBackButton: true,centerTitle: true,),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeLarge),
            child: GetBuilder<AuthController>(builder: (authController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.verification,
                    width: 120,
                  ),K.sizedBoxH0,

                   Text(Strings.enterVerificationCode.tr,style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                  K.sizedBoxH0,
                  SizedBox(
                    width: 240,
                    child: PinCodeTextField(
                      length: 4,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.slide,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        fieldHeight: 40,
                        fieldWidth: 40,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                        selectedFillColor: Get.isDarkMode?Colors.grey.withOpacity(0.6):Colors.white,
                        inactiveFillColor: Theme.of(context).cardColor,
                        inactiveColor: Theme.of(context).hintColor,
                        activeColor: Theme.of(context).hintColor,
                        activeFillColor: Theme.of(context).cardColor,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      onChanged: authController.updateVerificationCode,
                      beforeTextPaste: (text) => true,
                      textStyle: textSemiBold.copyWith(),
                      pastedTextStyle: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color),
                    ),
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(Strings.didNotReceiveTheCode.tr,style: K.greyMediumTextStyle,),
                        TextButton(
                          onPressed: (){
                            Get.find<AuthController>().forgetPassword();
                          },
                          child: Text(
                            Strings.resendIt.tr,style: K.greyMediumTextStyle,
                            textAlign: TextAlign.end,),),
                      ]) ,

                  K.sizedBoxH0,

                  authController.verificationCode.length == 4 ? !authController.isLoading! ? Padding(
                    padding: K.fixedPadding0,
                    child: CustomButton(
                      buttonText: Strings.send.tr,
                      radius: 50,
                      onPressed: () {
                        if(widget.fromOtpLogin){
                          Get.offAll(()=>  DashboardScreen());
                        }else{
                          Get.to(()=>const ResetPasswordScreen());
                        }
                      },
                    ),
                  ) : const Center(child: CircularProgressIndicator()) : const SizedBox.shrink(),
                K.sizedBoxH0,
                ],);
            }),
          ),
        ),
      ),
    );
  }
}
