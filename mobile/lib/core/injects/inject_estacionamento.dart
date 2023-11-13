import 'package:auto_park/core/data/datasources/estacionamento_datasource.dart';
import 'package:auto_park/core/data/repositories/estacionamento_repository_imp.dart';
import 'package:auto_park/core/domain/repositories/estacionamento_repository.dart';
import 'package:auto_park/core/domain/usecases/estacionamento_usecase.dart';
import 'package:auto_park/features/estacionamentos/cubit/estacionamento_cubit.dart';
import 'package:get_it/get_it.dart';

void injectEstacionamento(GetIt getIt) {
  getIt
    ..registerLazySingleton<EstacionamentoDataSource>(
        () => EstacionamentoDataSourceImp(getIt()))
    ..registerLazySingleton<EstacionamentoRepository>(
        () => EstacionamentoRepositoryImp(getIt()))
    ..registerLazySingleton<EstacionamentoUseCase>(
        () => EstacionamentoUseCaseImp(getIt()))
    ..registerFactory<EstacionamentoCubit>(
        () => EstacionamentoCubit(estacionamentoUseCase: getIt()));
}
