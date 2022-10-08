import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/data/model/response/name_response_dto.dart';
import 'package:flutter_shop_app/domain/entity/response/profile_entity.dart';

class ProfileResponseDTO extends Equatable {
  final String email;
  final String username;
  final Name name;
  final String phone;

  const ProfileResponseDTO({
    required this.email,
    required this.username,
    required this.name,
    required this.phone,
  });

  factory ProfileResponseDTO.fromJson(Map<String, dynamic> json) =>
      ProfileResponseDTO(
        email: json["email"],
        username: json["username"],
        name: Name.fromJson(json["name"]),
        phone: json["phone"],
      );

  ProfileEntity mapToEntity() {
    return ProfileEntity(
      email: email,
      username: username,
      name: name.mapToEntity(),
      phone: phone,
    );
  }

  @override
  List<Object?> get props => [
        email,
        username,
        name,
        phone,
      ];
}
