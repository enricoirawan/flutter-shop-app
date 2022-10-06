import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/presentation/widget/logo.dart';

import '../../common/get_it.dart';
import '../../common/navigation/router/auth_route.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  void _goToSignIn() async {
    final AuthRouter authRouter = sl();
    authRouter.navigateToSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Column(
                children: [
                  Text(
                    "Start your journey",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: whiteColor, fontSize: 30.sp),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "with",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: whiteColor,
                              fontSize: 30.sp,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      LogoWidget(
                        fontSize: 30.sp,
                        color: whiteColor,
                        isFontbold: false,
                      )
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: 45.h,
                        onPressed: () {},
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Sign Up",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: whiteColor,
                                    fontSize: 16.sp,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: MaterialButton(
                        height: 45.h,
                        onPressed: _goToSignIn,
                        color: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Sign In",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: primaryColor,
                                    fontSize: 16.sp,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
