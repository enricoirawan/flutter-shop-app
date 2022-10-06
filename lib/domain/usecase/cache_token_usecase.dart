import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/repository/authentication_repository.dart';

class CacheTokenUseCase extends UseCase<bool, String> {
  final AuthenticationRepository authenticationRepository;

  CacheTokenUseCase({required this.authenticationRepository});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await authenticationRepository.cacheToken(token: params);
  }
}
