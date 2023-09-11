import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ride_sharing_user_app/authenticate/domain/use-cases/auth_cases.dart';

import 'authenticate/data/repo-imp/auth_repo_imp.dart';
import 'authenticate/data/services/local/local_auth.dart';
import 'authenticate/data/services/remote/remote_auth.dart';
import 'authenticate/domain/repo/auth_repo.dart';

import 'networking/dio_client.dart';

final sl = GetIt.instance;

final getIt = sl();
Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(DioClient.instance);

  sl.registerLazySingleton<RemoteApiAuth>(() => RemoteApiAuth(sl()));

  sl.registerLazySingleton<LocalAuth>(() => LocalAuth());

  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      remoteApiAuth: sl(),
      localAuth: sl(),
    ),
  );

  sl.registerLazySingleton<AuthCases>(
      () => AuthCases(sl()));


}
