

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/today_notification_widget.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';

class ParcelNotificationScreen extends StatelessWidget {
  const ParcelNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return       Scaffold(
      body: CustomBody(
          appBar: CustomAppBar(
            title: Strings.notification.tr,
            showBackButton: true,
            centerTitle: true,
          ),
          body:

                SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [    K.sizedBoxH0,    K.sizedBoxH0,


                            TodayNotificationWidget(list: [2,3,4, ], title: Strings.today.tr,),
                            TodayNotificationWidget(list: [2, ], title: Strings.mostRecent.tr,),
                            ],
                          ),
                        ),


               )
    );
  }
}


