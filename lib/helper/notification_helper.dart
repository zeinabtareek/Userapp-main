import 'dart:developer' as l;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';

import '../util/app_constants.dart';
import '../view/screens/dashboard/bottom_menu_controller.dart';

class NotificationHelper {
  static String? _fcmToken;
  static String? get fcmToken => _fcmToken;

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @pragma('vm:entry-point')
  static Future<void> initialize() async {
    _fcmToken = await FirebaseMessaging.instance.getToken();
    await _requestPermission(_flutterLocalNotificationsPlugin);
    l.log('fcmToken: $_fcmToken', name: 'TAG-FCM');

    AndroidInitializationSettings androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    _flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onTapLocalNotification,
    );
/*
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
       AndroidInitializationSettings androidInitialize =
          const AndroidInitializationSettings('notification_icon');
      var iOSInitialize = const DarwinInitializationSettings();
      var initializationsSettings = InitializationSettings(
          android: androidInitialize, iOS: iOSInitialize);
      flutterLocalNotificationsPlugin.initialize(
        initializationsSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
          // TODO: Route
          // try{
          //   if(payload != null && payload.isNotEmpty) {
          //     Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));
          //   }else {
          //     Get.toNamed(RouteHelper.getNotificationRoute());
          //   }
          // }catch (e) {}
          return;
        },
        onDidReceiveBackgroundNotificationResponse: myBackgroundMessageReceiver,
      );
      l.log('onMessageFrom Foreground : ${message.data}', name: 'TAG-FCM');
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, true);
    });
   
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      l.log('onMessageFrom Foreground : ${message.data}', name: 'TAG-FCM');
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      l.log('onOpenApp From Background: ${message.data}', name: "TAG-FCM");
    });

    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
          l.log('onOpenApp From terminated: ${message.data}', name: "TAG-FCM");
        }
      },
    );



 */

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        AndroidInitializationSettings androidInitialize =
            const AndroidInitializationSettings('notification_icon');
        var iOSInitialize = const DarwinInitializationSettings();
        var initializationsSettings = InitializationSettings(
            android: androidInitialize, iOS: iOSInitialize);
        _flutterLocalNotificationsPlugin.initialize(
          initializationsSettings,
          onDidReceiveNotificationResponse:
              (NotificationResponse response) async {
            // TODO: Route
            // try{
            //   if(payload != null && payload.isNotEmpty) {
            //     Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));
            //   }else {
            //     Get.toNamed(RouteHelper.getNotificationRoute());
            //   }
            // }catch (e) {}
            return;
          },
          onDidReceiveBackgroundNotificationResponse: onTapLocalNotification,
        );

        l.log('onMessage: ${message.data}', name: 'TAG-FCM');
        NotificationHelper.showNotification(
          message,
          _flutterLocalNotificationsPlugin,
          true,
        );
      },
    );

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   l.log('onOpenApp: ${message.data}', name: "TAG-FCM");
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      l.log('onOpenApp From Background: ${message.data}', name: "TAG-FCM");
    });

    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
          l.log('onOpenApp From terminated: ${message.data}', name: "TAG-FCM");
        }
      },
    );
  }



  static Future<void> _requestPermission(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions();
    }
    await FirebaseMessaging.instance.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      carPlay: true,
    );
  }

  static Future<void> showNotification(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin fln,
    bool data,
  ) async {
    l.log('showNotification: ${message.notification?.toMap()}',
        name: 'TAG-FCM');
    String title = message.notification?.title ?? "";
    String body = message.notification?.body ?? "";
    String? orderID = message.data['order_id'];

    String? image = (message.data['image'] != null &&
            message.data['image'].isNotEmpty)
        ? message.data['image'].startsWith('http')
            ? message.data['image']
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}'
        : null;

    try {
      await showBigPictureNotificationHiddenLargeIcon(
          title, body, orderID, image, fln);
    } catch (e) {
      await showBigPictureNotificationHiddenLargeIcon(
          title, body, orderID, null, fln);
      l.log('Failed to show notification: ${e.toString()}', name: "TAG-FCM");
    }
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String title,
      String body,
      String? orderID,
      String? image,
      FlutterLocalNotificationsPlugin fln) async {
    String? largeIconPath;
    String? bigPicturePath;
    BigPictureStyleInformation? bigPictureStyleInformation;
    BigTextStyleInformation? bigTextStyleInformation;
    if (image != null && !kIsWeb) {
      largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
      bigPicturePath = largeIconPath;
      bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        hideExpandedLargeIcon: true,
        contentTitle: title,
        htmlFormatContentTitle: true,
        summaryText: body,
        htmlFormatSummaryText: true,
      );
    } else {
      bigTextStyleInformation = BigTextStyleInformation(
        body,
        htmlFormatBigText: true,
        contentTitle: title,
        htmlFormatContentTitle: true,
      );
    }
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '6amTech',
      '6amTech',
      priority: Priority.max,
      importance: Importance.max,
      playSound: true,
      largeIcon:
          largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null,
      styleInformation: largeIconPath != null
          ? bigPictureStyleInformation
          : bigTextStyleInformation,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

@pragma('vm:entry-point')
Future<dynamic> myBackgroundMessageHandler(RemoteMessage remoteMessage) async {
  l.log('onBackground: ${remoteMessage.data}', name: "TAG-FCM");
  // var androidInitialize = new AndroidInitializationSettings('notification_icon');
  // var iOSInitialize = new IOSInitializationSettings();
  // var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
}

Future<dynamic> onTapLocalNotification(NotificationResponse response) async {
  l.log('onForegroundClicked - onTapLocalNotification: ${response.payload}',
      name: 'TAG-FCM');
      
}
  void onDidReceiveNotificationResponse(NotificationResponse response) async {
      l.log(
        'onForegroundClicked - onDidReceiveNotificationResponse: ${response.payload}',
        name: 'TAG-FCM',
      );
  
      Get.to(() => DashboardScreen());
      Get.find<BottomMenuController>().selectNotificationScreen();
  
      // TODO: Route
      // try{
      //   if(payload != null && payload.isNotEmpty) {
      //     Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));
      //   }else {
      //     Get.toNamed(RouteHelper.getNotificationRoute());
      //   }
      // }catch (e) {}
      return;
    }
