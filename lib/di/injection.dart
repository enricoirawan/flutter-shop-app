import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/network/dio_handler.dart';
import '../common/get_it.dart';

class Injection {
  Future<void> initialize() async {
    await _registerCore();
    _registerData();
    _registerDomain();
  }

  void _registerData() {}

  void _registerDomain() {}

  Future<void> _registerCore() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton<Dio>(() => sl<DioHandler>().dio);
    sl.registerLazySingleton<DioHandler>(() => DioHandler(
          apiBaseUrl: '',
        ));
  }
}
