import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/entity/response/profile_entity.dart';
import 'package:flutter_shop_app/domain/usecase/get_profile_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_user_id_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final GetUserIdUseCase getUserIdCase;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.getUserIdCase,
  }) : super(
          ProfileState(
            profileState: ViewData.initial(),
          ),
        );

  void getProfile() async {
    emit(ProfileState(profileState: ViewData.loading()));

    final userIdResult = await getUserIdCase.call(const NoParams());

    userIdResult.fold((error) {
      emit(
        ProfileState(
          profileState: ViewData.error(
            message: error.message,
            failure: error,
          ),
        ),
      );
    }, (userId) async {
      final response = await getProfileUseCase.call(userId);

      response.fold(
        (error) {
          emit(
            ProfileState(
              profileState: ViewData.error(
                message: error.message,
                failure: error,
              ),
            ),
          );
        },
        (result) {
          emit(
            ProfileState(
              profileState: ViewData.loaded(data: result),
            ),
          );
        },
      );
    });
  }
}
