import 'package:flutter_shop_app/common/navigation/argument/detail_product_argument.dart';
import 'package:flutter_shop_app/common/navigation/router/app_routes.dart';

import '../navigation_helper.dart';

abstract class HomeRouter {
  void goBack({String? arguments});

  void navigateToDetailProduct(DetailProductArgument detailProductArgument);
}

class HomeRouterImpl implements HomeRouter {
  final NavigationHelper navigationHelper;

  HomeRouterImpl({required this.navigationHelper});

  @override
  void goBack({String? arguments}) {
    navigationHelper.pop(arguments);
  }

  @override
  void navigateToDetailProduct(DetailProductArgument detailProductArgument) {
    navigationHelper.pushNamed(
      AppRoutes.detailProduct,
      arguments: detailProductArgument,
    );
  }
}
