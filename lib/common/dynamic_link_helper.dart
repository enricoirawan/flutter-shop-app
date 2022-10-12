import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_shop_app/common/get_it.dart';
import 'package:flutter_shop_app/common/navigation/argument/detail_product_argument.dart';
import 'package:flutter_shop_app/common/navigation/router/home_route.dart';

class DynamicLinkHelper {
  final HomeRouter _homeRouter = sl();

  Future<void> handleDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data);

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _handleDeepLink(dynamicLinkData);
    }).onError((error) {
      // Handle errors
    });
  }

  void _handleDeepLink(PendingDynamicLinkData? data) {
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      bool isProduct = deepLink.pathSegments.contains("products");
      if (isProduct) {
        String? productId = deepLink.queryParameters["productId"];

        if (productId != null) {
          _homeRouter.navigateToDetailProduct(
            DetailProductArgument(
              productId: int.parse(productId),
            ),
          );
        }
      }
    }
  }
}
