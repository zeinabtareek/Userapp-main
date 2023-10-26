import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ride_sharing_user_app/authenticate/domain/use-cases/auth_cases.dart';
import 'package:ride_sharing_user_app/helper/network/dio_integration.dart';

import 'authenticate/data/repo-imp/auth_repo_imp.dart';
import 'authenticate/data/services/local/local_auth.dart';
import 'authenticate/data/services/remote/remote_auth.dart';
import 'authenticate/domain/repo/auth_repo.dart';

import 'helper/cache_helper.dart';
import 'networking/dio_client.dart';

final sl = GetIt.instance;

final getIt = sl();
Future<void> initializeDependencies() async {
   CacheHelper.init();
  sl.registerSingleton<Dio>(DioUtilNew.dio!);

  sl.registerLazySingleton<RemoteApiAuth>(() => RemoteApiAuth(sl()));

  sl.registerLazySingleton<LocalAuth>(() => LocalAuth());
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );
  sl.registerLazySingleton<SecureLocalAuth>(() => SecureLocalAuth(sl()));
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      remoteApiAuth: sl(),
      localAuth: sl(),
      secureLocalAuth: sl(),
    ),
  );

  sl.registerLazySingleton<AuthCases>(() => AuthCases(sl()));
}
