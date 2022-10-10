import 'package:dio/dio.dart';
import 'package:flutter_shop_app/common/navigation/router/cart_route.dart';
import 'package:flutter_shop_app/common/navigation/router/checkout_route.dart';
import 'package:flutter_shop_app/common/navigation/router/home_route.dart';
import 'package:flutter_shop_app/data/datasource/local/address_local_datasources.dart';
import 'package:flutter_shop_app/data/datasource/local/cart_local_datasource.dart';
import 'package:flutter_shop_app/data/datasource/local/transaction_local_datasources.dart';
import 'package:flutter_shop_app/data/datasource/remote/address_remote_datasouces.dart';
import 'package:flutter_shop_app/data/datasource/remote/product_remote_datasources.dart';
import 'package:flutter_shop_app/data/datasource/remote/profile_remote_datasource.dart';
import 'package:flutter_shop_app/data/repository/address_repository_impl.dart';
import 'package:flutter_shop_app/data/repository/authentication_repository_impl.dart';
import 'package:flutter_shop_app/data/repository/cart_repository_impl.dart';
import 'package:flutter_shop_app/data/repository/product_repository_impl.dart';
import 'package:flutter_shop_app/data/repository/profile_repository_impl.dart';
import 'package:flutter_shop_app/data/repository/transaction_repository_impl.dart';
import 'package:flutter_shop_app/domain/repository/address_repository.dart';
import 'package:flutter_shop_app/domain/repository/authentication_repository.dart';
import 'package:flutter_shop_app/domain/repository/cart_repository.dart';
import 'package:flutter_shop_app/domain/repository/product_repository.dart';
import 'package:flutter_shop_app/domain/repository/profile_repository.dart';
import 'package:flutter_shop_app/domain/repository/transaction_repository.dart';
import 'package:flutter_shop_app/domain/usecase/cache_get_user_address_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/cache_token_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/cache_user_id_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/clear_cart_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_all_carts_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_all_categories_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_all_products_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_all_transactions_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_profile_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_token_use_case.dart';
import 'package:flutter_shop_app/domain/usecase/get_user_address_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_user_id_use_case.dart';
import 'package:flutter_shop_app/domain/usecase/get_user_position_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/insert_cart_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/insert_transaction_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/logout_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/save_user_address_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/sign_in_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/update_cart_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/navigation/navigation_helper.dart';
import '../common/navigation/router/auth_route.dart';
import '../core/database/database.dart';
import '../core/network/dio_handler.dart';
import '../common/get_it.dart';
import '../data/datasource/local/authentication_local_datasources.dart';
import '../data/datasource/remote/authentication_remote_datasources.dart';
import '../domain/usecase/delete_cart_usecase.dart';
import '../domain/usecase/get_cache_user_address_status_usecase.dart';
import '../domain/usecase/get_product_detail_usecase.dart';

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

    sl.registerLazySingleton<AddressLocalDataSources>(
      () => AddressLocalDataSourcesImpl(sharedPreferences: sl()),
    );

    sl.registerLazySingleton<AddressRemoteDataSources>(
      () => AddressRemoteDataSourcesImpl(),
    );

    sl.registerLazySingleton<ProductRemoteDataSources>(
      () => ProductRemoteDataSourcesImpl(dio: sl()),
    );

    sl.registerLazySingleton<ProfileRemoteDataSources>(
      () => ProfileRemoteDataSourcesImpl(dio: sl()),
    );

    sl.registerLazySingleton<CartLocalDataSources>(
      () => CartLocalDataSourcesImpl(appDatabase: sl()),
    );

    sl.registerLazySingleton<TransactionLocalDataSources>(
      () => TransactionLocalDataSourcesImpl(appDatabase: sl()),
    );

    sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
        authenticationLocalDataSource: sl(),
        authenticationRemoteDataSource: sl(),
      ),
    );

    sl.registerLazySingleton<AddressRepository>(
      () => AddressRepositoryImpl(
        addressLocalDataSources: sl(),
        addressRemoteDataSources: sl(),
      ),
    );

    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productRemoteDataSources: sl()),
    );

    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(profileRemoteDataSources: sl()),
    );

    sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(cartLocalDataSources: sl()),
    );

    sl.registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(transactionLocalDataSources: sl()),
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
    sl.registerLazySingleton<GetUserIdUseCase>(
      () => GetUserIdUseCase(
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
    sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetUserAddressUseCase>(
      () => GetUserAddressUseCase(
        addressRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetCacheUserAddressStatusUseCase>(
      () => GetCacheUserAddressStatusUseCase(
        addressRepository: sl(),
      ),
    );
    sl.registerLazySingleton<CacheGetUserAddressUseCase>(
      () => CacheGetUserAddressUseCase(
        addressRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetUserPositionUseCase>(
      () => GetUserPositionUseCase(
        addressRepository: sl(),
      ),
    );
    sl.registerLazySingleton<SaveUserAddressUseCase>(
      () => SaveUserAddressUseCase(
        addressRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetAllCategoriesUseCase>(
      () => GetAllCategoriesUseCase(
        productRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetAllProductsUseCase>(
      () => GetAllProductsUseCase(
        productRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetProductDetailUseCase>(
      () => GetProductDetailUseCase(
        productRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(
        profileRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetAllCartsUseCase>(
      () => GetAllCartsUseCase(
        cartRepository: sl(),
      ),
    );
    sl.registerLazySingleton<InsertCartsUseCase>(
      () => InsertCartsUseCase(
        cartRepository: sl(),
      ),
    );
    sl.registerLazySingleton<UpdateCartUseCase>(
      () => UpdateCartUseCase(
        cartRepository: sl(),
      ),
    );
    sl.registerLazySingleton<DeleteCartUseCase>(
      () => DeleteCartUseCase(
        cartRepository: sl(),
      ),
    );
    sl.registerLazySingleton<ClearCartUseCase>(
      () => ClearCartUseCase(
        cartRepository: sl(),
      ),
    );
    sl.registerLazySingleton<InsertTransactionUseCase>(
      () => InsertTransactionUseCase(
        transactionRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetAllTransactionsUseCase>(
      () => GetAllTransactionsUseCase(
        transactionRepository: sl(),
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

    final AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    sl.registerLazySingleton<AppDatabase>(() => database);
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

    sl.registerLazySingleton<HomeRouter>(
      () => HomeRouterImpl(
        navigationHelper: sl(),
      ),
    );

    sl.registerLazySingleton<CartRouter>(
      () => CartRouterImpl(
        navigationHelper: sl(),
      ),
    );

    sl.registerLazySingleton<CheckoutRouter>(
      () => CheckoutRouterImpl(
        navigationHelper: sl(),
      ),
    );
  }
}
