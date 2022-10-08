import 'package:flutter_shop_app/common/navigation/navigation_helper.dart';
import 'package:flutter_shop_app/common/navigation/router/app_routes.dart';

abstract class AuthRouter {
  void goBack({String? arguments});

  void navigateToSplash();

  void navigateToOnboard();

  void navigateToSignIn();

  void navigateToGetUserPosition();

  void navigateToHome();
}

class AuthRouterImpl implements AuthRouter {
  final NavigationHelper navigationHelper;

  AuthRouterImpl({required this.navigationHelper});

  @override
  void goBack({String? arguments}) {
    return navigationHelper.pop(arguments);
  }

  @override
  void navigateToSplash() {
    navigationHelper.pushNamedAndRemoveUntil(AppRoutes.splash);
  }

  @override
  void navigateToOnboard() {
    navigationHelper.pushReplacementNamed(AppRoutes.onboarding);
  }

  @override
  void navigateToHome() {
    navigationHelper.pushReplacementNamed(AppRoutes.main);
  }

  @override
  void navigateToGetUserPosition() {
    navigationHelper.pushReplacementNamed(AppRoutes.getUserAddress);
  }

  @override
  void navigateToSignIn() {
    navigationHelper.pushReplacementNamed(AppRoutes.signIn);
  }
}
