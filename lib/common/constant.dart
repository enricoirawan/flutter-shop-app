class AppConstants {
  const AppConstants();

  static CachedKey cachedKey = const CachedKey();
  static AppApi appApi = const AppApi();
  static ErrorMessage errorMessage = const ErrorMessage();
}

class CachedKey {
  const CachedKey();

  String get onBoardingKey => 'onBoardingKey';
  String get tokenKey => 'tokenKey';
  String get userId => 'userId';
}

class AppApi {
  const AppApi();

  String get baseUrl => 'https://fakestoreapi.com/';

  String get signIn => 'auth/login';
}

class ErrorMessage {
  const ErrorMessage();

  String get usernameEmpty => "username must not empty";

  String get passwordEmpty => "password must not empty";

  String get formNotEmpty => "username and password must not empty";

  String get failedGetOnBoarding => 'failed get onboarding status';

  String get failedGetToken => 'failed get token';

  String get failedGetUserId => 'failed get user id';
}
