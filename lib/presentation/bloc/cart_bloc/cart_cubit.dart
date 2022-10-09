import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/common/constant.dart';
import 'package:flutter_shop_app/core/database/entity/cart.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/usecase/delete_cart_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_all_carts_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/insert_cart_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/update_cart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetAllCartsUseCase getAllCartsUseCase;
  final InsertCartsUseCase insertCartsUseCase;
  final UpdateCartUseCase updateCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;

  CartCubit({
    required this.getAllCartsUseCase,
    required this.insertCartsUseCase,
    required this.updateCartUseCase,
    required this.deleteCartUseCase,
  }) : super(CartState(cartState: ViewData.initial()));

  void getAllCarts() async {
    emit(CartState(cartState: ViewData.loading()));

    final result = await getAllCartsUseCase.call(const NoParams());

    result.fold(
      (error) {
        emit(
          CartState(
            cartState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) {
        if (result.isEmpty) {
          emit(
            CartState(
              cartState: ViewData.noData(
                message: "Cart is empty, try to add one!",
              ),
            ),
          );
        } else {
          emit(
            CartState(
              cartState: ViewData.loaded(data: result),
            ),
          );
        }
      },
    );
  }

  void insertCart(Cart cart) async {
    emit(CartState(cartState: ViewData.loading()));

    final result = await insertCartsUseCase.call(cart);

    result.fold(
      (error) {
        emit(
          CartState(
            cartState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) {
        emit(
          CartState(
            cartState: ViewData.loaded(
              message: "Product has been added to cart",
            ),
          ),
        );
      },
    );
  }

  void updateCart(Cart cart) async {
    emit(CartState(cartState: ViewData.loading()));

    final result = await updateCartUseCase.call(cart);

    result.fold(
      (error) {
        emit(
          CartState(
            cartState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) async {
        final result = await getAllCartsUseCase.call(const NoParams());

        result.fold(
          (error) {
            emit(
              CartState(
                cartState: ViewData.error(
                  message: error.message,
                  failure: error,
                ),
              ),
            );
          },
          (result) {
            emit(
              CartState(
                cartState: ViewData.loaded(data: result),
              ),
            );
          },
        );
      },
    );
  }

  void deleteCart(Cart cart) async {
    emit(CartState(cartState: ViewData.loading()));

    final result = await deleteCartUseCase.call(cart);

    result.fold(
      (error) {
        emit(
          CartState(
            cartState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) async {
        final result = await getAllCartsUseCase.call(const NoParams());

        result.fold(
          (error) {
            emit(
              CartState(
                cartState: ViewData.error(
                  message: error.message,
                  failure: error,
                ),
              ),
            );
          },
          (result) {
            if (result.isEmpty) {
              emit(
                CartState(
                  cartState: ViewData.noData(
                    message: "Cart is empty, try to add one!",
                  ),
                ),
              );
            } else {
              emit(
                CartState(
                  cartState: ViewData.loaded(
                    data: result,
                    message: AppConstants.successMessage.successDeletedProduct,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
