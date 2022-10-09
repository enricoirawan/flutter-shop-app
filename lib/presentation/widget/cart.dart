import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/core/database/entity/cart.dart';
import 'package:flutter_shop_app/presentation/bloc/cart_bloc/cart_cubit.dart';
import 'package:octo_image/octo_image.dart';

import '../../common/styles.dart';

class CartWidget extends StatelessWidget {
  final Cart cart;

  const CartWidget({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          SizedBox(
            width: 150.w,
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
              height: 150.h,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.productTitle,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Cart updatedCart = Cart(
                              id: cart.id,
                              productTitle: cart.productTitle,
                              price: cart.price,
                              amount: cart.amount - 1,
                              image: cart.image,
                            );

                            if (cart.amount == 1) {
                              context.read<CartCubit>().deleteCart(cart);
                            } else {
                              context.read<CartCubit>().updateCart(updatedCart);
                            }
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(cart.amount.toString()),
                        IconButton(
                          onPressed: () {
                            Cart updatedCart = Cart(
                              id: cart.id,
                              productTitle: cart.productTitle,
                              price: cart.price,
                              amount: cart.amount + 1,
                              image: cart.image,
                            );
                            context.read<CartCubit>().updateCart(updatedCart);
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<CartCubit>().deleteCart(cart);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
