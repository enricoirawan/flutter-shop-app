import 'package:flutter/material.dart';
import 'package:flutter_shop_app/common/get_it.dart';
import 'package:flutter_shop_app/common/navigation/router/auth_route.dart';
import 'package:lottie/lottie.dart';

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
    Future.delayed(const Duration(seconds: 3), () {
      _authRouter.navigateToHome();
    });
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
