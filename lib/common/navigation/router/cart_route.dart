import 'package:flutter_shop_app/common/navigation/navigation_helper.dart';
import 'package:flutter_shop_app/common/navigation/router/app_routes.dart';

abstract class CartRouter {
  void goBack({String? arguments});

  void navigateToCart();
}

class CartRouterImpl implements CartRouter {
  final NavigationHelper navigationHelper;

  CartRouterImpl({required this.navigationHelper});

  @override
  void goBack({String? arguments}) {
    return navigationHelper.pop(arguments);
  }

  @override
  void navigateToCart() {
    navigationHelper.pushNamed(AppRoutes.cart);
  }
}
