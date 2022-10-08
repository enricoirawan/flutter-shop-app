import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/repository/product_repository.dart';

class GetAllCategoriesUseCase extends UseCase<List<dynamic>, NoParams> {
  final ProductRepository productRepository;

  GetAllCategoriesUseCase({required this.productRepository});

  @override
  Future<Either<Failure, List<dynamic>>> call(NoParams params) {
    return productRepository.getAllCategories();
  }
}
