import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/domain/entity/request/authentication_request_entity.dart';
import 'package:flutter_shop_app/presentation/bloc/signin_bloc/signin_cubit.dart';
import 'package:flutter_shop_app/presentation/widget/logo.dart';

import '../../common/constant.dart';
import '../../common/get_it.dart';
import '../../common/navigation/router/auth_route.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthRouter _authRouter = sl();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        final status = state.signIn.status;

        if (status.isError) {
          AnimatedSnackBar.material(
            state.signIn.message,
            type: AnimatedSnackBarType.error,
          ).show(context);
        } else if (status.isHasData) {
          if (state.signIn.data ==
              AppConstants.cachedKey.cacheGetUserAddressKey) {
            _authRouter.navigateToHome();
          } else {
            _authRouter.navigateToGetUserPosition();
          }
        }
      },
      builder: (context, state) {
        final status = state.signIn.status;

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                LogoWidget(
                  fontSize: 35.sp,
                  color: blackColor,
                  isFontbold: true,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Text(
                        "Welcome to",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.sp,
                            ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      LogoWidget(
                        fontSize: 30.sp,
                        color: blackColor,
                        isFontbold: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Please enter your address below to start using app",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: grayColor,
                        ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                          enabled: !status.isLoading,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Username",
                            prefixIcon: const Icon(Icons.account_circle),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          enabled: !status.isLoading,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  height: 40.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: MaterialButton(
                    onPressed: () {
                      if (_signInFormKey.currentState!.validate()) {
                        context.read<SignInCubit>().signIn(
                              AuthenticationRequestEntity(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: status.isLoading
                        ? const CircularProgressIndicator(
                            color: whiteColor,
                            strokeWidth: 2,
                          )
                        : Text(
                            "Sign In",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: whiteColor,
                                    ),
                          ),
                  ),
                ),
                const Spacer(),
                const Divider(),
                Text(
                  "Or sign in with",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          height: 40.h,
                          onPressed: () {
                            AnimatedSnackBar.material(
                              AppConstants.errorMessage.loginWithFacebook,
                              type: AnimatedSnackBarType.warning,
                            ).show(context);
                          },
                          color: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/facebook-icon.png",
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                "Facebook",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: whiteColor,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: MaterialButton(
                          height: 40.h,
                          onPressed: () {
                            AnimatedSnackBar.material(
                              AppConstants.errorMessage.loginWithGoogle,
                              type: AnimatedSnackBarType.warning,
                            ).show(context);
                          },
                          color: whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/google-icon.png",
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                "Google",
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
