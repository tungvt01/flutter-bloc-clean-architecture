import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:todos/core/network/network_status.dart';
import 'package:todos/data/local/index.dart';
import 'package:todos/presentation/page/login/index.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

GetIt injector = GetIt.asNewInstance();

initInjector() {
  // Utils
  injector.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  injector.registerLazySingleton<Connectivity>(() => Connectivity());
  //API
  injector.registerLazySingleton<NetworkStatus>(
      () => NetworkStatusImpl(injector(), injector()));

//Cache
  injector
      .registerFactory<LocalDataStorage>(() => SharePreferenceStorageImpl());

// Repository

//Bloc
  injector.registerFactory<LoginBloc>(() => LoginBloc());

}
