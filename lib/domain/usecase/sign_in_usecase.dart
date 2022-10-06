import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/entity/request/authentication_request_entity.dart';
import 'package:flutter_shop_app/domain/entity/response/authentication_response_entity.dart';

import '../repository/authentication_repository.dart';

class SignInUseCase
    extends UseCase<AuthenticationResponseEntity, AuthenticationRequestEntity> {
  final AuthenticationRepository authenticationRepository;

  SignInUseCase({required this.authenticationRepository});

  @override
  Future<Either<Failure, AuthenticationResponseEntity>> call(
      AuthenticationRequestEntity params) async {
    return await authenticationRepository.signIn(
      authenticationRequestEntity: params,
    );
  }
}
