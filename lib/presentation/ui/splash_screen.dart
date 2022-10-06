import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/presentation/bloc/splash_bloc/splash_cubit.dart';
import 'package:flutter_shop_app/presentation/widget/logo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/get_it.dart';
import '../../common/navigation/router/auth_route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthRouter authRouter = sl();

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        final status = state.splashState.status;

        if (status.isHasData) {
          authRouter.navigateToHome();
        } else if (status.isNoData) {
          authRouter.navigateToOnboard();
        }
      },
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: SafeArea(
          child: Center(
            child: LogoWidget(
              fontSize: 70.sp,
              color: whiteColor,
              isFontbold: true,
            ),
          ),
        ),
      ),
    );
  }
}
