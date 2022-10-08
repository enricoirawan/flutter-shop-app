import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/common/failure.dart';
import 'package:flutter_shop_app/domain/entity/response/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile(String userId);
}
