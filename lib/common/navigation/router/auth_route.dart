import 'package:flutter_shop_app/common/navigation/navigation_helper.dart';
import 'package:flutter_shop_app/common/navigation/router/app_routes.dart';

abstract class AuthRouter {
  void goBack({String? arguments});

  void navigateToOnboard();

  void navigateToSignIn();

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
  void navigateToOnboard() {
    navigationHelper.pushReplacementNamed(AppRoutes.onboarding);
  }

  @override
  void navigateToHome() {
    navigationHelper.pushReplacementNamed(AppRoutes.home);
  }

  @override
  void navigateToSignIn() {
    navigationHelper.pushReplacementNamed(AppRoutes.signIn);
  }
}
