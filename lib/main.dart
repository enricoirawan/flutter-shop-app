import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/get_it.dart';
import 'package:flutter_shop_app/common/navigation/navigation_helper.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/presentation/bloc/signin_bloc/signin_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/splash_bloc/splash_cubit.dart';
import 'package:flutter_shop_app/presentation/ui/main_screen.dart';
import 'package:flutter_shop_app/presentation/ui/onboard_screen.dart';
import 'package:flutter_shop_app/presentation/ui/signin_screen.dart';
import 'package:flutter_shop_app/presentation/ui/splash_screen.dart';

import 'common/navigation/router/app_routes.dart';
import 'di/injection.dart';
import 'presentation/bloc/bottom_nav_bloc/bottom_nav_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Shop App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: primaryColor,
                  onPrimary: Colors.black,
                  secondary: secondaryColor,
                  background: Colors.white,
                ),
            textTheme: myTextTheme,
          ),
          navigatorKey: NavigationHelperImpl.navigatorKey,
          home: BlocProvider(
            create: (_) => SplashCubit(
              getTokenCase: sl(),
            )..initSplashScreen(),
            child: const SplashScreen(),
          ),
          onGenerateRoute: (RouteSettings settings) {
            final argument = settings.arguments;
            switch (settings.name) {
              case AppRoutes.splash:
                return MaterialPageRoute(
                  builder: (_) {
                    return const SplashScreen();
                  },
                );
              case AppRoutes.onboarding:
                return MaterialPageRoute(
                  builder: (_) {
                    return const OnBoardScreen();
                  },
                );
              case AppRoutes.signIn:
                return MaterialPageRoute(
                  builder: (_) {
                    return BlocProvider(
                      create: (_) => SignInCubit(
                        cacheTokenUseCase: sl(),
                        cacheUserIdUseCase: sl(),
                        signInUseCase: sl(),
                      ),
                      child: const SignInScreen(),
                    );
                  },
                );
              case AppRoutes.main:
                return MaterialPageRoute(
                  builder: (_) {
                    return BlocProvider(
                      create: (context) => BottomNavCubit(),
                      child: const MainScreen(),
                    );
                  },
                );
            }
            return null;
          },
        );
      },
    );
  }
}
