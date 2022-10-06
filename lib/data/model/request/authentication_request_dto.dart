import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/domain/entity/request/authentication_request_entity.dart';

class AuthenticationRequestDto extends Equatable {
  final String username;
  final String password;

  const AuthenticationRequestDto({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };

  AuthenticationRequestEntity mapToEntity() {
    return AuthenticationRequestEntity(username: username, password: password);
  }

  @override
  List<Object?> get props => [username, password];
}
