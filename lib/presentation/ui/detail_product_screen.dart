import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/navigation/argument/detail_product_argument.dart';
import 'package:flutter_shop_app/common/navigation/router/home_route.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:octo_image/octo_image.dart';

import '../../common/get_it.dart';

class DetailProductScreen extends StatefulWidget {
  final DetailProductArgument argument;

  const DetailProductScreen({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final HomeRouter _homeRouter = sl();

  @override
  Widget build(BuildContext context) {
    final product = widget.argument.product;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {},
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60.h,
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ADD TO CART ",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: whiteColor,
                            ),
                      ),
                      Text(
                        "\$${product.price}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: whiteColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Start: Product Image
                  Stack(
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
                          height: 250.h,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _homeRouter.goBack();
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 16.w),
                          child: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                    ],
                  ),
                  //End: Product Image

                  //Start: Category
                  Container(
                    margin: EdgeInsets.only(left: 16.w, top: 20.h),
                    child: Text(
                      product.category,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: secondaryColor,
                          ),
                    ),
                  ),
                  //End: Category

                  //Start: Product Title
                  Container(
                    margin: EdgeInsets.only(left: 16.w, top: 10.h),
                    child: Text(
                      product.title,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  //End: Product Title

                  //Start: Product Rating
                  Container(
                    margin: EdgeInsets.only(left: 16.w, top: 10.h),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        RichText(
                          text: TextSpan(
                            text: product.rating.rate.toString(),
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                            children: [
                              TextSpan(
                                text: " / ${product.rating.count} reviews",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: secondaryColor,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //End: Product Rating

                  //Start: Product Description
                  Container(
                    margin: EdgeInsets.only(
                        left: 16.w, top: 15.h, right: 16.w, bottom: 80.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Info",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: secondaryColor,
                                  ),
                        ),
                        Text(
                          product.description,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: blackColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  //End: Product Description
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
