import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/domain/entity/response/name_entity.dart';

class Name extends Equatable {
  final String firstname;
  final String lastname;

  const Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstname: json["firstname"],
        lastname: json["lastname"],
      );

  NameEntity mapToEntity() {
    return NameEntity(firstname: firstname, lastname: lastname);
  }

  @override
  List<Object?> get props => [
        firstname,
        lastname,
      ];
}
