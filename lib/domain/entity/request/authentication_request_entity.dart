import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/data/model/request/authentication_request_dto.dart';

class AuthenticationRequestEntity extends Equatable {
  final String username;
  final String password;

  const AuthenticationRequestEntity({
    required this.username,
    required this.password,
  });

  AuthenticationRequestDto mapperToDTO() {
    return AuthenticationRequestDto(
      username: username,
      password: password,
    );
  }

  @override
  List<Object?> get props => [username, password];
}
