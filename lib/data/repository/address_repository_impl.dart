import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/data/datasource/local/address_local_sources.dart';
import 'package:flutter_shop_app/data/datasource/remote/address_remote_datasouces.dart';
import 'package:flutter_shop_app/domain/repository/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSources addressRemoteDataSources;
  final AddressLocalDataSources addressLocalDataSources;

  AddressRepositoryImpl({
    required this.addressRemoteDataSources,
    required this.addressLocalDataSources,
  });

  @override
  Future<Either<Failure, String>> getUserAddress() async {
    try {
      final result = await addressLocalDataSources.getUserAddress();
      return Right(result);
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> getCacheUserAddressStatus() async {
    try {
      final result = await addressLocalDataSources.getCacheUserAddressStatus();
      return Right(result);
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getUserPosition() async {
    try {
      final result = await addressRemoteDataSources.getUserPosition();
      return Right(result);
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> cacheGetUserAddress() async {
    try {
      final result = await addressLocalDataSources.cacheGetUserAddress();
      return Right(result);
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserAddress(String address) async {
    try {
      final result = await addressLocalDataSources.saveUserAddress(address);
      return Right(result);
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }
}
