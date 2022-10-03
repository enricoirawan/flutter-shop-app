class AppConstants {
  const AppConstants();

  static CachedKey cachedKey = const CachedKey();
}

class CachedKey {
  const CachedKey();

  String get onBoardingKey => 'onBoardingKey';
  String get tokenKey => 'tokenKey';
}

class AppApi {
  const AppApi();

  String get baseUrl => 'https://fakestoreapi.com/';

  String get signIn => 'auth/login';
}
