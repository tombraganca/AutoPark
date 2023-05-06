import 'package:auto_park/core/data/datasources/vagas_datasource.dart';
import 'package:auto_park/core/data/repositories/vagas_repository_imp.dart';
import 'package:auto_park/core/domain/repositories/vagas_respository.dart';
import 'package:auto_park/core/domain/usecases/vagas_usecase.dart';
import 'package:auto_park/vagas/cubit/vagas_cubit.dart';
import 'package:get_it/get_it.dart';

void injectVagas(GetIt getIt) {
  getIt.registerLazySingleton<VagasDataSource>(
      () => VagasDataSourceImp(getIt()));

  getIt.registerLazySingleton<VagasRepository>(
      () => VagasRepositoryImp(getIt()));

  getIt.registerLazySingleton<VagasUseCase>(() => VagasUseCaseImp(getIt()));

  getIt.registerFactory<VagasCubit>(() => VagasCubit(vagasUseCase: getIt()));
}
