import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/common/failure.dart';
import 'package:flutter_shop_app/domain/entity/response/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<dynamic>>> getAllCategories();
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
}
