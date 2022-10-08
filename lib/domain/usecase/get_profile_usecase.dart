import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/entity/response/profile_entity.dart';
import 'package:flutter_shop_app/domain/repository/profile_repository.dart';

class GetProfileUseCase extends UseCase<ProfileEntity, String> {
  final ProfileRepository profileRepository;

  GetProfileUseCase({
    required this.profileRepository,
  });

  @override
  Future<Either<Failure, ProfileEntity>> call(String params) {
    return profileRepository.getProfile(params);
  }
}
