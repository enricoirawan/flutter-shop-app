import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/core/database/entity/cart.dart';

class CheckoutArgument extends Equatable {
  final double total;
  final List<Cart> carts;

  const CheckoutArgument({
    required this.total,
    required this.carts,
  });

  @override
  List<Object?> get props => [total, carts];
}
