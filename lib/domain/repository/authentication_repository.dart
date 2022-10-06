import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/common/failure.dart';
import 'package:flutter_shop_app/domain/entity/request/authentication_request_entity.dart';
import 'package:flutter_shop_app/domain/entity/response/authentication_response_entity.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<Either<Failure, bool>> cacheToken({required String token});
  Future<Either<Failure, bool>> cacheUserId({required String userId});
  Future<Either<Failure, String>> getUserId();
  Future<Either<Failure, String>> getToken();
  Future<Either<Failure, AuthenticationResponseEntity>> signIn({
    required AuthenticationRequestEntity authenticationRequestEntity,
  });
}
