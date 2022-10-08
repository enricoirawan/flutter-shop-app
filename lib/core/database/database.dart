import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:flutter_shop_app/core/database/dao/cart_dao.dart';
import 'package:flutter_shop_app/core/database/entity/cart.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Cart])
abstract class AppDatabase extends FloorDatabase {
  CartDao get cartDao;
}
