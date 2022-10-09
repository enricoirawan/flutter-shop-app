import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/common/failure.dart';

import '../../core/database/entity/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, List<Cart>>> getAllCarts();
  Future<Either<Failure, bool>> insertCart(Cart cart);
  Future<Either<Failure, bool>> updateCart(Cart cart);
  Future<Either<Failure, bool>> deleteCart(Cart cart);
}
