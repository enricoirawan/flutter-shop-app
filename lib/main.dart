import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/get_it.dart';
import 'package:flutter_shop_app/common/navigation/argument/checkout_argument.dart';
import 'package:flutter_shop_app/common/navigation/argument/detail_product_argument.dart';
import 'package:flutter_shop_app/common/navigation/navigation_helper.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/presentation/bloc/address_bloc/address_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/cart_bloc/cart_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/logout_bloc/logout_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/product_bloc/product_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/product_category/product_category_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/product_detail/product_detail_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/profile_bloc/profile_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/signin_bloc/signin_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/splash_bloc/splash_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/transaction_bloc/transaction_cubit.dart';
import 'package:flutter_shop_app/presentation/ui/checkout_screen.dart';
import 'package:flutter_shop_app/presentation/ui/detail_product_screen.dart';
import 'package:flutter_shop_app/presentation/ui/get_user_position.dart';
import 'package:flutter_shop_app/presentation/ui/history_transaction_screen.dart';
import 'package:flutter_shop_app/presentation/ui/main_screen.dart';
import 'package:flutter_shop_app/presentation/ui/onboard_screen.dart';
import 'package:flutter_shop_app/presentation/ui/payment_success_screen.dart';
import 'package:flutter_shop_app/presentation/ui/signin_screen.dart';
import 'package:flutter_shop_app/presentation/ui/splash_screen.dart';

import 'common/navigation/router/app_routes.dart';
import 'di/injection.dart';
import 'presentation/bloc/bottom_nav_bloc/bottom_nav_cubit.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection().initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  runApp(Phoenix(child: const MyApp()));
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
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => SplashCubit(
                getTokenCase: sl(),
                getCacheUserAddressStatusUseCase: sl(),
              )..initSplashScreen(),
            ),
            BlocProvider(
              create: (_) => SignInCubit(
                cacheTokenUseCase: sl(),
                cacheUserIdUseCase: sl(),
                signInUseCase: sl(),
                getCacheUserAddressStatusUseCase: sl(),
              ),
            ),
            BlocProvider(
              create: (_) => AddressCubit(
                getUserPositionUseCase: sl(),
                saveUserAddressUseCase: sl(),
                cacheGetUserAddressUseCase: sl(),
                getUserAddressUseCase: sl(),
              ),
            ),
            BlocProvider(
              create: (_) => BottomNavCubit(),
            ),
            BlocProvider(
              create: (_) => ProductCategoryCubit(
                getAllCategoriesUseCase: sl(),
              )..getAllCategories(),
            ),
            BlocProvider(
              create: (_) => ProductCubit(
                getAllProductsUseCase: sl(),
              )..getAllProducts("All"),
            ),
            BlocProvider(
              create: (_) => ProductDetailCubit(
                getProductDetailUseCase: sl(),
              ),
            ),
            BlocProvider(
              create: (_) => ProfileCubit(
                getProfileUseCase: sl(),
                getUserIdCase: sl(),
              )..getProfile(),
            ),
            BlocProvider(
              create: (_) => CartCubit(
                getAllCartsUseCase: sl(),
                insertCartsUseCase: sl(),
                updateCartUseCase: sl(),
                deleteCartUseCase: sl(),
              ),
            ),
            BlocProvider(
              create: (_) => LogoutCubit(
                logoutUseCase: sl(),
              ),
            ),
            BlocProvider(
              create: (_) => TransactionCubit(
                getAllTransactionsUseCase: sl(),
                insertTransactionUseCase: sl(),
                clearCartUseCase: sl(),
              ),
            ),
          ],
          child: MaterialApp(
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
            home: const SplashScreen(),
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
                      return const SignInScreen();
                    },
                  );
                case AppRoutes.getUserAddress:
                  return MaterialPageRoute(
                    builder: (_) {
                      return const GetUserPositionScreen();
                    },
                  );
                case AppRoutes.main:
                  return MaterialPageRoute(
                    builder: (_) {
                      return const MainScreen();
                    },
                  );
                case AppRoutes.detailProduct:
                  return MaterialPageRoute(
                    builder: (_) {
                      return DetailProductScreen(
                        argument: argument as DetailProductArgument,
                      );
                    },
                  );
                case AppRoutes.checkout:
                  return MaterialPageRoute(
                    builder: (_) {
                      return CheckoutScreen(
                        checkoutArgument: argument as CheckoutArgument,
                      );
                    },
                  );
                case AppRoutes.paymentSuccess:
                  return MaterialPageRoute(
                    builder: (_) {
                      return const PaymentSuccess();
                    },
                  );
                case AppRoutes.historyTransactions:
                  return MaterialPageRoute(
                    builder: (_) {
                      return const HistoryTransactionScreen();
                    },
                  );
              }
              return null;
            },
          ),
        );
      },
    );
  }
}
