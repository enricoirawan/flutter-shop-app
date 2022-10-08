import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/repository/address_repository.dart';

class GetUserPositionUseCase extends UseCase<String, NoParams> {
  final AddressRepository addressRepository;

  GetUserPositionUseCase({required this.addressRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return addressRepository.getUserPosition();
  }
}
