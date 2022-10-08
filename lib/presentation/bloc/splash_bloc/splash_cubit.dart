import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/common/constant.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/usecase/get_cache_user_address_status_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_token_use_case.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetTokenUseCase getTokenCase;
  final GetCacheUserAddressStatusUseCase getCacheUserAddressStatusUseCase;

  SplashCubit({
    required this.getTokenCase,
    required this.getCacheUserAddressStatusUseCase,
  }) : super(SplashState(splashState: ViewData.initial()));

  void initSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final isAuthenticate = await getTokenCase.call(const NoParams());

    isAuthenticate.fold((error) {
      emit(
        SplashState(
          splashState: ViewData.error(
            message: error.message,
            failure: error,
          ),
        ),
      );
    }, (result) async {
      if (result.isEmpty) {
        emit(SplashState(
          splashState: ViewData.noData(message: ""),
        ));
      } else {
        final cacheUserAddressStatus =
            await getCacheUserAddressStatusUseCase.call(
          const NoParams(),
        );

        cacheUserAddressStatus.fold((error) {
          emit(
            SplashState(
              splashState: ViewData.error(
                message: error.message,
                failure: error,
              ),
            ),
          );
        }, (result) {
          if (result) {
            emit(SplashState(
              splashState: ViewData.loaded(
                data: AppConstants.cachedKey.cacheGetUserAddressKey,
              ),
            ));
          } else {
            emit(SplashState(
              splashState: ViewData.loaded(
                data: AppConstants.cachedKey.tokenKey,
              ),
            ));
          }
        });
      }
    });
  }
}
