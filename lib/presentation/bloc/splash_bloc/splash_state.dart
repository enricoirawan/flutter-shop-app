part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final ViewData splashState;

  const SplashState({
    required this.splashState,
  });

  SplashState copyWith({
    ViewData? splashState,
  }) {
    return SplashState(
      splashState: splashState ?? this.splashState,
    );
  }

  @override
  List<Object> get props => [splashState];
}
