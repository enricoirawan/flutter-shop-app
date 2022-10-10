import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/navigation/argument/detail_product_argument.dart';
import 'package:flutter_shop_app/common/navigation/router/home_route.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/core/database/entity/cart.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/presentation/bloc/cart_bloc/cart_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/product_detail/product_detail_cubit.dart';
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
  void initState() {
    super.initState();
    context
        .read<ProductDetailCubit>()
        .getProductDetail(widget.argument.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        final status = state.cartState.status;

        if (status.isHasData) {
          AnimatedSnackBar.material(
            state.cartState.message,
            type: AnimatedSnackBarType.success,
          ).show(context);
        } else if (status.isError) {
          AnimatedSnackBar.material(
            state.cartState.message,
            type: AnimatedSnackBarType.error,
          ).show(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
              final status = state.productDetailState.status;

              if (status.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (status.isHasData) {
                final product = state.productDetailState.data!;

                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Cart cart = Cart(
                          id: product.id,
                          productTitle: product.title,
                          price: product.price,
                          amount: 1,
                          image: product.image,
                        );
                        context.read<CartCubit>().insertCart(cart);
                      },
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: whiteColor,
                                    ),
                              ),
                              Text(
                                "\$${product.price}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                    children: [
                                      TextSpan(
                                        text:
                                            " / ${product.rating.count} reviews",
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
                                left: 16.w,
                                top: 15.h,
                                right: 16.w,
                                bottom: 80.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product Info",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: secondaryColor,
                                      ),
                                ),
                                Text(
                                  product.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
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
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
