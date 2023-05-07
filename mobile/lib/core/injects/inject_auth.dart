import 'package:auto_park/features/cadastro/cubit/cadastro_cubit.dart';
import 'package:auto_park/core/data/datasources/auth_datasource.dart';
import 'package:auto_park/core/data/repositories/auth_repository_imp.dart';
import 'package:auto_park/core/domain/repositories/auth_repository.dart';
import 'package:auto_park/core/domain/usecases/auth_usecase.dart';
import 'package:auto_park/features/login/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';

void injectAuth(GetIt getIt) {
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImp(getIt()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(getIt()));
  getIt.registerLazySingleton<AuthUseCase>(() => AuthUseCaseImp(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(
      authUseCase: getIt(),
      firebaseMessagingService: getIt(),
      fcmUseCase: getIt()));
  getIt.registerFactory<CadastroCubit>(
      () => CadastroCubit(authUseCase: getIt()));
}
