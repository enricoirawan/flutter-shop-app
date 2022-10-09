import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/repository/authentication_repository.dart';

class LogoutUseCase extends UseCase<bool, NoParams> {
  final AuthenticationRepository authenticationRepository;

  LogoutUseCase({
    required this.authenticationRepository,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return authenticationRepository.logout();
  }
}
