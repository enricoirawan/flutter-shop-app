import 'package:floor/floor.dart';

import '../entity/cart.dart';

@dao
abstract class CartDao {
  @Query('SELECT * FROM Cart')
  Future<List<Cart>> getAllCarts();

  @Query('DELETE FROM Cart')
  Future<bool?> clearCarts();

  @insert
  Future<int> insertCart(Cart cart);

  @update
  Future<int> updateCart(Cart cart);

  @delete
  Future<int> deleteCart(Cart cart);
}
