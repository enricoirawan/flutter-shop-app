import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/navigation/router/auth_route.dart';
import 'package:flutter_shop_app/common/navigation/router/profile_route.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/presentation/bloc/logout_bloc/logout_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/profile_bloc/profile_cubit.dart';

import '../../common/get_it.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthRouter authRouter = sl();
    final ProfileRouter profileRouter = sl();

    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        final status = state.logoutState.status;

        if (status.isHasData) {
          authRouter.navigateToSplash();
          Phoenix.rebirth(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Container(
            margin: EdgeInsets.only(top: 16.h),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16.w),
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.account_circle,
                          size: 30,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        final status = state.profileState.status;

                        if (status.isLoading) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              FadeShimmer(
                                height: 10,
                                width: 150,
                                radius: 4,
                                highlightColor: grayColor,
                                baseColor: Color(0xffE6E8EB),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FadeShimmer(
                                height: 10,
                                width: 150,
                                radius: 4,
                                highlightColor: grayColor,
                                baseColor: Color(0xffE6E8EB),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FadeShimmer(
                                height: 10,
                                width: 150,
                                radius: 4,
                                highlightColor: grayColor,
                                baseColor: Color(0xffE6E8EB),
                              ),
                            ],
                          );
                        } else if (status.isHasData) {
                          final profile = state.profileState.data;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${profile?.name.firstname} ${profile?.name.lastname}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                              ),
                              Text(
                                "${profile?.phone}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(),
                              ),
                              Text(
                                "${profile?.email}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(),
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    profileRouter.navigateToHistoryTransaction();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.history,
                          size: 30,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          "History Transactions",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    context.read<LogoutCubit>().logout();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.exit_to_app,
                          size: 30,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          "Sign out",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
