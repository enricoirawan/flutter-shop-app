import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/database/entity/cart.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/repository/cart_repository.dart';

class GetAllCartsUseCase extends UseCase<List<Cart>, NoParams> {
  final CartRepository cartRepository;

  GetAllCartsUseCase({
    required this.cartRepository,
  });

  @override
  Future<Either<Failure, List<Cart>>> call(NoParams params) {
    return cartRepository.getAllCarts();
  }
}
