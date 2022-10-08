import 'package:equatable/equatable.dart';

class NameEntity extends Equatable {
  final String firstname;
  final String lastname;

  const NameEntity({
    required this.firstname,
    required this.lastname,
  });

  @override
  List<Object?> get props => [firstname, lastname];
}
