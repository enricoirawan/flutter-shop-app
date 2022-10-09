import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/usecase/logout_usecase.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase logoutUseCase;

  LogoutCubit({
    required this.logoutUseCase,
  }) : super(LogoutState(logoutState: ViewData.initial()));

  void logout() async {
    final result = await logoutUseCase.call(const NoParams());

    result.fold(
      (error) {
        emit(
          LogoutState(
            logoutState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) {
        emit(
          LogoutState(
            logoutState: ViewData.loaded(data: result),
          ),
        );
      },
    );
  }
}
