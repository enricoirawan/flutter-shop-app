import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';

import '../repository/authentication_repository.dart';

class GetTokenUseCase extends UseCase<String, NoParams> {
  final AuthenticationRepository authenticationRepository;

  GetTokenUseCase({required this.authenticationRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authenticationRepository.getToken();
  }
}
