import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mvvmapp/app/app_prefs.dart';
import 'package:mvvmapp/data/data_source/remote_data_source.dart';
import 'package:mvvmapp/data/network/app_api.dart';
import 'package:mvvmapp/data/network/dio_factory.dart';
import 'package:mvvmapp/data/network/network_info.dart';
import 'package:mvvmapp/data/repository/repository_impl.dart';
import 'package:mvvmapp/domain/repository/repository.dart';
import 'package:mvvmapp/domain/usecase/forgot_password_usecase.dart';
import 'package:mvvmapp/domain/usecase/login_usecase.dart';
import 'package:mvvmapp/presentation/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:mvvmapp/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getItInstance = GetIt.instance;
Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  getItInstance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  getItInstance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(getItInstance<SharedPreferences>()));

  getItInstance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  getItInstance.registerLazySingleton<DioFactory>(
      () => DioFactory(getItInstance<AppPreferences>()));

  Dio dio = await getItInstance<DioFactory>().getDio();

  getItInstance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  getItInstance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(getItInstance<AppServiceClient>()));

  getItInstance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(getItInstance<RemoteDataSource>(), getItInstance<NetworkInfo>()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    getItInstance.registerFactory<LoginUseCase>(
        () => LoginUseCase(getItInstance<Repository>()));
    getItInstance.registerFactory<LoginViewModel>(
        () => LoginViewModel(getItInstance<LoginUseCase>()));
  }
}
void initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    getItInstance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(getItInstance<Repository>()));
    getItInstance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(getItInstance<ForgotPasswordUseCase>()));
  }
}
