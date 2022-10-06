part of 'signin_cubit.dart';

class SignInState extends Equatable {
  final ViewData signIn;

  const SignInState({
    required this.signIn,
  });

  SignInState copyWith({
    ViewData? signIn,
  }) {
    return SignInState(
      signIn: signIn ?? this.signIn,
    );
  }

  @override
  List<Object> get props => [signIn];
}
