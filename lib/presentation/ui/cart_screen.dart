import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/navigation/argument/checkout_argument.dart';
import 'package:flutter_shop_app/common/navigation/router/checkout_route.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/presentation/bloc/cart_bloc/cart_cubit.dart';
import 'package:flutter_shop_app/presentation/widget/cart.dart';
import 'package:lottie/lottie.dart';

import '../../common/constant.dart';
import '../../common/get_it.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CheckoutRouter _checkoutRouter = sl();
  double shippingCost = 10;

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getAllCarts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        final status = state.cartState.status;

        if (status.isHasData &&
            state.cartState.message ==
                AppConstants.successMessage.successDeletedProduct) {
          AnimatedSnackBar.material(
            state.cartState.message,
            type: AnimatedSnackBarType.success,
          ).show(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "My Cart",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 350.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      final status = state.cartState.status;
                      final carts = state.cartState.data ?? [];

                      if (status.isLoading) {
                        return const CircularProgressIndicator();
                      } else if (status.isHasData) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final cart = carts[index];

                            return CartWidget(cart: cart);
                          },
                          itemCount: carts.length,
                        );
                      } else if (status.isNoData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LottieBuilder.asset(
                              "assets/cart_empty.json",
                              height: 200.h,
                              width: double.infinity,
                            ),
                            Text(
                              state.cartState.message,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final status = state.cartState.status;
                    final carts = state.cartState.data ?? [];

                    if (status.isHasData) {
                      final subTotal = carts.fold<double>(
                          0, (sum, item) => sum + (item.price * item.amount));

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: grayColor,
                                      ),
                                ),
                                Text(
                                  "\$$subTotal",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Shipping",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: grayColor,
                                      ),
                                ),
                                Text(
                                  "\$$shippingCost",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }

                    return Container();
                  },
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final status = state.cartState.status;

                    if (status.isHasData) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 15.h),
                        child: const DottedLine(
                          dashColor: grayColor,
                        ),
                      );
                    }

                    return Container();
                  },
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final status = state.cartState.status;
                    final carts = state.cartState.data ?? [];

                    final total = carts.fold<double>(0,
                        (sum, item) => (sum + (item.price * item.amount)) + 10);

                    if (status.isHasData) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: grayColor,
                                  ),
                            ),
                            Text(
                              "\$$total",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Container();
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final status = state.cartState.status;
                    final carts = state.cartState.data ?? [];

                    final total = carts.fold<double>(0,
                        (sum, item) => (sum + (item.price * item.amount)) + 10);

                    if (status.isHasData) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        child: MaterialButton(
                          onPressed: () {
                            CheckoutArgument checkoutArgument =
                                CheckoutArgument(
                              total: total,
                              carts: carts,
                            );
                            _checkoutRouter
                                .navigateToCheckout(checkoutArgument);
                          },
                          color: primaryColor,
                          minWidth: double.infinity,
                          height: 40.h,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Checkout",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: whiteColor,
                                    ),
                          ),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
