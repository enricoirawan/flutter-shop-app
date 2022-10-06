import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/common/constant.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/usecase/get_token_use_case.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetTokenUseCase getTokenCase;

  SplashCubit({
    required this.getTokenCase,
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
    }, (result) {
      if (result.isEmpty) {
        emit(SplashState(
          splashState: ViewData.noData(message: ""),
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
}
