import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/database/entity/cart.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/repository/cart_repository.dart';

class DeleteCartUseCase extends UseCase<bool, Cart> {
  final CartRepository cartRepository;

  DeleteCartUseCase({
    required this.cartRepository,
  });

  @override
  Future<Either<Failure, bool>> call(Cart params) {
    return cartRepository.deleteCart(params);
  }
}
