import 'package:dio/dio.dart';
import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/data/datasource/remote/product_remote_datasources.dart';
import 'package:flutter_shop_app/domain/entity/response/product_entity.dart';
import 'package:flutter_shop_app/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSources productRemoteDataSources;

  ProductRepositoryImpl({required this.productRemoteDataSources});

  @override
  Future<Either<Failure, List<dynamic>>> getAllCategories() async {
    try {
      final response = await productRemoteDataSources.getAllCategories();
      return Right(response);
    } on DioError catch (error) {
      return Left(ServerFailure(error.response.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(
      String category) async {
    try {
      final response = await productRemoteDataSources.getAllProducts(category);

      List<ProductEntity> products = [];

      for (var element in response) {
        products.add(element.mapToEntity());
      }

      return Right(products);
    } on DioError catch (error) {
      return Left(ServerFailure(error.response.toString()));
    }
  }
}
