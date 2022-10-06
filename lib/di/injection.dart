import 'package:dio/dio.dart';
import 'package:flutter_shop_app/data/repository/authentication_repository_impl.dart';
import 'package:flutter_shop_app/domain/repository/authentication_repository.dart';
import 'package:flutter_shop_app/domain/usecase/cache_token_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/cache_user_id_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_token_use_case.dart';
import 'package:flutter_shop_app/domain/usecase/get_user_id_use_case.dart';
import 'package:flutter_shop_app/domain/usecase/sign_in_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/navigation/navigation_helper.dart';
import '../common/navigation/router/auth_route.dart';
import '../core/network/dio_handler.dart';
import '../common/get_it.dart';
import '../data/datasource/local/authentication_local_datasources.dart';
import '../data/datasource/remote/authentication_in_remote_datasources.dart';

class Injection {
  Future<void> initialize() async {
    await _registerCore();
    _registerData();
    _registerDomain();
    _registerCommon();
  }

  void _registerData() {
    sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl(
        sharedPreferences: sl(),
      ),
    );

    sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(dio: sl()),
    );

    sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
        authenticationLocalDataSource: sl(),
        authenticationRemoteDataSource: sl(),
      ),
    );
  }

  void _registerDomain() {
    sl.registerLazySingleton<CacheTokenUseCase>(
      () => CacheTokenUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<CacheUserIdUseCase>(
      () => CacheUserIdUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetUserIdCase>(
      () => GetUserIdCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetTokenUseCase>(
      () => GetTokenUseCase(
        authenticationRepository: sl(),
      ),
    );
  }

  Future<void> _registerCore() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton<DioHandler>(
      () => DioHandler(
        apiBaseUrl: '',
      ),
    );
    sl.registerLazySingleton<Dio>(() => sl<DioHandler>().dio);
  }

  void _registerCommon() {
    sl.registerLazySingleton<NavigationHelper>(
      () => NavigationHelperImpl(),
    );

    sl.registerLazySingleton<AuthRouter>(
      () => AuthRouterImpl(
        navigationHelper: sl(),
      ),
    );
  }
}
