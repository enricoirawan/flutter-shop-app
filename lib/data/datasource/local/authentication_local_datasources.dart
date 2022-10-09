import 'package:flutter_shop_app/common/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/failure.dart';

abstract class AuthenticationLocalDataSource {
  const AuthenticationLocalDataSource();

  Future<bool> cacheToken({required String token});
  Future<bool> cacheUserId({required String userId});
  Future<String> getUserId();
  Future<String> getToken();
  Future<bool> logout();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthenticationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cacheToken({
    required String token,
  }) async {
    return await sharedPreferences.setString(
      AppConstants.cachedKey.tokenKey,
      token,
    );
  }

  @override
  Future<bool> cacheUserId({required String userId}) async {
    return await sharedPreferences.setString(
      AppConstants.cachedKey.userId,
      userId,
    );
  }

  @override
  Future<String> getUserId() async {
    try {
      return sharedPreferences.getString(AppConstants.cachedKey.userId) ?? "";
    } catch (_) {
      throw DatabaseFailure(AppConstants.errorMessage.failedGetUserId);
    }
  }

  @override
  Future<String> getToken() async {
    try {
      return sharedPreferences.getString(AppConstants.cachedKey.tokenKey) ?? "";
    } catch (_) {
      throw DatabaseFailure(AppConstants.errorMessage.failedGetToken);
    }
  }

  @override
  Future<bool> logout() {
    try {
      return sharedPreferences.clear();
    } catch (_) {
      throw DatabaseFailure(AppConstants.errorMessage.logoutFailed);
    }
  }
}
