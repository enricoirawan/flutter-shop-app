import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/common/get_it.dart';
import 'package:flutter_shop_app/common/navigation/router/auth_route.dart';
import 'package:lottie/lottie.dart';

import '../../common/constant.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  final AuthRouter _authRouter = sl();

  @override
  void initState() {
    super.initState();
    goToHome();
  }

  void goToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      _pushSuccessCheckoutNotification();
      _authRouter.navigateToHome();
    });
  }

  void _pushSuccessCheckoutNotification() async {
    Dio dio = sl();
    final fcmToken = await FirebaseMessaging.instance.getToken();

    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    headers['Authorization'] =
        "Bearer ${AppConstants.fcmServerKey.fcmServerKey}";

    await dio.post(
      AppConstants.appApi.pushNotif,
      options: Options(
        headers: headers,
      ),
      data: {
        "priority": "HIGH",
        "notification": {
          "title": "Checkout berhasil!",
          "body": "Yuhuuu checkout kamu berhasil, terima kaish sudah belanja ya"
        },
        "data": {},
        "to": fcmToken,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/payment-successfull.json",
          ),
        ],
      ),
    );
  }
}
