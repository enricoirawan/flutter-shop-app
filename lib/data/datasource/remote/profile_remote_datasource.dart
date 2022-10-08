import 'package:dio/dio.dart';
import 'package:flutter_shop_app/data/model/response/profile_response_dto.dart';

import '../../../common/constant.dart';

abstract class ProfileRemoteDataSources {
  Future<ProfileResponseDTO> getProfile(String userId);
}

class ProfileRemoteDataSourcesImpl implements ProfileRemoteDataSources {
  final Dio dio;

  ProfileRemoteDataSourcesImpl({
    required this.dio,
  });

  @override
  Future<ProfileResponseDTO> getProfile(String userId) async {
    try {
      final response = await dio.get(
        "${AppConstants.appApi.baseUrl}${AppConstants.appApi.profile}$userId",
      );

      return ProfileResponseDTO.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
