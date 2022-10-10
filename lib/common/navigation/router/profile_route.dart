import 'package:flutter_shop_app/common/navigation/router/app_routes.dart';

import '../navigation_helper.dart';

abstract class ProfileRouter {
  void goBack({String? arguments});

  void navigateToHistoryTransaction();
}

class ProfileRouterImpl implements ProfileRouter {
  final NavigationHelper navigationHelper;

  ProfileRouterImpl({required this.navigationHelper});

  @override
  void goBack({String? arguments}) {
    navigationHelper.pop(arguments);
  }

  @override
  void navigateToHistoryTransaction() {
    navigationHelper.pushNamed(
      AppRoutes.historyTransactions,
    );
  }
}
