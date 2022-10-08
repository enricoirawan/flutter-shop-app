import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/entity/response/product_entity.dart';
import 'package:flutter_shop_app/domain/repository/product_repository.dart';

class GetAllProductsUseCase extends UseCase<List<ProductEntity>, String> {
  final ProductRepository productRepository;

  GetAllProductsUseCase({
    required this.productRepository,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> call(String params) {
    return productRepository.getAllProducts(params);
  }
}
