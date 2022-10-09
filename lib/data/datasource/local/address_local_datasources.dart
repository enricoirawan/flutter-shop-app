import 'package:flutter_shop_app/common/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/failure.dart';

abstract class AddressLocalDataSources {
  const AddressLocalDataSources();

  Future<bool> saveUserAddress(String address);
  Future<bool> cacheGetUserAddress();
  Future<String> getUserAddress();
  Future<bool> getCacheUserAddressStatus();
}

class AddressLocalDataSourcesImpl implements AddressLocalDataSources {
  final SharedPreferences sharedPreferences;

  AddressLocalDataSourcesImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> saveUserAddress(String address) async {
    return await sharedPreferences.setString(
      AppConstants.cachedKey.addressKey,
      address,
    );
  }

  @override
  Future<bool> cacheGetUserAddress() async {
    return await sharedPreferences.setBool(
      AppConstants.cachedKey.cacheGetUserAddressKey,
      true,
    );
  }

  @override
  Future<String> getUserAddress() async {
    try {
      return sharedPreferences.getString(AppConstants.cachedKey.addressKey) ??
          "";
    } catch (_) {
      throw DatabaseFailure(AppConstants.errorMessage.failedGetAddress);
    }
  }

  @override
  Future<bool> getCacheUserAddressStatus() async {
    try {
      return sharedPreferences
              .getBool(AppConstants.cachedKey.cacheGetUserAddressKey) ??
          false;
    } catch (e) {
      throw DatabaseFailure(AppConstants.errorMessage.failedGetAddress);
    }
  }
}
