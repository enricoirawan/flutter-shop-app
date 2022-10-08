part of 'address_cubit.dart';

class AddressState extends Equatable {
  final ViewData addressState;

  const AddressState({required this.addressState});

  AddressState copyWith({
    ViewData? addressState,
  }) {
    return AddressState(
      addressState: addressState ?? this.addressState,
    );
  }

  @override
  List<Object> get props => [addressState];
}
