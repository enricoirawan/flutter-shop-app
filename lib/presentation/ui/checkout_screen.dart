import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/navigation/argument/checkout_argument.dart';
import 'package:flutter_shop_app/common/navigation/router/checkout_route.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/core/database/entity/transaction_data.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/presentation/bloc/address_bloc/address_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/transaction/transaction_cubit.dart';
import 'package:octo_image/octo_image.dart';
import 'package:uuid/uuid.dart';

import '../../common/get_it.dart';
import '../../core/database/entity/cart.dart';

class PaymentMethod {
  final String name;
  final String image;
  final String accountNumber;

  PaymentMethod({
    required this.name,
    required this.image,
    required this.accountNumber,
  });
}

class CheckoutScreen extends StatefulWidget {
  final CheckoutArgument checkoutArgument;

  const CheckoutScreen({
    Key? key,
    required this.checkoutArgument,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CheckoutRouter _checkoutRouter = sl();
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      name: "Apple Pay",
      image: "assets/apple-pay.png",
      accountNumber: "xxxx xxxx 0357 8420",
    ),
    PaymentMethod(
      name: "Masted Card",
      image: "assets/mastercard.png",
      accountNumber: "xxxx xxxx 0894 1235",
    ),
    PaymentMethod(
      name: "Visa",
      image: "assets/visa.png",
      accountNumber: "xxxx xxxx 7621 5231",
    ),
  ];

  int selectedPaymentMethod = 0;

  Widget _paymentWidget(int index, PaymentMethod payment) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: secondaryColor.withOpacity(0.7),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              payment.image,
              height: 85.h,
              width: 85.w,
            ),
            SizedBox(
              width: 13.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                ),
                Text(
                  payment.accountNumber,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 13.sp,
                      ),
                ),
              ],
            ),
            selectedPaymentMethod == index
                ? Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: const Icon(
                      Icons.check,
                      color: primaryColor,
                    ),
                  )
                : const Spacer()
          ],
        ),
      ),
    );
  }

  Widget _cartWidget(Cart cart) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: OctoImage(
            image: CachedNetworkImageProvider(
              cart.image,
            ),
            placeholderBuilder: OctoPlaceholder.blurHash(
              'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
            ),
            errorBuilder: OctoError.icon(
              color: Colors.red,
            ),
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150.w,
              child: Text(
                cart.productTitle,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "\$${cart.price}",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "${cart.amount} Qty",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionCubit, TransactionState>(
      listener: (context, state) {
        final status = state.transactionState.status;

        if (status.isHasData) {
          _checkoutRouter.navigateToSuccessPayment();
        } else if (status.isError) {
          AnimatedSnackBar.material(
            state.transactionState.message,
            type: AnimatedSnackBarType.error,
          ).show(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Start: Header
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          _checkoutRouter.goBack();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      Text(
                        "Checkout",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                //End: Header

                //Start: Delivery Address
                Container(
                  margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Address",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      BlocBuilder<AddressCubit, AddressState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.location_pin,
                                  color: whiteColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Text(
                                  state.addressState.data,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                //End: Delivery Address

                //Start: Payment Methods
                Container(
                  height: 250.h,
                  margin:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Methods",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final PaymentMethod payment = paymentMethods[index];

                            return _paymentWidget(index, payment);
                          },
                          itemCount: paymentMethods.length,
                        ),
                      ),
                    ],
                  ),
                ),
                //End: Payment Methods

                //Start: Carts
                Container(
                  height: 200.h,
                  margin: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Carts",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            Cart cart = widget.checkoutArgument.carts[index];

                            return _cartWidget(cart);
                          },
                          itemCount: widget.checkoutArgument.carts.length,
                        ),
                      ),
                    ],
                  ),
                ),
                //End: Carts

                //Start: Total
                Container(
                  margin: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 10.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: grayColor,
                            ),
                      ),
                      Text(
                        "\$${widget.checkoutArgument.total}",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),
                //End: Total

                //Start: Button Pay Now
                Container(
                  margin: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 50.h,
                    top: 10.h,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      const uuid = Uuid();
                      List<Cart> carts = widget.checkoutArgument.carts;

                      TransactionData transaction = TransactionData(
                        id: uuid.v1(),
                        total: widget.checkoutArgument.total,
                        purcashedProductTitle: carts
                            .map((cart) => cart.productTitle)
                            .toList()
                            .join(","),
                      );
                      context
                          .read<TransactionCubit>()
                          .insertTransaction(transaction);
                    },
                    color: primaryColor,
                    minWidth: double.infinity,
                    height: 40.h,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Pay Now",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: whiteColor,
                          ),
                    ),
                  ),
                ),
                //End: Button Pay Now
              ],
            ),
          ),
        ),
      ),
    );
  }
}
