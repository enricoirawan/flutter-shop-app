import 'package:dio/dio.dart';
import 'package:flutter_shop_app/data/model/request/authentication_request_dto.dart';
import 'package:flutter_shop_app/data/model/response/authentication_response_dto.dart';

import '../../../common/constant.dart';

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource();

  Future<AuthenticationResponseDto> signIn({
    required AuthenticationRequestDto authenticationRequestDto,
  });
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Dio dio;

  AuthenticationRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthenticationResponseDto> signIn({
    required AuthenticationRequestDto authenticationRequestDto,
  }) async {
    try {
      final response = await dio.post(
        "${AppConstants.appApi.baseUrl}${AppConstants.appApi.signIn}",
        data: authenticationRequestDto.toJson(),
      );

      return AuthenticationResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
