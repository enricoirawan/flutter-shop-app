import 'package:dio/dio.dart';
import 'package:flutter_shop_app/data/datasource/remote/profile_remote_datasource.dart';
import 'package:flutter_shop_app/domain/entity/response/profile_entity.dart';
import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSources profileRemoteDataSources;

  ProfileRepositoryImpl({
    required this.profileRemoteDataSources,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getProfile(String userId) async {
    try {
      final response = await profileRemoteDataSources.getProfile(userId);
      return Right(response.mapToEntity());
    } on DioError catch (error) {
      return Left(ServerFailure(error.response.toString()));
    }
  }
}
