import 'package:auto_park/core/data/datasources/registros_datasource.dart';
import 'package:auto_park/core/data/repositories/registros_repository_imp.dart';
import 'package:auto_park/core/domain/repositories/registros_repository.dart';
import 'package:auto_park/core/domain/usecases/registros_usecase.dart';
import 'package:auto_park/features/registros/cubit/registros_cubit.dart';
import 'package:get_it/get_it.dart';

void injectRegistros(GetIt getIt) {
  getIt.registerLazySingleton<RegistrosDataSource>(
      () => RegistrosDataSourceImp(getIt()));
  getIt.registerLazySingleton<RegistrosRepository>(
      () => RegistrosRepositoryImp(getIt()));
  getIt.registerLazySingleton<RegistrosUseCase>(
      () => RegistrosUseCaseImp(getIt()));

  getIt.registerFactory<RegistrosCubit>(
      () => RegistrosCubit(registrosUseCase: getIt()));
}
