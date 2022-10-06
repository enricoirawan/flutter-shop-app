import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/data/datasource/local/authentication_local_datasources.dart';
import 'package:flutter_shop_app/data/datasource/remote/authentication_in_remote_datasources.dart';
import 'package:flutter_shop_app/domain/entity/request/authentication_request_entity.dart';
import 'package:flutter_shop_app/domain/entity/response/authentication_response_entity.dart';
import 'package:flutter_shop_app/common/failure.dart';
import 'package:flutter_shop_app/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;

  AuthenticationRepositoryImpl({
    required this.authenticationLocalDataSource,
    required this.authenticationRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> cacheToken({required String token}) async {
    try {
      await authenticationLocalDataSource.cacheToken(token: token);
      return const Right(true);
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> cacheUserId({required String userId}) async {
    try {
      await authenticationLocalDataSource.cacheUserId(userId: userId);
      return const Right(true);
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getUserId() async {
    try {
      String userId = await authenticationLocalDataSource.getUserId();
      return Right(userId);
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      String token = await authenticationLocalDataSource.getToken();
      return Right(token);
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthenticationResponseEntity>> signIn({
    required AuthenticationRequestEntity authenticationRequestEntity,
  }) async {
    try {
      final response = await authenticationRemoteDataSource.signIn(
        authenticationRequestDto: authenticationRequestEntity.mapperToDTO(),
      );
      return Right(response.mapToEntity());
    } on DioError catch (error) {
      return Left(ServerFailure(error.response.toString()));
    }
  }
}
