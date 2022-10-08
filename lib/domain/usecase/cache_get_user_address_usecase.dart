import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/repository/address_repository.dart';

class CacheGetUserAddressUseCase extends UseCase<bool, NoParams> {
  final AddressRepository addressRepository;

  CacheGetUserAddressUseCase({required this.addressRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return addressRepository.cacheGetUserAddress();
  }
}
