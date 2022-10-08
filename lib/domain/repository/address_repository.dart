import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/common/failure.dart';

abstract class AddressRepository {
  Future<Either<Failure, String>> getUserPosition();
  Future<Either<Failure, String>> getUserAddress();
  Future<Either<Failure, bool>> saveUserAddress(String address);
  Future<Either<Failure, bool>> cacheGetUserAddress();
  Future<Either<Failure, bool>> getCacheUserAddressStatus();
}
