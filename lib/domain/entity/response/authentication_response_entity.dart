import 'package:equatable/equatable.dart';

class AuthenticationResponseEntity extends Equatable {
  final String token;

  const AuthenticationResponseEntity({
    required this.token,
  });

  @override
  List<Object?> get props => [token];
}
