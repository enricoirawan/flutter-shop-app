import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/domain/entity/request/authentication_request_entity.dart';
import 'package:flutter_shop_app/domain/usecase/cache_token_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/cache_user_id_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/sign_in_usecase.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  final CacheTokenUseCase cacheTokenUseCase;
  final CacheUserIdUseCase cacheUserIdUseCase;

  SignInCubit({
    required this.signInUseCase,
    required this.cacheTokenUseCase,
    required this.cacheUserIdUseCase,
  }) : super(SignInState(signIn: ViewData.initial()));

  void signIn(AuthenticationRequestEntity authenticationRequestEntity) async {
    emit(SignInState(signIn: ViewData.loading()));
    final result = await signInUseCase.call(authenticationRequestEntity);

    result.fold(
      (failure) {
        emit(
          SignInState(
            signIn: ViewData.error(message: failure.message, failure: failure),
          ),
        );
      },
      (result) async {
        await cacheTokenUseCase.call(result.token);
        await cacheUserIdUseCase.call("8"); // hard code
        emit(SignInState(signIn: ViewData.loaded()));
      },
    );
  }
}
