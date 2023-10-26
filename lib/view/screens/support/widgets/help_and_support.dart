import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../html/html_viewer_screen.dart';
import '../controller/support_controller.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({Key? key}) : super(key: key);
  final helpAndSupportController=Get.put(SupportController( ));

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: GetBuilder<SupportController>(
            init: SupportController(),
            initState: (context) => Get.find<SupportController>().getAllSetting(),
            builder: (helpAndSupportController) =>
                BaseStateWidget<SupportController>(
                  successWidget: SingleChildScrollView(
                    child: helpAndSupportController.helpAndSupportIndex==0?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Center(
                            child: Image.asset(
                          Images.helpAndSupport,
                          width: 172,
                          height: 129,
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<SupportController>(
                              init: SupportController(),
                              builder: (helpAndSupportController) =>  contactWithEmailOrPhone(
                              'contact_us_through_email'.tr,
                              'you_can_send_us_email_through'.tr,
                              "typically_the_support_team_send_you_any_feedback"
                                  .tr,
                              context,
                              helpAndSupportController
                                      .model.data?.about?.email?.value ??
                                  '',
                            ),
                            ),
                            const SizedBox(
                              height: Dimensions.paddingSizeLarge,
                            ),
                            GetBuilder<SupportController>(
                              init: SupportController(),
                              builder: (helpAndSupportController) =>      contactWithEmailOrPhone(
                              'contact_us_through_phone'.tr,
                              'contact_us_through_our_customer_care_number'.tr,
                              "talk_with_our_customer".tr,
                              context,
                              helpAndSupportController
                                      .model.data?.about?.phone?.value ??
                                  '',
                            )
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
                              email,
                              onPressed: () =>
                                  helpAndSupportController.launchUrlFun(
                                      "mailto:${helpAndSupportController.model.data?.about?.email?.value ?? ''}",
                                      true),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 20,
                            ),
                            _emailCallButton(
                                context, 'call'.tr, Icons.call, launchUri,
                                isCall: true, onPressed: () {
                              helpAndSupportController.launchUrlFun(
                                  "tel:${helpAndSupportController.model.data?.about?.phone?.value ?? ''}",
                                  false);
                            }),
                          ],
                        ),
                        K.sizedBoxH0,
                        // Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: Text('terms_and_condition'.tr,
                                style: DefaultTextStyle.of(context).style.copyWith(fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),),
                              onPressed: () {
                                helpAndSupportController.setHelpAndSupportIndex(1);
                                // const Expanded(child: HtmlViewerScreen()):
                              },
                            ),
                            Text('&'),
                            TextButton(
                              child: Text('privacy_policy'.tr,
                                style: DefaultTextStyle.of(context).style.copyWith(fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),),
                              onPressed: () {
                                helpAndSupportController.setHelpAndSupportIndex(2);
                                // const Expanded(child: HtmlViewerScreen()):
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                        : helpAndSupportController.helpAndSupportIndex==1? HtmlViewerScreen():
                    HtmlViewerScreen(isPolicy: true,)
                  ),
                  emptyWord: Strings.noDataToShow.tr,
                  onPressedRetryButton: () {
                    helpAndSupportController.getAllSetting();
                  },
                )));
  }

  Widget contactWithEmailOrPhone(String title, String subTitle, String message,
      context, String emailOrPhone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: textSemiBold.copyWith(
              fontSize: Dimensions.fontSizeLarge,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .color!
                  .withOpacity(0.8)),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTitle,
                style: textRegular.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color!
                        .withOpacity(.6)),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeExtraSmall,
              ),
              Text(
                emailOrPhone,
                style: textMedium.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium!.color!),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeSmall,
              ),
              Text(
                message,
                style: textRegular.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color!
                        .withOpacity(.6)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _emailCallButton(context, String title, IconData iconData, Uri uri,
      {bool isCall = false, onPressed}) {
    return CustomButton(
        width: 100,
        radius: Dimensions.radiusExtraLarge,
        buttonText: title,
        icon: iconData,
        onPressed: onPressed
        // () async{

        // await launchUrl(uri,mode: LaunchMode.externalApplication);
        // },
        );
  }

  final Uri launchUri = Uri(
    scheme: 'tel',
    path: "https://6amtech.com",
  );
  final Uri email = Uri(
    scheme: 'mailto',
    path: "https://6amtech.com",
  );
}
