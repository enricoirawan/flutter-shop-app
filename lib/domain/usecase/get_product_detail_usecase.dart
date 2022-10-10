import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/entity/response/product_entity.dart';
import 'package:flutter_shop_app/domain/repository/product_repository.dart';

class GetProductDetailUseCase extends UseCase<ProductEntity, int> {
  final ProductRepository productRepository;

  GetProductDetailUseCase({required this.productRepository});

  @override
  Future<Either<Failure, ProductEntity>> call(int params) {
    return productRepository.getProductDetail(params);
  }
}
