import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/today_notification_widget.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../notification/notification_screen.dart';

class ParcelNotificationScreen extends StatelessWidget {
  const ParcelNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: NotificationScreen());
  }
}
