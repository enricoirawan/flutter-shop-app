import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/navigation/argument/detail_product_argument.dart';
import 'package:flutter_shop_app/common/navigation/router/home_route.dart';
import 'package:flutter_shop_app/domain/entity/response/product_entity.dart';
import 'package:octo_image/octo_image.dart';

import '../../common/get_it.dart';
import '../../common/styles.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeRouter homeRouter = sl();

    return InkWell(
      onTap: () {
        homeRouter.navigateToDetailProduct(
            DetailProductArgument(productId: product.id));
      },
      child: Container(
        height: 300.h,
        margin: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          bottom: 10.h,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 4),
              spreadRadius: -3,
              blurRadius: 10,
              color: grayColor,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: product.id,
              child: OctoImage(
                image: CachedNetworkImageProvider(
                  product.image,
                ),
                placeholderBuilder: OctoPlaceholder.blurHash(
                  'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                ),
                errorBuilder: OctoError.icon(
                  color: Colors.red,
                ),
                fit: BoxFit.contain,
                width: double.infinity,
                height: 150.h,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 6.h,
                left: 5.w,
                right: 5.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    "\$${product.price}",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: primaryColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
