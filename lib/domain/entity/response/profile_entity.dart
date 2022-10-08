import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/domain/entity/response/name_entity.dart';

class ProfileEntity extends Equatable {
  final String email;
  final String username;
  final NameEntity name;
  final String phone;

  const ProfileEntity({
    required this.email,
    required this.username,
    required this.name,
    required this.phone,
  });

  @override
  List<Object?> get props => [];
}
