import 'package:flutter_shop_app/core/database/database.dart';
import 'package:flutter_shop_app/core/database/entity/cart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../common/constant.dart';
import '../../../common/failure.dart';

abstract class CartLocalDataSources {
  Future<List<Cart>> getAllCarts();
  Future<bool> insertCart(Cart cart);
  Future<bool> updateCart(Cart cart);
  Future<bool> deleteCart(Cart cart);
  Future<bool> clearCart();
}

class CartLocalDataSourcesImpl implements CartLocalDataSources {
  final AppDatabase appDatabase;

  CartLocalDataSourcesImpl({
    required this.appDatabase,
  });

  @override
  Future<List<Cart>> getAllCarts() async {
    try {
      final result = await appDatabase.cartDao.getAllCarts();
      return result;
    } on DatabaseException catch (_) {
      throw DatabaseFailure(AppConstants.errorMessage.failedGetCarts);
    }
  }

  @override
  Future<bool> insertCart(Cart cart) async {
    try {
      final result = await appDatabase.cartDao.insertCart(cart);
      return result > 0 ? true : false;
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        throw DatabaseFailure(
          AppConstants.errorMessage.productAlredyExistOnTheCart,
        );
      } else {
        throw DatabaseFailure(AppConstants.errorMessage.failedInsertCart);
      }
    }
  }

  @override
  Future<bool> updateCart(Cart cart) async {
    try {
      final result = await appDatabase.cartDao.updateCart(cart);
      return result > 0 ? true : false;
    } on DatabaseException catch (_) {
      throw DatabaseFailure(AppConstants.errorMessage.failedUpdateCart);
    }
  }

  @override
  Future<bool> deleteCart(Cart cart) async {
    try {
      final result = await appDatabase.cartDao.deleteCart(cart);
      return result > 0 ? true : false;
    } on DatabaseException catch (_) {
      throw DatabaseFailure(AppConstants.errorMessage.failedDeleteCart);
    }
  }

  @override
  Future<bool> clearCart() async {
    try {
      final result = await appDatabase.cartDao.clearCarts();
      return result == null ? false : true;
    } on DatabaseException catch (_) {
      throw DatabaseFailure(AppConstants.errorMessage.failedDeleteCart);
    }
  }
}
