import 'package:flutter_shop_app/common/navigation/argument/checkout_argument.dart';
import 'package:flutter_shop_app/common/navigation/navigation_helper.dart';
import 'package:flutter_shop_app/common/navigation/router/app_routes.dart';

abstract class CheckoutRouter {
  void goBack({String? arguments});

  void navigateToCheckout(CheckoutArgument checkoutArgument);

  void navigateToSuccessPayment();
}

class CheckoutRouterImpl implements CheckoutRouter {
  final NavigationHelper navigationHelper;

  CheckoutRouterImpl({required this.navigationHelper});

  @override
  void goBack({String? arguments}) {
    return navigationHelper.pop(arguments);
  }

  @override
  void navigateToCheckout(CheckoutArgument checkoutArgument) {
    navigationHelper.pushNamed(AppRoutes.checkout, arguments: checkoutArgument);
  }

  @override
  void navigateToSuccessPayment() {
    navigationHelper.pushNamed(AppRoutes.paymentSuccess);
  }
}
