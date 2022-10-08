import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/common/constant.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/entity/request/authentication_request_entity.dart';
import 'package:flutter_shop_app/domain/usecase/cache_token_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/cache_user_id_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_cache_user_address_status_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/sign_in_usecase.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  final CacheTokenUseCase cacheTokenUseCase;
  final CacheUserIdUseCase cacheUserIdUseCase;
  final GetCacheUserAddressStatusUseCase getCacheUserAddressStatusUseCase;

  SignInCubit({
    required this.signInUseCase,
    required this.cacheTokenUseCase,
    required this.cacheUserIdUseCase,
    required this.getCacheUserAddressStatusUseCase,
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

        final cacheUserAddressStatus =
            await getCacheUserAddressStatusUseCase.call(const NoParams());

        cacheUserAddressStatus.fold(
          (error) {
            emit(
              SignInState(
                signIn: ViewData.error(
                  message: error.message,
                  failure: error,
                ),
              ),
            );
          },
          (result) {
            if (result) {
              emit(
                SignInState(
                  signIn: ViewData.loaded(
                    data: AppConstants.cachedKey.cacheGetUserAddressKey,
                  ),
                ),
              );
            } else {
              emit(SignInState(signIn: ViewData.loaded()));
            }
          },
        );
      },
    );
  }
}
