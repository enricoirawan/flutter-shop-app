class AppConstants {
  const AppConstants();

  static CachedKey cachedKey = const CachedKey();
  static AppApi appApi = const AppApi();
  static ErrorMessage errorMessage = const ErrorMessage();
  static SuccessMessage successMessage = const SuccessMessage();
}

class CachedKey {
  const CachedKey();

  String get onBoardingKey => 'onBoardingKey';
  String get tokenKey => 'tokenKey';
  String get userId => 'userId';
  String get cacheGetUserAddressKey => "cacheGetUserAddressKey";
  String get addressKey => 'addressKey';
}

class AppApi {
  const AppApi();

  String get baseUrl => 'https://fakestoreapi.com/';

  String get signIn => 'auth/login';

  String get categories => 'products/categories';

  String get products => 'products/';

  String get profile => 'users/';
}

class ErrorMessage {
  const ErrorMessage();

  String get usernameEmpty => "username must not empty";

  String get passwordEmpty => "password must not empty";

  String get formNotEmpty => "username and password must not empty";

  String get failedGetOnBoarding => 'failed get onboarding status';

  String get failedGetToken => 'failed get token';

  String get failedGetAddress => 'failed get address';

  String get failedGetUserAddressStatus => 'failed get user address status';

  String get failedGetUserId => 'failed get user id';

  String get failedGetCarts => 'failed get carts';

  String get failedInsertCart => 'failed insert cart';

  String get productAlredyExistOnTheCart => 'product alredy exist on the cart';

  String get failedUpdateCart => 'failed update cart';

  String get failedDeleteCart => 'failed delete carts';

  String get signUpFeature => 'sign up feature not ready yet';

  String get loginWithGoogle => 'login with google feature not ready yet';

  String get loginWithFacebook => 'login with facebook feature not ready yet';
}

class SuccessMessage {
  const SuccessMessage();

  String get saveAddressSuccess => "Address have set successfully";

  String get successDeletedProduct => "Product has been deleted";
}
