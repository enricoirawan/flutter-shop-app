part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final ViewData<ProfileEntity> profileState;

  const ProfileState({required this.profileState});

  ProfileState copyWith({
    ViewData<ProfileEntity>? profileState,
  }) {
    return ProfileState(
      profileState: profileState ?? this.profileState,
    );
  }

  @override
  List<Object> get props => [profileState];
}
