import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_shop_app/common/get_it.dart';
import 'package:flutter_shop_app/common/navigation/argument/detail_product_argument.dart';
import 'package:flutter_shop_app/common/navigation/router/home_route.dart';
import 'package:flutter_shop_app/common/navigation/router/profile_route.dart';

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'shop_app_channel', // id
    'Shop app channel notification', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/launch_background');

    var initSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final ProfileRouter profileRouter = sl();
    final HomeRouter homeRouter = sl();
    final String? payload = notificationResponse.payload;

    if (payload != null && payload.isNotEmpty) {
      homeRouter.navigateToDetailProduct(
        DetailProductArgument(
          productId: int.parse(payload),
        ),
      );
    } else {
      profileRouter.navigateToHistoryTransaction();
    }
  }

  void showSuccessCheckoutNotification(
    String? title,
    String? body,
  ) {
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
      payload: null,
    );
  }

  void showProductNotification(String? title, String? body, String productId) {
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
      payload: productId,
    );
  }
}
