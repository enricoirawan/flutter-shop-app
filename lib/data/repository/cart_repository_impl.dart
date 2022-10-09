import 'package:flutter_shop_app/core/database/entity/cart.dart';
import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/data/datasource/local/cart_local_datasource.dart';
import 'package:flutter_shop_app/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSources cartLocalDataSources;

  CartRepositoryImpl({required this.cartLocalDataSources});

  @override
  Future<Either<Failure, List<Cart>>> getAllCarts() async {
    try {
      final result = await cartLocalDataSources.getAllCarts();
      return Right(result);
    } on DatabaseFailure catch (error) {
      return Left(DatabaseFailure(error.message));
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> insertCart(Cart cart) async {
    try {
      final result = await cartLocalDataSources.insertCart(cart);
      return Right(result);
    } on DatabaseFailure catch (error) {
      return Left(DatabaseFailure(error.message));
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateCart(Cart cart) async {
    try {
      final result = await cartLocalDataSources.updateCart(cart);
      return Right(result);
    } on DatabaseFailure catch (error) {
      return Left(DatabaseFailure(error.message));
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCart(Cart cart) async {
    try {
      final result = await cartLocalDataSources.deleteCart(cart);
      return Right(result);
    } on DatabaseFailure catch (error) {
      return Left(DatabaseFailure(error.message));
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }
}
