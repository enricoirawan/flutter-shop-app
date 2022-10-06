import 'package:equatable/equatable.dart';
import '../../../domain/entity/response/authentication_response_entity.dart';

class AuthenticationResponseDto extends Equatable {
  final String token;

  const AuthenticationResponseDto({
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }

  factory AuthenticationResponseDto.fromJson(Map<String, dynamic> map) {
    return AuthenticationResponseDto(
      token: map['token'] ?? '',
    );
  }

  AuthenticationResponseEntity mapToEntity() {
    return AuthenticationResponseEntity(token: token);
  }

  @override
  List<Object> get props => [token];
}
