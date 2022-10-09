part of 'cart_cubit.dart';

class CartState extends Equatable {
  final ViewData<List<Cart>> cartState;

  const CartState({required this.cartState});

  CartState copyWith({
    ViewData<List<Cart>>? cartState,
  }) {
    return CartState(
      cartState: cartState ?? this.cartState,
    );
  }

  @override
  List<Object> get props => [cartState];
}
