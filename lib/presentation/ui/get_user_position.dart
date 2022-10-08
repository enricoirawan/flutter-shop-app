import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/constant.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/presentation/bloc/address_bloc/address_cubit.dart';
import 'package:lottie/lottie.dart';

import '../../common/get_it.dart';
import '../../common/navigation/router/auth_route.dart';

class GetUserPositionScreen extends StatelessWidget {
  const GetUserPositionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthRouter authRouter = sl();

    context.read<AddressCubit>().getUserPosition();

    return BlocListener<AddressCubit, AddressState>(
      listener: (context, state) {
        final status = state.addressState.status;

        if (status.isHasData) {
          if (state.addressState.data ==
              AppConstants.cachedKey.cacheGetUserAddressKey) {
            AnimatedSnackBar.material(
              AppConstants.successMessage.saveAddressSuccess,
              type: AnimatedSnackBarType.success,
            ).show(context);
            Future.delayed(const Duration(seconds: 2), () {
              authRouter.navigateToHome();
            });
          }
        } else if (status.isError) {
          AnimatedSnackBar.material(
            state.addressState.message,
            type: AnimatedSnackBarType.error,
          ).show(context);
          Future.delayed(const Duration(seconds: 2), () {
            authRouter.navigateToSplash();
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Lottie.asset(
                "assets/map_lottie.json",
                height: 200.h,
                alignment: Alignment.center,
              ),
              Text(
                "Access Location",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "This app will access your location only while using the app, please allow the permission.",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.h,
              ),
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 15.h,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
