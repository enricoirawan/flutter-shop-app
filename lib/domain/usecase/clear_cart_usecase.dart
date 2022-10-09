import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/repository/cart_repository.dart';

class ClearCartUseCase extends UseCase<bool, NoParams> {
  final CartRepository cartRepository;

  ClearCartUseCase({required this.cartRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return cartRepository.clearCart();
  }
}
